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
  final bool skipTermAndCondition;
  final bool typing;
  final bool walkThrough;
  const CustomAppBar({
    super.key,
    this.onIconPressed,
    this.withIcon = "",
    this.backArrow = false,
    this.skipTermAndCondition = false,
    this.typing = false,
    this.walkThrough = false,
  });

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    Widget back;

    back = backArrow
        ? IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              typing
                  ? ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "You cannot navigate backward while a message is being sent."),
                        backgroundColor: Colors.red,
                      ),
                    )
                  : skipTermAndCondition
                      ? Navigator.of(context).popUntil((route) => route.isFirst)
                      : Navigator.of(context).pop();
            },
          )
        : walkThrough
            ? IconButton(
                icon: const Icon(Icons.info_outline_rounded),
                onPressed: () {
                  print("info");
                },
              )
            : Container();

    return AppBar(
      leading: back,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Colors.white),
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
            color: Colors.white,
            onPressed: () {
              if (!typing) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      backgroundColor: lightGrey,
                      title: Text('Do you want to clear chat?',
                          style: TextStyle(
                            color: textWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          )),
                      content: Text(
                          'Clearing the chat will permanently erase all conversation history, and it cannot be restored. Are you sure you want to proceed?',
                          style: TextStyle(color: textWhite)),
                      actions: [
                        TextButton(
                          child: Text(
                            'No',
                            style: TextStyle(color: textPurple),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // Closes the dialog
                          },
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(textPurple),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              color: lightGrey,
                            ),
                          ),
                          onPressed: () {
                            // Place your deletion logic here
                            chatProvider.resetChat();
                            Navigator.of(context).pop(); // Closes the dialog
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        "You cannot delete a message while it is in the process of being sent."),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
            },
          )
        else if (withIcon == 'refresh')
          IconButton(
            icon: const Icon(Icons.refresh),
            color: Colors.white,
            onPressed: () {
              if (onIconPressed != null) {
                onIconPressed!();
              }
            },
          )
        else
          Container(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
