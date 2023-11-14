// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:innovation_project/pages/healthgpt_page.dart';
import 'package:innovation_project/pages/term_and_condition_page.dart';
import 'package:innovation_project/providers/health_providers.dart';

import 'package:innovation_project/widgets/custom_app_bar.dart';
import 'package:innovation_project/widgets/fitness_tile.dart';
import 'package:health/health.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HealthDataProvider healthDataProvider = HealthDataProvider();

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      // Set the background color to black
      backgroundColor: Colors.black,
      // Use the custom AppBar with a logo
      appBar: CustomAppBar(withIcon: "refresh", onIconPressed: fetchHealthData),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HealthGpt(healthDataProvider: healthDataProvider),
                  ),
                );
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Chat with MAINDFUL",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "Steps: ${healthDataProvider.steps}",
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "V02Max AVG: ${healthDataProvider.v02Max}",
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "Hearth Rate: ${healthDataProvider.heartRate} BPM",
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "Sleep: ${healthDataProvider.sleepData}",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
