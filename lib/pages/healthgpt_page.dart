import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:innovation_project/constants/constants.dart';
import 'package:innovation_project/providers/chat_providers.dart';
import 'package:innovation_project/widgets/chat_widget.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class HealthGpt extends StatefulWidget {
  const HealthGpt({super.key});

  @override
  State<HealthGpt> createState() => _HealthGptState();
}

class _HealthGptState extends State<HealthGpt> {
  bool _isTyping = false;
  late FocusNode focusNode;
  late ScrollController _listScrollController;
  late TextEditingController textController;

  @override
  void initState() {
    _listScrollController = ScrollController();
    textController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  // List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(
        withIcon: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: _listScrollController,
                itemCount: chatProvider.getChatList.length,
                itemBuilder: (context, index) {
                  final dynamic sender = chatProvider.getChatList[index].sender;
                  final bool isSender = sender as bool? ?? false;
                  return ChatWidget(
                    message: chatProvider.getChatList[index].msg,
                    isSender: isSender,
                    shouldAnimate: chatProvider.getChatList.length - 1 == index,
                  );
                },
              ),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 24,
              ),
            ],
            const SizedBox(
              height: 15,
            ),
            Material(
              color: lightGrey,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        controller: textController,
                        onSubmitted: (value) async {
                          await sendMessage(chatProvider: chatProvider);
                        },
                        decoration: const InputDecoration.collapsed(
                          hintText: "Type your question here",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: textPurple,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          await sendMessage(chatProvider: chatProvider);
                        },
                        icon: Icon(
                          Icons.check,
                          color: darkerPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //TODO fix the scroll to bottom function to better work with the chat widget
  void scrollListToBottom() {
    _listScrollController.animateTo(
      _listScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> sendMessage({required ChatProvider chatProvider}) async {
    if (textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a message"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You can't send multiple messages at once"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String text = textController.text;
      setState(
        () {
          _isTyping = true;
          chatProvider.addUserMessage(message: text);
          textController.clear();
          focusNode.unfocus();
        },
      );
      await chatProvider.sendMessageAndGetAnswer(message: text);
      setState(() {});
    } catch (e) {
      log("Error $e");
    } finally {
      setState(
        () {
          scrollListToBottom();
          _isTyping = false;
        },
      );
    }
  }
}
