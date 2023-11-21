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
    ThemeData(
      colorSchemeSeed: const Color(0xff6750a4),
      useMaterial3: true,
    );

    final chatProvider = Provider.of<ChatProvider>(context);
    Widget back;

    back = backArrow
        ? IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              skipTermAndCondition
                  ? Navigator.of(context).popUntil((route) => route.isFirst)
                  : Navigator.of(context).pop();
            },
          )
        : walkThrough
            ? IconButton(
                icon: const Icon(Icons.info_outline_rounded),
                onPressed: () {
                  _showWelcomeDialog(context);
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
                chatProvider.resetChat();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        "You cannot reset a message while it's being sent."),
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
          Container(), // This will render nothing if iconType is neither 'delete' nor 'refresh'
      ],
    );
  }

  void _showWelcomeDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Welcome to use MAINDFUL!'),
          content: const Text(
              'Here is a short introduction on how to get started with MAINDFUL.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                _showNextDialog(context, 2); // Start the sequence with Dialog 2
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    );
  }

  void _showNextDialog(BuildContext context, int dialogNumber) {
    String dialogTitle = 'Dialog $dialogNumber';
    String dialogContent = 'This is the content of Dialog $dialogNumber.';

    if (dialogNumber == 2) {
      dialogTitle = 'Home';
      dialogContent =
          'Here you will find easy access to MAICHAT where you can discuss all things health! Just click MAICHAT and ask away.\n \nIn your home page you will also see overall view on your personal health data from Apple Health.';
    } else if (dialogNumber == 3) {
      dialogTitle = 'MAICHAT';
      dialogContent =
          'Do you have a specific wellness question about your health or do you need just an overall analysis on your latest Apple Health data? Great!\n \nJust  a reminder, please note that this is not to be viewed or interpreted as medical advice!';
    } else if (dialogNumber == 4) {
      dialogTitle = 'Health KPI (?)';
      dialogContent =
          'Tap on you desired kpi and here you can take a closer look on specific health kpi data.';
    } else if (dialogNumber == 5) {
      dialogTitle = 'That’s it!';
      dialogContent =
          'Hopefully MAINDFUL will help you to achieve your goals, whatever they may be!\n \nAnd remember better health is just a chat away!';
    }

    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dialogTitle),
          content: Text(dialogContent),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Back');
              },
              child: const Text('Back'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                if (dialogNumber < 5) {
                  _showNextDialog(context, dialogNumber + 1);
                }
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
