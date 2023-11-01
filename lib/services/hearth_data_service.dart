// ignore_for_file: avoid_print

import 'package:health/health.dart';

final now = DateTime.now();
final midnight = DateTime(now.year, now.month, now.day);
final yesterday = now.subtract(const Duration(hours: 24));

/// Fetch steps from the health plugin and show them in the app.
Future fetchStepData(
    HealthFactory health, void Function(int steps) updateSteps) async {
  int? steps;
  bool requested = await health.requestAuthorization([HealthDataType.STEPS]);

  if (requested) {
    try {
      steps = await health.getTotalStepsInInterval(midnight, now);
    } catch (error) {
      print("Caught exception in getTotalStepsInInterval: $error");
    }
    if (steps != null) {
      print("Steps: $steps");
      updateSteps(steps);
    }
  } else {
    print("Authorization not granted - error in authorization");
  }
}

Future fetchV02MaxData(
    HealthFactory health, void Function(double v02Max) updateV02Max) async {
  List<HealthDataPoint> v02max = [];
  bool requested = await health.requestAuthorization([HealthDataType.VO2MAX]);
  double v02MaxAvg = 0;
  if (requested) {
    try {
      v02max = await health.getHealthDataFromTypes(midnight, now, [
        HealthDataType.VO2MAX,
      ]);
    } catch (error) {
      print("Caught exception in getting V02Max: $error");
    }
    for (var element in v02max) {
      var elementValueString = element.value.toJson();
      v02MaxAvg += num.parse(elementValueString["numericValue"]);
    }

    if (v02max.isNotEmpty) {
      v02MaxAvg = v02MaxAvg / v02max.length;
      print("V02Max: $v02MaxAvg");
      updateV02Max(v02MaxAvg);
    }
  } else {
    print("Authorization not granted - error in authorization");
  }
}

// hearth rate
Future fetchHearthRateData(HealthFactory health,
    void Function(int hearthRate) updateHearthRate) async {
  List<HealthDataPoint> hearthRate = [];
  bool requested =
      await health.requestAuthorization([HealthDataType.HEART_RATE]);
  if (requested) {
    try {
      hearthRate = await health.getHealthDataFromTypes(midnight, now, [
        HealthDataType.HEART_RATE,
      ]);
    } catch (error) {
      print("Caught exception in getting hearth rate: $error");
    }
    hearthRate.sort((a, b) => b.dateFrom.compareTo(a.dateFrom));
    if (hearthRate.isNotEmpty) {
      print("Hearth rate: ${hearthRate.first.value.toJson()["numericValue"]}");
      updateHearthRate(
          num.parse(hearthRate.first.value.toJson()["numericValue"]).toInt());
    }
  } else {
    print("Authorization not granted - error in authorization");
  }
}
