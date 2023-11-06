// ignore_for_file: avoid_print

import 'package:health/health.dart';

final now = DateTime.now();
final midnight = DateTime(now.year, now.month, now.day);
final yesterday = now.subtract(const Duration(hours: 24));
final sixDaysAgo = now.subtract(const Duration(days: 6));

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

// sleeping
Future fetchSleepData(
    HealthFactory health, void Function(String sleepData) updateSleep) async {
  List<HealthDataPoint> sleep = [];
  bool requested = await health.requestAuthorization(
      [HealthDataType.SLEEP_ASLEEP, HealthDataType.SLEEP_IN_BED]);

  if (requested) {
    try {
      sleep = await health.getHealthDataFromTypes(yesterday, now, [
        HealthDataType.SLEEP_ASLEEP,
      ]);
      if (sleep.isEmpty) {
        sleep = await health.getHealthDataFromTypes(
            yesterday, now, [HealthDataType.SLEEP_IN_BED]);
      }
    } catch (error) {
      print("Caught exception in getting Sleep: $error");
    }

    if (sleep.isNotEmpty) {
      int totalMinutes = 0;
      String singleSourceName = "";
      Map<String, List<HealthDataPoint>> sourceNameToElements = {};

      for (var element in sleep) {
        var elementValueString = element.value.toJson();
        String sourceName = element.sourceName;
        if (sourceNameToElements.containsKey(sourceName)) {
          // This sourceName has been seen before, add the element to the existing list
          sourceNameToElements[sourceName]?.add(element);
        } else {
          // This sourceName is unique, create a new list with the element
          sourceNameToElements[sourceName] = [element];
        }
        if (singleSourceName == "") {
          singleSourceName =
              sourceName; // Set the single source name if it's the first one encountered.
        } else if (singleSourceName != sourceName) {
          singleSourceName =
              ""; // Reset to null if there are multiple source names.
          break; // Break the loop if multiple source names are encountered.
        }

        // Count total minutes
        totalMinutes += num.parse(elementValueString["numericValue"]).toInt();
      }

      if (singleSourceName == "") {
        sourceNameToElements.forEach((sourceName, elements) {
          elements.sort((a, b) => b.dateFrom.compareTo(a.dateFrom));
          var lastElement = elements.first;
          var firstElement = elements.last;
          var difference =
              lastElement.dateFrom.difference(firstElement.dateFrom);
          totalMinutes += difference.inMinutes;
        });
      }

      int hours = totalMinutes ~/ 60;
      int minutes = totalMinutes % 60;
      String formattedMinutes = minutes < 10 ? '0$minutes' : minutes.toString();
      print("Sleep: ${hours}h ${formattedMinutes}m");
      updateSleep("${hours}h ${formattedMinutes}m");
    }
  } else {
    print("Authorization not granted - error in authorization");
  }
}

Future<Map<String, Map<String, dynamic>>> fetchWeekHealthData(
    HealthFactory health) async {
  Map<String, Map<String, dynamic>> categorizedData = {};
  Map<String, Map<String, dynamic>> weeklyAverages = {
    'STEPS': {'count': 0, 'avgValue': 0.0},
    'VO2MAX': {'count': 0, 'avgValue': 0.0},
    'SLEEP_IN_BED': {'count': 0, 'avgValue': 0.0},
    'HEART_RATE': {'count': 0, 'avgValue': 0.0},
  };

  bool requested = await health.requestAuthorization([
    HealthDataType.STEPS,
    HealthDataType.VO2MAX,
    HealthDataType.SLEEP_IN_BED,
    HealthDataType.HEART_RATE,
  ]);

  if (requested) {
    List<HealthDataPoint> data =
        await health.getHealthDataFromTypes(sixDaysAgo, now, [
      HealthDataType.STEPS,
      HealthDataType.VO2MAX,
      HealthDataType.SLEEP_IN_BED,
      HealthDataType.HEART_RATE,
    ]);

    for (var dataPoint in data) {
      String dataType = dataPoint.typeString;
      DateTime date = dataPoint.dateFrom;
      String dateString = date.toLocal().toString().split(' ')[0];
      String sourceName = dataPoint.sourceName;
      data = HealthFactory.removeDuplicates(data);
      if (!categorizedData.containsKey(dateString)) {
        categorizedData[dateString] = {};
      }

      if (!categorizedData[dateString]!.containsKey(sourceName)) {
        categorizedData[dateString]![sourceName] = {
          'STEPS': {'count': 0},
          'VO2MAX': {'count': 0, 'avgValue': 0.0},
          'SLEEP_IN_BED': {'count': 0, 'avgValue': 0.0},
          'HEART_RATE': {'count': 0, 'avgValue': 0.0},
        };
      }

      if (dataType != "STEPS") {
        categorizedData[dateString]![sourceName][dataType]!['count']++;
        categorizedData[dateString]![sourceName][dataType]!['avgValue'] +=
            num.parse(dataPoint.value.toString()).toDouble();
        weeklyAverages[dataType]!['count']++;
        weeklyAverages[dataType]!['avgValue'] +=
            num.parse(dataPoint.value.toString()).toDouble();
      } else {
        categorizedData[dateString]![sourceName][dataType]!['count'] +=
            num.parse(dataPoint.value.toString()).toInt();

        weeklyAverages[dataType]!['count']++;
        weeklyAverages[dataType]!['avgValue'] +=
            num.parse(dataPoint.value.toString()).toDouble();
      }
    }

    for (var dateString in categorizedData.keys) {
      for (var sourceData in categorizedData[dateString]!.values) {
        for (var dataTypeData in sourceData.values) {
          if (dataTypeData.containsKey('count') &&
              dataTypeData['count'] > 0 &&
              dataTypeData.containsKey('avgValue')) {
            dataTypeData['avgValue'] =
                dataTypeData['avgValue'] / dataTypeData['count'];
          }
        }
      }
    }

    for (var dataTypeData in weeklyAverages.values) {
      if (dataTypeData.containsKey('count') && dataTypeData['count'] > 0) {
        dataTypeData['avgValue'] =
            dataTypeData['avgValue'] / dataTypeData['count'];
      }
    }

    categorizedData['WeeklyAverages'] = weeklyAverages;
    print(categorizedData);
    return categorizedData;
  } else {
    print("Authorization not granted - error in authorization");
    return {};
  }
}
