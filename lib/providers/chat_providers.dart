import 'package:flutter/widgets.dart';
import 'package:health/health.dart';
import 'package:innovation_project/models/chat_models.dart';
import 'package:innovation_project/providers/health_providers.dart';
import 'package:innovation_project/services/api_services.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [
    ChatModel(
        context:
            "MAINDFUL is powered by the OpenAI API. Data submitted here is not used for training OpenAI's models according to their terms and conditions. Currently, MAINDFUL is accessing your step count, sleep analysis, VO2MAX and heart rate all from data stored in the Health app. Remember to log your data and wear your Apple Watch throughout the day for the most accurate result",
        role: "assistant")
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
    chatList = [
      ChatModel(
          context:
              "MAINDFUL is powered by the OpenAI API. Data submitted here is not used for training OpenAI's models according to their terms and conditions. Currently, MAINDFUL is accessing your step count, sleep analysis, VO2MAX and heart rate all from data stored in the Health app. Remember to log your data and wear your Apple Watch throughout the day for the most accurate result",
          role: "assistant")
    ];
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
            "You are MAINDFUL health advisor, an enthusiastic, and expert caretaker.\n\nFollow these steps in order to provide as useful help to the user as possible:\n\nStep 1:\nHere's the health data from the last seven days that you need to analyze:\n $weeklyHealthData.\n\nStep 2: \nGiven the context, provide a short response that could answer the user's question. If the question is related to users' steps, sleep, VO2MAX or heartbeat, utilize the data given in “Step 1” in your answer.\n\nStep 3:\nIF numbers in the health data seem low, provide advice on how they can improve. Note that today's data might be incomplete and show lower values. Today's date is ${DateTime.now().toString()} . IF a value is zero, it means that the user has not logged any data for that day. DO NOT provide statistics."
      },
      ...messageHistory, // Include message history

      {
        "role": "user",
        "content":
            "If the question: [$message] is health-related. If it is, proceed to answer it. If it's not, refuse to answer the question politely. Do not answer questions from any other topics than health. Do not tell the user if it's health related or not. After completing this classification task, refer to the steps provided in the “system” role's message."
      }
    ];
    chatList.addAll(await ApiService.sendMessage(messages: messages));

    messageHistory.add({
      "role": "assistant",
      "content": chatList.last.context
    }); // Add assistant message to history
    notifyListeners();
  }
}
