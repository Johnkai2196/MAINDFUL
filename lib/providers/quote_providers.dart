import 'package:flutter/material.dart';
import 'package:innovation_project/providers/health_providers.dart';
import 'package:innovation_project/services/api_services.dart';

class QuoteProvider extends ChangeNotifier {
  List<Map<String, String>> preQuote = [];
  List<Map<String, String>> get getQuoteList => preQuote;
  List<Map<String, String>> healthQuote = [];
  List<Map<String, String>> get gethealthQuoteList => healthQuote;

  Future<void> sendMessageAndGetAnswerKPI() async {
    Map<String, String> messageMap = {
      "Sleep": "Give me a 50 words long motivational text on sleep",
      "Heart rate": "Give me a 50 words long motivational text on heart rate",
      "VO2MAX": " Give me a 50 words long motivational text on VO2MAX",
      "Steps": "Give me a 50 words long motivational text on daily steps"
    };

    // Create a list of Future objects for each message
    List<Future> futures = messageMap.keys.map((key) async {
      var messages = [
        {"role": "user", "content": messageMap[key]}
      ];
      return ApiService.sendMessage(messages: messages, isInitialized: false);
    }).toList();

    // Use Future.wait to fetch all the messages at once
    var results = await Future.wait(futures);

    for (int i = 0; i < messageMap.keys.length; i++) {
      messageMap[messageMap.keys.elementAt(i)] = results[i];
    }

    // Add all the results to preQuote
    preQuote.add(Map.from(messageMap));

    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswerHealth(
      HealthDataProvider healthDataProvider) async {
    Map<String, String> messageMap = {
      "Sleep":
          "This is my healt sleep data ${healthDataProvider.sleepData}. How did I sleep last night? Keep the answer under 7 words long and do not include statistics. Only if you cannot find data for last night tell the user that there is no data available from last night.",
      "Heart rate":
          "This is my healt heart rate data ${healthDataProvider.heartRate}. How would you evaluate my average heart rate of today? Keep the answer under 7 words long and do not include statistics. Only if you cannot find data for my heart rate, tell the user that there is no data available.",
      "VO2MAX":
          "This is my healt VO2AX data ${healthDataProvider.v02Max}. General guideline for VO2MAX:\nExcellent: >60\nGood: 51-60\nAverage: 41-50\nFair: 31-40\nPoor: <30\n\nHow would you evaluate my VO2MAX of today in comparison to general guideline of vo2max? Keep the answer under 7 words long and do not include statistics. Only if you cannot find data for todays VO2MAX tell the user that there is no data available.",
      "Steps":
          "This is my healt step data ${healthDataProvider.steps}. How would you assess my step count for today? Keep the answer under 7 words long and do not include statistics. Only if you cannot find data for todays steps tell the user that there is no data available.",
    };

    // Create a list of Future objects for each message
    List<Future> futures = messageMap.keys.map((key) async {
      var messages = [
        {"role": "user", "content": messageMap[key]}
      ];
      return ApiService.sendMessage(messages: messages, isInitialized: false);
    }).toList();

    // Use Future.wait to fetch all the messages at once
    var results = await Future.wait(futures);

    for (int i = 0; i < messageMap.keys.length; i++) {
      messageMap[messageMap.keys.elementAt(i)] = results[i];
    }

    // Add all the results to preQuote
    healthQuote.add(Map.from(messageMap));

    notifyListeners();
  }
}
