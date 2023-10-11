import 'package:flutter/widgets.dart';
import 'package:innovation_project/models/chat_models.dart';
import 'package:innovation_project/services/api_services.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList => chatList;
  void addUserMessage({required String message}) {
    chatList.add(ChatModel(msg: message, sender: true));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswer({required String message}) async {
    chatList.addAll(
      await ApiService.sendMessage(message: message),
    );
    notifyListeners();
  }
}
