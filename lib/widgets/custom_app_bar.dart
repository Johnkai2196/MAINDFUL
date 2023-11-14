import 'package:flutter/material.dart';
import 'package:innovation_project/constants/constants.dart';
// import 'package:innovation_project/constants/constants.dart';
import 'package:innovation_project/providers/chat_providers.dart';
import 'package:provider/provider.dart';

// Custom appbar to display the logo and the delete icon
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String withIcon;
  final Function()? onIconPressed;
  final bool backArrow;
  const CustomAppBar({
    super.key,
    this.onIconPressed,
    this.withIcon = "",
    this.backArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return AppBar(
      automaticallyImplyLeading: backArrow,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: "M",
              style: TextStyle(
                color: Colors.white, // Color for the "M" letter
                fontWeight: FontWeight.bold, // Make it bold
                fontSize: 42, // Increase font size
                fontFamily: "ConcertOne", // Font family
              ),
            ),
            TextSpan(
              text: "AI",
              style: TextStyle(
                color: primaryContainer, // Color for the "AI" letters
                fontWeight: FontWeight.bold, // Make it bold
                fontSize: 42, // Color for the "AI" letters
                fontFamily: "ConcertOne", // Font family
              ),
            ),
            const TextSpan(
              text: "NDFUL",
              style: TextStyle(
                color: Colors.white, // Color for the "NFULL" letters
                fontWeight: FontWeight.bold, // Make it bold
                fontSize: 42, // Color for the "NFULL" letters
                fontFamily: "ConcertOne", // Font family
              ),
            ),
          ],
        ),
      ),
      actions: [
        if (withIcon == 'delete')
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              chatProvider.resetChat();
            },
          )
        else if (withIcon == 'refresh')
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (onIconPressed != null) {
                onIconPressed!();
              }
            },
          )
        else
          Container(), // This will render nothing if iconType is neither 'delete' nor 'refresh'
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
