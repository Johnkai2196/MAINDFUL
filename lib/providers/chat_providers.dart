import 'package:flutter/widgets.dart';
import 'package:health/health.dart';
import 'package:innovation_project/models/chat_models.dart';
import 'package:innovation_project/providers/health_providers.dart';
import 'package:innovation_project/services/api_services.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [
    ChatModel(context: "Hi, I'm HealthGPT", role: "assistant")
  ];
  List<ChatModel> get getChatList => chatList;
  List<Map<String, dynamic>> messageHistory = [];

  void addUserMessage({required String message}) {
    chatList.add(ChatModel(context: message, role: "user"));
    messageHistory.add(
        {"role": "user", "content": message}); // Add user message to history
    notifyListeners();
  }

  void resetChat() {
    chatList = [ChatModel(context: "Hi, I'm HealthGPT", role: "assistant")];
    messageHistory = [];
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswer(
      {required String message, required weeklyHealthData}) async {
    // Include message history in the request

    var messages = [
      {
        "role": "system",
        "content":
            "You are MAINDFUL health advisor, an enthusiastic, and expert caretaker. First evaluate if the users question is health related. DO NOT answer questions that are not health-related. Given the context, provide a short response that could answer the users question. You are provided with users health data from last 7 days. IF numbers seem low, provide advice on how they can improve. Note that today's data might be incomplete and show lower values. todays date is ${DateTime.now().toString()} IF a value is zero, it means that the user has not logged any data for that day. DO NOT provide statistics. Here's the data from last seven days: $weeklyHealthData"
      },
      ...messageHistory, // Include message history
      {"role": "user", "content": message}
    ];

    chatList.addAll(await ApiService.sendMessage(messages: messages));
    messageHistory.add({
      "role": "assistant",
      "content": chatList.last.context
    }); // Add assistant message to history
    notifyListeners();
  }
}
