import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:innovation_project/providers/health_providers.dart';
import 'package:innovation_project/providers/quote_providers.dart';
import 'package:innovation_project/services/notification_api.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';
import 'package:innovation_project/widgets/fitness_tile.dart';
import 'package:health/health.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  HealthDataProvider healthDataProvider = HealthDataProvider();
  QuoteProvider quoteProvider = QuoteProvider();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    NotificationApi(context).initNotification();
    NotificationApi(context).cancelAllNotifications();
    authorize();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        NotificationApi(context).cancelAllNotifications();
        NotificationApi(context).scheduleNotification(
          title: 'MAINDFUL',
          body: 'Remember to check your AI powered health-analysis for today!',
        );
        break;
      case AppLifecycleState.resumed:
        NotificationApi(context).cancelAllNotifications();
        break;
      default:
        break;
    }
  }

  static final types = [
    HealthDataType.STEPS,
    HealthDataType.VO2MAX,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_IN_BED,
    HealthDataType.HEART_RATE,
  ];

  final permssions = types.map((e) => HealthDataAccess.READ).toList();

  HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

  Future authorize() async {
    bool? hasPersmission =
        await health.hasPermissions(types, permissions: permssions);
    hasPersmission = false;
    if (!hasPersmission) {
      try {
        await health.requestAuthorization(types);
        fetchHealthData();
        quoteProvider.sendMessageAndGetAnswerKPI();
      } catch (e) {
        log("Exception in authorize: $e");
      }
    }
  }

  Future<void> fetchHealthData() async {
    await healthDataProvider.fetchStepData(health);
    await healthDataProvider.fetchV02MaxData(health);
    await healthDataProvider.fetchHearthRateData(health);
    await healthDataProvider.fetchSleepData(health);
    await healthDataProvider.fetchWeekHealthData(health);
    quoteProvider.sendMessageAndGetAnswerHealth(healthDataProvider);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.95;
    double cardHeight = MediaQuery.of(context).size.height * 0.75;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
          withIcon: "refresh",
          onIconPressed: fetchHealthData,
          walkThrough: true),
      body: Stack(
        children: <Widget>[
          // Background image (SVG)
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/blob-scene-haikei (3).svg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 90.0, left: 16.0, right: 16.0),
              child: SvgPicture.asset(
                'assets/icons/robot-svgrepo-com (6).svg',
                height: 250,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ChatCard(healthDataProvider: healthDataProvider),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SleepCard(
                              quoteProvider: quoteProvider,
                              healthDataProvider: healthDataProvider),
                          HeartCard(
                            quoteProvider: quoteProvider,
                            healthDataProvider: healthDataProvider,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          StepsCard(
                              quoteProvider: quoteProvider,
                              healthDataProvider: healthDataProvider),
                          BreathingCard(
                            quoteProvider: quoteProvider,
                            healthDataProvider: healthDataProvider,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
