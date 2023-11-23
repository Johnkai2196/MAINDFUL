import 'package:flutter/material.dart';
import 'package:innovation_project/providers/health_providers.dart';
import 'package:innovation_project/services/api_services.dart';

class QuoteProvider extends ChangeNotifier {
  List<Map<String, String>> preQuote = [];
  List<Map<String, String>> get getQuoteList => preQuote;
  List<Map<String, String>> healthQuote = [];
  List<Map<String, String>> get gethealthQuoteList => preQuote;

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
    print(healthDataProvider.heartRate);
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
    healthQuote.add(Map.from(messageMap));
    print(healthQuote);
    notifyListeners();
  }
}
