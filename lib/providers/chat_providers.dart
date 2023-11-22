import 'package:flutter/widgets.dart';
import 'package:innovation_project/constants/constants.dart';
import 'package:innovation_project/models/chat_models.dart';
import 'package:innovation_project/services/api_services.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [
    ChatModel(context: beginChat, role: "assistant"),
  ];
  List<ChatModel> promptlist = [
    ChatModel(context: "Daily summary", role: "prompt"),
    ChatModel(context: "Weekly summary", role: "prompt"),
    ChatModel(context: "On which aspect should I improve on?", role: "prompt"),
    ChatModel(context: "How do I compare to an average human", role: "prompt"),
  ];

  List<ChatModel> get getPromptList => promptlist;
  List<ChatModel> get getChatList => chatList;
  List<Map<String, dynamic>> messageHistory = [];
  List<Map<String, String>> preQuote = [];
  List<Map<String, String>> get getQuoteList => preQuote;

  void addUserMessage({required String message}) {
    chatList.add(ChatModel(context: message, role: "user"));
    messageHistory.add(
        {"role": "user", "content": message}); // Add user message to history
    notifyListeners();
  }

  void resetChat() {
    chatList = [
      ChatModel(context: beginChat, role: "assistant"),
    ];
    promptlist = [
      ChatModel(context: "Daily summary", role: "prompt"),
      ChatModel(context: "Weekly summary", role: "prompt"),
      ChatModel(
          context: "On which aspect should I improve on?", role: "prompt"),
      ChatModel(
          context: "How do I compare to an average human", role: "prompt"),
    ];

    messageHistory = [];
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswer(
      {required String message, required weeklyHealthData}) async {
    // Include message history in the request
    Map<String, String> messageMap = {
      "Daily summary":
          "Provide me with a short summary of my health based on my health data from yesterday.",
      "Weekly summary":
          "Provide me with a short summary of my health based on my health data from the last 7 days.",
      "On which aspect should I improve on?":
          "Based on my health data, what would you suggest me to improve on and why? Pick only one aspect and keep your answer short. Include comparison of my health data and the suggested values for the chosen aspect.",
      "How do I compare to an average human":
          "Compare my health data with an average human. Keep your answer short and simple."
    };

    message = messageMap[message] ?? message;
    var messages = [
      {
        "role": "system",
        "content":
            "You are MAINDFUL health advisor, an enthusiastic, and expert caretaker.\n\nFollow these steps in order to provide as useful help to the user as possible:\n\nStep 1:\nHere's the health data from the last seven days that you need to analyze:\n $weeklyHealthData.\n\nStep 2: \nGiven the context, provide a short response that could answer the user's question. If the question is related to users' steps, sleep, VO2MAX or heartbeat, utilize the data given in “Step 1” in your answer.\n\nStep 3:\nIF numbers in the health data seem low, provide advice on how they can improve. Note that today's data might be incomplete and show lower values.\n\n Step 4: \n Always  format your answer in markdown-format and leave space between paragraphs and list contents. Today's date is ${DateTime.now().toString()} . IF a value is zero, it means that the user has not logged any data for that day. DO NOT provide statistics."
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
}
