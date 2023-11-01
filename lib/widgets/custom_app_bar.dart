import 'package:flutter/material.dart';
import 'package:innovation_project/providers/chat_providers.dart';
import 'package:provider/provider.dart';

// Custom appbar to display the logo and the delete icon
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool withIcon;
  final Function()? onIconPressed;
  const CustomAppBar({
    super.key,
    this.onIconPressed,
    required this.withIcon,
  });

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return AppBar(
      centerTitle: true,
      title: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: "M",
              style: TextStyle(
                color: Colors.white, // Color for the "M" letter
                fontWeight: FontWeight.bold, // Make it bold
                fontSize: 30.0, // Increase font size
                fontFamily: "ConcertOne", // Font family
              ),
            ),
            TextSpan(
              text: "AI",
              style: TextStyle(
                color: Colors.red, // Color for the "AI" letters
                fontWeight: FontWeight.bold, // Make it bold
                fontSize: 30.0, // Color for the "AI" letters
                fontFamily: "ConcertOne", // Font family
              ),
            ),
            TextSpan(
              text: "NDFUL",
              style: TextStyle(
                color: Colors.white, // Color for the "NFULL" letters
                fontWeight: FontWeight.bold, // Make it bold
                fontSize: 30.0, // Color for the "NFULL" letters
                fontFamily: "ConcertOne", // Font family
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      actions: withIcon
          ? [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // TODO functionality for when the icon is pressed
                  chatProvider.resetChat();
                },
              ),
            ]
          : [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  if (onIconPressed != null) {
                    onIconPressed!();
                  }
                },
              )
            ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
