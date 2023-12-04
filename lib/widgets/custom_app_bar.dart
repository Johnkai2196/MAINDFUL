import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:innovation_project/constants/constants.dart';

import 'package:innovation_project/providers/chat_providers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String withIcon;
  final Function()? onIconPressed;
  final bool backArrow;

  final bool typing;
  final bool walkThrough;
  final String route;
  const CustomAppBar(
      {super.key,
      this.onIconPressed,
      this.withIcon = "",
      this.backArrow = false,
      this.typing = false,
      this.walkThrough = false,
      this.route = ""});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late bool status;
  @override
  void initState() {
    super.initState();
    _getStatus();
  }

  void _getStatus() async {
    final prefs = await SharedPreferences.getInstance();

    var status = prefs.getBool('first');

    setState(() => this.status = status ?? false);
    if (this.status == false) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _showWelcomeDialog(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData(
      colorSchemeSeed: const Color(0xff6750a4),
      useMaterial3: true,
    );

    final chatProvider = Provider.of<ChatProvider>(context);
    Widget back;

    back = widget.backArrow
        ? IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              widget.typing
                  ? ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "You cannot navigate backward while a message is being sent."),
                        backgroundColor: Colors.red,
                      ),
                    )
                  : widget.route == ""
                      ? Navigator.of(context).popUntil((route) => route.isFirst)
                      : Navigator.of(context).popUntil(
                          (route) => route.settings.name == '/${widget.route}');
            },
          )
        : widget.walkThrough
            ? IconButton(
                icon: const Icon(Icons.info_outline_rounded),
                onPressed: () {
                  _getStatus();
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
        if (widget.withIcon == 'delete')
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.white,
            onPressed: () {
              if (!widget.typing) {
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
                            Navigator.of(context).pop();
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
                            chatProvider.resetChat();
                            Navigator.of(context).pop();
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
        else if (widget.withIcon == 'refresh')
          IconButton(
            icon: const Icon(Icons.refresh),
            color: Colors.white,
            onPressed: () {
              if (widget.onIconPressed != null) {
                widget.onIconPressed!();
              }
            },
          )
        else
          Container(),
      ],
    );
  }

  void _showWelcomeDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: surfaceContainerHigh,
          contentPadding: const EdgeInsets.only(left: 16),
          content: IntrinsicHeight(
            child: Stack(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      'WELCOME TO USE MAINDFUL!',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "ConcertOne",
                        fontSize: 32,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Here is a short introduction on how to get started with MAINDFUL.',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: status
                      ? IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      : Container(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showPreviousDialog(context, 0);
              },
              child: const Text(''),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('OK');
                _showNextDialog(context, 2);
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  color: Color.fromRGBO(223, 183, 255, 1),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPreviousDialog(BuildContext context, int dialogNumber) {
    if (dialogNumber > 2) {
      _showNextDialog(context, dialogNumber - 1);
    }
  }

  void _showNextDialog(BuildContext context, int dialogNumber) {
    String dialogTitle = 'Dialog $dialogNumber';
    String dialogContent = 'This is the content of Dialog $dialogNumber.';
    bool isLastDialog = dialogNumber == 5;

    if (dialogNumber == 2) {
      dialogTitle = 'HOME';
      dialogContent =
          'Here you will find easy access to MAICHAT where you can discuss all things health! Just tap MAICHAT and ask away.\n \nIn your home page, you will also see the overall view of your personal health data from Apple Health.';
    } else if (dialogNumber == 3) {
      dialogTitle = 'MAICHAT';
      dialogContent =
          'Do you have a specific wellness question about your health or do you need just an overall analysis of your latest Apple Health data? Great!\n \nJust a reminder, please note that this is not to be viewed or interpreted as medical advice!';
    } else if (dialogNumber == 4) {
      dialogTitle = 'HEALTH METRICS';
      dialogContent =
          'Tap on your desired metric, and here you can take a closer look at specific health data.';
    } else if (dialogNumber == 5) {
      dialogTitle = "THAT'S IT!";
      dialogContent =
          'Hopefully MAINDFUL will help you achieve your goals, whatever they may be!\n \nAnd remember, better health is just a chat away!';
    }

    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: surfaceContainerHigh,
          contentPadding: const EdgeInsets.only(left: 16),
          content: IntrinsicHeight(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      dialogTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "ConcertOne",
                        fontSize: 32,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      dialogContent,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: status
                      ? IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                            _showPreviousDialog(context, 0);
                          },
                        )
                      : Container(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            dialogNumber > 2
                ? TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Back');
                      _showPreviousDialog(context, dialogNumber);
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        color: Color.fromRGBO(223, 183, 255, 1),
                      ),
                    ),
                  )
                : Container(),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                if (dialogNumber < 5) {
                  _showNextDialog(context, dialogNumber + 1);
                } else {
                  saveData();
                }
              },
              child: Text(
                isLastDialog ? 'Done' : 'Next',
                style: const TextStyle(
                  color: Color.fromRGBO(223, 183, 255, 1),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Future<void> saveData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('first', true);
}
