// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:innovation_project/constants/constants.dart';
import 'package:innovation_project/models/chat_models.dart';
import 'package:innovation_project/providers/chat_providers.dart';
import 'package:innovation_project/providers/health_providers.dart';
import 'package:innovation_project/widgets/chat_widget.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class HealthGpt extends StatefulWidget {
  final HealthDataProvider healthDataProvider; // Add this line

  const HealthGpt({
    super.key,
    required this.healthDataProvider, // Add this line
  });

  @override
  State<HealthGpt> createState() => _HealthGptState();
}

class _HealthGptState extends State<HealthGpt> {
  bool _isTyping = false;
  late FocusNode focusNode;
  late ScrollController _listScrollController;
  late TextEditingController textController;
  bool _isScrollingUp = false;
  @override
  void initState() {
    _listScrollController = ScrollController();
    textController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
    _listScrollController.addListener(() {
      if (_listScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isScrollingUp = true;
        });
      } else if (_listScrollController.position.pixels ==
          _listScrollController.position.maxScrollExtent) {
        setState(() {
          _isScrollingUp = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final healthDataProvider = widget.healthDataProvider; // Add this line
    List<ChatModel> combinedList =
        chatProvider.chatList + chatProvider.promptlist;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        withIcon: "delete",
        backArrow: true,
        skipTermAndCondition: true,
        typing: _isTyping,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    controller: _listScrollController,
                    itemCount: combinedList.length,
                    itemBuilder: (context, index) {
                      final dynamic role = combinedList[index].role;
                      final isSender = role == "user";
                      final isPrompt = role == "prompt";
                      if (isPrompt || isSender) {
                        if (isSender) {
                          return ChatWidget(
                            message: combinedList[index].context,
                            isSender: isSender,
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              // Handle the click event
                              textController.text = combinedList[index].context;
                              chatProvider.promptlist.clear();
                              sendMessage(
                                  chatProvider: chatProvider,
                                  healthDataProvider: healthDataProvider);
                            },
                            child: ChatWidget(
                              message: combinedList[index].context,
                              isSender: isPrompt,
                            ),
                          );
                        }
                      }
                      return ChatWidget(
                        message: combinedList[index].context,
                        isSender: isSender,
                        shouldAnimate: combinedList.length - 1 == index,
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
                              chatProvider.promptlist.clear();
                              await sendMessage(
                                  chatProvider: chatProvider,
                                  healthDataProvider: healthDataProvider);
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
                              chatProvider.promptlist.clear();
                              await sendMessage(
                                  chatProvider: chatProvider,
                                  healthDataProvider: healthDataProvider);
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
            if (_isScrollingUp)
              Positioned(
                top: null, // Center the button vertically
                bottom: 80, // Adjust the position as needed
                left: 0,
                right: 0,
                child: FloatingActionButton(
                  backgroundColor: textPurple,
                  mini: true,
                  onPressed: () {
                    // Add your logic for the floating button here
                    scrollListToBottom();
                  },
                  child: Icon(
                    Icons.arrow_downward,
                    color: darkerPurple,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void scrollListToBottom() {
    _listScrollController.animateTo(
      _listScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> sendMessage(
      {required ChatProvider chatProvider,
      required HealthDataProvider healthDataProvider}) async {
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
      scrollListToBottom();
      setState(
        () {
          _isTyping = true;
          chatProvider.addUserMessage(message: text);
          textController.clear();
          focusNode.unfocus();
        },
      );
      await chatProvider.sendMessageAndGetAnswer(
          message: text, weeklyHealthData: healthDataProvider.weeklyHealthData);
    } catch (e) {
      log("Error $e");
    } finally {
      setState(
        () {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            scrollListToBottom();
          });
          _isTyping = false;
        },
      );
    }
  }
}
