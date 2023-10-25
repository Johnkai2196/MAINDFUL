import 'dart:math';

import 'package:flutter/material.dart';
import 'package:innovation_project/pages/healthgpt_page.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';
import 'package:innovation_project/widgets/fitness_tile.dart';
import 'package:health/health.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchStepsData();
  }

  int _getSteps = 0;

  HealthFactory health = HealthFactory();
  Future fetchStepsData() async {
    int? steps;
    var types = [
      HealthDataType.STEPS,
    ];
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    var persmission = [HealthDataAccess.READ];
    bool request =
        await health.requestAuthorization(types, permissions: persmission);
    if (request) {
      try {
        steps = await health.getTotalStepsInInterval(
          start,
          now,
        );
      } catch (e) {
        log(e as num);
      }
      log("steps $steps" as num);
      setState(() {
        _getSteps = (steps == null) ? 0 : steps;
      });
    } else {
      log("request $request" as num);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      appBar: const CustomAppBar(
        withIcon: false,
      ), // Use the custom AppBar
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
            child: Text(_getSteps.toString(),
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
