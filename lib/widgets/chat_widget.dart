import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:innovation_project/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

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
      padding: const EdgeInsets.all(16.0),
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
          : MarkdownBody(
              data: message,
              onTapLink: (text, url, title) {
                launchUrl(Uri.parse(url!));
              },
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(color: textWhite, fontSize: 14),
                h1: TextStyle(color: textWhite, fontSize: 24),
                h2: TextStyle(color: textWhite, fontSize: 22),
                h3: TextStyle(color: textWhite, fontSize: 20),
                h4: TextStyle(color: textWhite, fontSize: 18),
                h5: TextStyle(color: textWhite, fontSize: 16),
                h6: TextStyle(color: textWhite, fontSize: 14),
                strong:
                    TextStyle(color: textWhite, fontWeight: FontWeight.bold),
                em: TextStyle(color: textWhite, fontStyle: FontStyle.italic),
                listBullet: TextStyle(color: textWhite),
              ),
            ),
    );
  }
}
