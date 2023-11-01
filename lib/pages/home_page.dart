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

  @override
  void initState() {
    super.initState();
    authorize();
    fetchData();
  }

  int _nofSteps = 0;
  double _v02Max = 0;
  int _hearthRate = 0;

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
      } catch (e) {
        print("Exception in authorize: $e");
      }
    }
  }

  // sleeping
  Future fetchSleepData() async {
    List<HealthDataPoint> sleep = [];
    bool requested =
        await health.requestAuthorization([HealthDataType.SLEEP_ASLEEP]);
    final test = DateTime.now().subtract(const Duration(days: 7));
    if (requested) {
      try {
        sleep = await health.getHealthDataFromTypes(yesterday, now, [
          HealthDataType.SLEEP_ASLEEP,
        ]);
      } catch (error) {
        print("Caught exception in getting Sleep: $error");
      }

      if (sleep.isNotEmpty) {
        print("Sleep: $sleep");
      }
    } else {
      print("Authorization not granted - error in authorization");
    }
  }

  Future fetchData() async {
    await fetchStepData(health, updateSteps);
    await fetchV02MaxData(health, updateV02Max);
    await fetchHearthRateData(health, updateHearthRate);
    await fetchSleepData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      appBar: CustomAppBar(
          withIcon: false, onIconPressed: fetchData), // Use the custom AppBar
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
                TextButton(
                  onPressed: authorize,
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                  child: const Text(
                    "Auth",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text(
                  "Steps: $_nofSteps",
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "V02Max: $_v02Max",
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "Hearth Rate: $_hearthRate",
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
