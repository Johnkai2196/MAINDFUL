import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innovation_project/providers/chat_providers.dart';
import 'package:innovation_project/providers/quote_providers.dart';
// import 'package:innovation_project/constants/constants.dart';
// import 'package:innovation_project/pages/healthgpt_page.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HealthKPISteps extends StatefulWidget {
  final String title;
  final String value;
  final QuoteProvider quoteProfider; // Add this line
  const HealthKPISteps({
    super.key,
    required this.title,
    required this.value,
    required this.quoteProfider, // Add this linex
  });

  @override
  State<HealthKPISteps> createState() => _HealthKPIStepsState();
}

class _HealthKPIStepsState extends State<HealthKPISteps> {
  final StreamController<Map<String, String>> _controller =
      StreamController<Map<String, String>>();

  @override
  void initState() {
    super.initState();

    if (widget.quoteProfider.getQuoteList
        .firstWhere((map) => map.containsKey('Sleep'), orElse: () => {})
        .isEmpty) {
      // Start the timer when the widget is created
      Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        // Update the state text every second
        Map<String, String> sleepData = widget.quoteProfider.getQuoteList
            .firstWhere((map) => map.containsKey('Sleep'), orElse: () => {});
        _controller.add(sleepData);

        if (sleepData["Sleep"] != null) {
          timer.cancel();
        }
      });
    } else {
      Map<String, String> sleepData = widget.quoteProfider.getQuoteList
          .firstWhere((map) => map.containsKey('Sleep'), orElse: () => {});
      _controller.add(sleepData);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Scaffold(
        backgroundColor: const Color(0xff1D1B1E),
        appBar: const CustomAppBar(backArrow: true),
        body: Column(
          children: <Widget>[
            // Upper Section
            Expanded(
              flex: 4,
              child: Container(
                width: screenWidth,
                margin: const EdgeInsets.all(16.0),
                child: Center(
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    elevation: 0,
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      width: screenWidth * 0.95,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage(
                              'assets/images/jad-limcaco-fRggLY1DQTM-unsplash.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: const Text(
                              'Steps',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontFamily: "ConcertOne",
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/icons/walk-svgrepo-com.svg',
                            height: 45.0,
                            width: 45.0,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              widget.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Lower Section
            Expanded(
              flex: 6, // 60% of the available space
              child: Container(
                width: screenWidth, // 100% of the screen width
                margin: const EdgeInsets.all(
                    16.0), // Add margin around the container
                child: Center(
                  child: Card(
                    elevation: 0, // No shadow
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      width: screenWidth * 0.95, // 95% of the screen width
                      color: const Color(0xff1D1B1E), // Dark background color
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: const Text(
                                'Keep it going!',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 8.0,
                                bottom: 8.0,
                              ),
                              padding: const EdgeInsets.only(
                                  bottom: 8.0), // Add padding to the bottom
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.white, // Set the border color
                                    width: 1.0, // Set the border thickness
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Why you should stay active?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontFamily: "ConcertOne",
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: StreamBuilder<Map<String, String>>(
                                  stream: _controller.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      String sleepText =
                                          snapshot.data?["Sleep"] ??
                                              'Loading...';
                                      return Text(
                                        sleepText,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      );
                                    } else {
                                      return const Text(
                                        'Loading...',
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      );
                                    }
                                  },
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                // Button action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                    0xffDFB7FF), // Button background color
                              ),
                              child: const Text(
                                'How to improve daily activity',
                                style: TextStyle(
                                  color: Color(0xff4B007E), // Button text color
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
