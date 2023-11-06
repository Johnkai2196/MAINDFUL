// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:innovation_project/pages/healthgpt_page.dart';
import 'package:innovation_project/services/hearth_data_service.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';
import 'package:innovation_project/widgets/fitness_tile.dart';
import 'package:health/health.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void updateSteps(int steps) {
    setState(() {
      _nofSteps = steps;
    });
  }

  void updateV02Max(double v02Max) {
    setState(() {
      _v02Max = v02Max;
    });
  }

  void updateHearthRate(int hearthRate) {
    setState(() {
      _hearthRate = hearthRate;
    });
  }

  void updateSleep(String sleep) {
    setState(() {
      _sleep = sleep;
    });
  }

  @override
  void initState() {
    super.initState();
    authorize();
  }

  int _nofSteps = 0;
  double _v02Max = 0;
  int _hearthRate = 0;
  String _sleep = "";

  static final types = [
    HealthDataType.STEPS,
    HealthDataType.VO2MAX,
    HealthDataType.SLEEP_ASLEEP,
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
        fetchData();
      } catch (e) {
        print("Exception in authorize: $e");
      }
    }
  }

  Future fetchData() async {
    await fetchStepData(health, updateSteps);
    await fetchV02MaxData(health, updateV02Max);
    await fetchHearthRateData(health, updateHearthRate);
    await fetchSleepData(health, updateSleep);
    await fetchWeekHealthData(health);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the background color to black
      backgroundColor: Colors.black,
      // Use the custom AppBar with a logo
      appBar: CustomAppBar(withIcon: false, onIconPressed: fetchData),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HealthGpt()),
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
                  "Steps: $_nofSteps",
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "V02Max AVG: $_v02Max",
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "Hearth Rate: $_hearthRate BPM",
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "Sleep: $_sleep",
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
