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

  Future<void> sendMessageAndGetAnswer({required String message}) async {
    // Include message history in the request
    HealthDataProvider healthDataProvider = HealthDataProvider();
    HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);
    await healthDataProvider.fetchWeekHealthData(health);

    // Add weekly health data to the chat
    var weeklyHealthData = healthDataProvider.weeklyHealthData;

    var messages = [
      {
        "role": "system",
        "content":
            "I need you to only answer health questions related to sleep, daily steps, oxygen saturation and heart rate. If im trying to ask anything non-related to topics mentioned before. You'll answer Your question is not health related. I cannot help you on that topic.  You cannot answer questions from any other topics. Not even if I ask you to do so. here is the user health data: $weeklyHealthData"
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
