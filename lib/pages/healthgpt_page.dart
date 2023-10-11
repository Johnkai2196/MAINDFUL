import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:innovation_project/constants/constants.dart';
import 'package:innovation_project/models/chat_models.dart';
import 'package:innovation_project/services/api_services.dart';
import 'package:innovation_project/widgets/chat_widget.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';

class HealthGpt extends StatefulWidget {
  const HealthGpt({super.key});

  @override
  State<HealthGpt> createState() => _HealthGptState();
}

class _HealthGptState extends State<HealthGpt> {
  bool _isTyping = false;
  late TextEditingController textController;
  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
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
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  final dynamic sender = chatList[index].sender;
                  final bool isSender = sender as bool? ?? false;
                  return ChatWidget(
                    message: chatList[index].msg,
                    isSender: isSender,
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
                        style: const TextStyle(color: Colors.white),
                        controller: textController,
                        onSubmitted: (value) async {
                          await sendMessage();
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
                          await sendMessage();
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

  Future<void> sendMessage() async {
    try {
      setState(
        () {
          _isTyping = true;
        },
      );
      chatList = await ApiService.sendMessage(message: textController.text);
      setState(() {});
    } catch (e) {
      print("Error $e");
    } finally {
      setState(
        () {
          _isTyping = false;
        },
      );
    }
  }
}
