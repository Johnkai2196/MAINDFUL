// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:innovation_project/providers/chat_providers.dart';
import 'package:innovation_project/providers/health_providers.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';
import 'package:innovation_project/widgets/fitness_tile.dart';
import 'package:health/health.dart';

// import 'package:innovation_project/constants/constants.dart';
// import 'package:innovation_project/pages/healthgpt_page.dart';

import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HealthDataProvider healthDataProvider = HealthDataProvider();
  ChatProvider chatProvider = ChatProvider();
  @override
  void initState() {
    super.initState();
    chatProvider.sendMessageAndGetAnswerKPI();
    authorize();
  }

  static final types = [
    HealthDataType.STEPS,
    HealthDataType.VO2MAX,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_IN_BED,
    HealthDataType.HEART_RATE,
  ];

  final permssions = types.map((e) => HealthDataAccess.READ_WRITE).toList();

  HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

  Future authorize() async {
    bool? hasPersmission =
        await health.hasPermissions(types, permissions: permssions);
    hasPersmission = false;
    if (!hasPersmission) {
      try {
        await health.requestAuthorization(types);
        fetchHealthData();
      } catch (e) {
        print("Exception in authorize: $e");
      }
    }
  }

  Future<void> fetchHealthData() async {
    await healthDataProvider.fetchStepData(health);
    await healthDataProvider.fetchV02MaxData(health);
    await healthDataProvider.fetchHearthRateData(health);
    await healthDataProvider.fetchSleepData(health);
    await healthDataProvider.fetchWeekHealthData(health);
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
                mainAxisSize:
                    MainAxisSize.min, // Adjust according to your needs
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
                            title: healthDataProvider.sleepData,
                          ),
                          HeartCard(
                            beats: healthDataProvider.heartRate == 0
                                ? 'No Data'
                                : '${healthDataProvider.heartRate} bpm',
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
                            contexts: chatProvider,
                            steps: healthDataProvider.steps == 0
                                ? 'No Data'
                                : '${healthDataProvider.steps}',
                          ),
                          BreathingCard(
                            breath: healthDataProvider.v02Max == 0
                                ? 'No Data'
                                : '${healthDataProvider.v02Max} VO₂max',
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
