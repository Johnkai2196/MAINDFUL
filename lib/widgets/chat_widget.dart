import 'package:flutter/material.dart';
import 'package:innovation_project/constants/constants.dart';

class ChatWidget extends StatelessWidget {
  final bool isSender;
  final String message;
  const ChatWidget({super.key, required this.isSender, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: FractionallySizedBox(
        widthFactor: 0.85,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSender ? textPurple : lightGrey,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Text(
            message,
            style: TextStyle(
                color: isSender ? darkerPurple : textWhite, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
