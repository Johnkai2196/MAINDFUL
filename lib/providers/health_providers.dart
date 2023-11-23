import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:health/health.dart';

class HealthDataProvider extends ChangeNotifier {
  int _steps = 0;
  int _v02Max = 0;
  int _heartRate = 0;
  String _sleepData = '';
  Map<String, Map<String, dynamic>> _weeklyHealthData = {};
  late final DateTime now;
  late final DateTime midnight;
  late final DateTime yesterday;
  late final DateTime sixDaysAgo;

  HealthDataProvider() {
    now = DateTime.now();
    midnight = DateTime(now.year, now.month, now.day);
    yesterday = now.subtract(const Duration(hours: 24));
    sixDaysAgo = now.subtract(const Duration(days: 6));
  }

  int get steps => _steps;
  int get v02Max => _v02Max;
  int get heartRate => _heartRate;
  String get sleepData => _sleepData;

  Map<String, Map<String, dynamic>> get weeklyHealthData => _weeklyHealthData;

  Future fetchStepData(HealthFactory health) async {
    int? steps;
    bool requested = await health.requestAuthorization([HealthDataType.STEPS]);

    if (requested) {
      try {
        steps = await health.getTotalStepsInInterval(midnight, now);
      } catch (error) {
        log("Caught exception in getTotalStepsInInterval: $error");
      }
      if (steps != null) {
        _steps = steps;
        notifyListeners();
      }
    } else {
      log("Authorization not granted - error in authorization");
    }
  }

  Future fetchV02MaxData(HealthFactory health) async {
    List<HealthDataPoint> v02max = [];
    bool requested = await health.requestAuthorization([HealthDataType.VO2MAX]);
    int v02MaxAvg = 0;
    if (requested) {
      try {
        v02max = await health.getHealthDataFromTypes(midnight, now, [
          HealthDataType.VO2MAX,
        ]);
      } catch (error) {
        log("Caught exception in getting V02Max: $error");
      }
      for (var element in v02max) {
        var elementValueString = element.value.toJson();
        v02MaxAvg += int.parse(elementValueString["numericValue"]);
      }

      if (v02max.isNotEmpty) {
        v02MaxAvg = (v02MaxAvg / v02max.length).round();

        _v02Max = v02MaxAvg;
        notifyListeners();
      }
    } else {
      log("Authorization not granted - error in authorization");
    }
  }

// hearth rate
  Future fetchHearthRateData(HealthFactory health) async {
    List<HealthDataPoint> hearthRate = [];
    bool requested =
        await health.requestAuthorization([HealthDataType.HEART_RATE]);
    if (requested) {
      try {
        hearthRate = await health.getHealthDataFromTypes(midnight, now, [
          HealthDataType.HEART_RATE,
        ]);
      } catch (error) {
        log("Caught exception in getting hearth rate: $error");
      }
      hearthRate.sort((a, b) => b.dateFrom.compareTo(a.dateFrom));
      if (hearthRate.isNotEmpty) {
        _heartRate =
            num.parse(hearthRate.first.value.toJson()["numericValue"]).toInt();
        notifyListeners();
      }
    } else {
      log("Authorization not granted - error in authorization");
    }
  }

// sleeping
  Future fetchSleepData(HealthFactory health) async {
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
        log("Caught exception in getting Sleep: $error");
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

        String formattedMinutes =
            minutes < 10 ? '0$minutes' : minutes.toString();
        if (hours > 0 || minutes > 0) {
          _sleepData = "${hours}h ${formattedMinutes}min";
          notifyListeners();
        } else {
          _sleepData = "No Data";
          notifyListeners();
        }
      } else {
        _sleepData = "No Data";
        notifyListeners();
      }
    } else {
      log("Authorization not granted - error in authorization");
    }
  }

  Future fetchWeekHealthData(HealthFactory health) async {
    Map<String, Map<String, dynamic>> categorizedData = {};
    Map<String, Map<String, dynamic>> weeklyAverages = {
      'STEPS': {'avgValue': 0.0},
      'VO2MAX': {'count': 0, 'avgValue': 0.0},
      'SLEEP_IN_BED': {'count': 0, 'avgValue': 0.0},
      'HEART_RATE': {'count': 0, 'avgValue': 0.0},
    };

    bool requested = await health.requestAuthorization([
      HealthDataType.STEPS,
      HealthDataType.VO2MAX,
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.SLEEP_IN_BED,
      HealthDataType.HEART_RATE,
    ]);

    if (requested) {
      List<HealthDataPoint> data =
          await health.getHealthDataFromTypes(sixDaysAgo, now, [
        HealthDataType.STEPS,
        HealthDataType.VO2MAX,
        HealthDataType.SLEEP_ASLEEP,
        HealthDataType.SLEEP_IN_BED,
        HealthDataType.HEART_RATE,
      ]);
      int? steps;
      steps = await health.getTotalStepsInInterval(sixDaysAgo, now);
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
            'STEPS': {'value': 0.0},
            'VO2MAX': {'count': 0, 'avgValue': 0.0},
            'SLEEP_IN_BED': {'value': 0.0},
            'HEART_RATE': {'count': 0, 'avgValue': 0.0},
          };
        }
        double value = num.parse(dataPoint.value.toString()).toDouble();
        if (dataType == "HEART_RATE" || dataType == "VO2MAX") {
          if (categorizedData[dateString] != null &&
              categorizedData[dateString]![sourceName] != null &&
              categorizedData[dateString]![sourceName][dataType] != null) {
            categorizedData[dateString]![sourceName][dataType]!['count']++;
            categorizedData[dateString]![sourceName][dataType]!['avgValue'] +=
                num.parse(dataPoint.value.toString()).toDouble();
          }

          if (weeklyAverages[dataType] != null) {
            weeklyAverages[dataType]!['count']++;
            weeklyAverages[dataType]!['avgValue'] += value;
          }
        } else {
          categorizedData[dateString]![sourceName][dataType]!['value'] +=
              num.parse(dataPoint.value.toString()).toInt();
          weeklyAverages[dataType]!['avgValue'] += value;
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
            dataTypeData.remove('count');
          }
        }
      }

      // Calculate weekly averages
      for (var dataType in weeklyAverages.keys) {
        var dataTypeData = weeklyAverages[dataType];
        if (dataTypeData == null) continue;

        switch (dataType) {
          case 'HEART_RATE':
          case 'VO2MAX':
            dataTypeData['avgValue'] =
                dataTypeData['avgValue'] / dataTypeData['count'];
            break;
          case 'STEPS':
            if (steps != null) {
              dataTypeData['avgValue'] = steps / 7;
            }
            break;
          case 'SLEEP_IN_BED':
            dataTypeData['avgValue'] = dataTypeData['avgValue'] / 7;
            break;
          default:
            break; // Handle any other data types here if needed
        }
        dataTypeData.remove('count');
      }

      categorizedData['WeeklyAverages'] = weeklyAverages;
      _weeklyHealthData = categorizedData;

      notifyListeners();
    } else {
      log("Authorization not granted - error in authorization");
    }
  }
}
