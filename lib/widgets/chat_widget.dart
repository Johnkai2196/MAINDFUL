import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:innovation_project/constants/constants.dart';

class ChatWidget extends StatelessWidget {
  final bool isSender;
  final String message;
  final bool shouldAnimate;
  const ChatWidget({
    super.key,
    required this.isSender,
    required this.message,
    this.shouldAnimate = false,
  });

  @override
  Widget build(BuildContext context) {
    final textWidth = (TextPainter(
      text: TextSpan(
        text: message,
        style: TextStyle(
          color: isSender ? darkerPurple : textWhite,
          fontSize: 14,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout())
        .size
        .width;

    final shouldLimitWidth =
        textWidth > (MediaQuery.of(context).size.width * 0.85);

    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: shouldLimitWidth
          ? FractionallySizedBox(
              widthFactor:
                  0.85, // Limit the width to 85% of the available space
              child: buildContainer(),
            )
          : buildContainer(),
    );
  }

  Widget buildContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSender ? textPurple : lightGrey,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: isSender
          ? Text(
              message,
              style: TextStyle(
                color: darkerPurple,
                fontSize: 14,
              ),
            )
          : shouldAnimate
              ? DefaultTextStyle(
                  style: TextStyle(color: textWhite, fontSize: 14),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    displayFullTextOnTap: true,
                    totalRepeatCount: 1,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        message.trim(),
                      ),
                    ],
                  ),
                )
              : Text(
                  message,
                  style: TextStyle(
                    color: textWhite,
                    fontSize: 14,
                  ),
                ),
    );
  }
}
