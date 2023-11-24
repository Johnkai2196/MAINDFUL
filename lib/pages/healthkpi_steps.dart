import 'dart:async';

import 'package:flutter/material.dart';

import 'package:innovation_project/constants/constants.dart';
import 'package:innovation_project/pages/healthgpt_page.dart';
import 'package:innovation_project/pages/term_and_condition_page.dart';
import 'package:innovation_project/providers/health_providers.dart';

import 'package:innovation_project/providers/quote_providers.dart';

// import 'package:innovation_project/pages/healthgpt_page.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthKPISteps extends StatefulWidget {
  final QuoteProvider quoteProfider;
  final HealthDataProvider healthDataProvider;
  const HealthKPISteps({
    super.key,
    required this.healthDataProvider,
    required this.quoteProfider,
  });

  @override
  State<HealthKPISteps> createState() => _HealthKPIStepsState();
}

class _HealthKPIStepsState extends State<HealthKPISteps> {
  final StreamController<Map<String, String>> _controller =
      StreamController<Map<String, String>>();
  late bool status;
  @override
  void initState() {
    super.initState();
    _getStatus();
    if (widget.quoteProfider.getQuoteList
        .firstWhere((map) => map.containsKey("Steps"), orElse: () => {})
        .isEmpty) {
      // Start the timer when the widget is created
      Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        // Update the state text every second
        Map<String, String> stepData = widget.quoteProfider.getQuoteList
            .firstWhere((map) => map.containsKey("Steps"), orElse: () => {});
        _controller.add(stepData);

        if (stepData["Steps"] != null) {
          timer.cancel();
        }
      });
    } else {
      Map<String, String> stepData = widget.quoteProfider.getQuoteList
          .firstWhere((map) => map.containsKey("Steps"), orElse: () => {});
      _controller.add(stepData);
    }
  }

  void _getStatus() async {
    final prefs = await SharedPreferences.getInstance();

    var status = prefs.getBool('status');

    setState(() => this.status = status ?? false);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String text = "Tips to increase activity";
    _getStatus();
    return Scaffold(
      body: Scaffold(
        backgroundColor: backGroundColor,
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
                          image: AssetImage('assets/images/blob-haikei.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(bottom: 13.0),
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
                            padding: const EdgeInsets.only(top: 13.0),
                            child: Text(
                              widget.healthDataProvider.steps == 0
                                  ? 'No Data'
                                  : '${widget.healthDataProvider.steps}',
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
                                    color: Color.fromRGBO(223, 183, 255,
                                        1), // Set the border color
                                    width: 2.0, // Set the border thickness
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
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: StreamBuilder<Map<String, String>>(
                                stream: _controller.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    String stepText =
                                        snapshot.data?["Steps"] ?? "";
                                    if (stepText == "") {
                                      return const SizedBox(
                                        height: 50.0,
                                        width: 50.0,
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    } else {
                                      return Text(
                                        stepText,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      );
                                    }
                                  } else {
                                    return const SizedBox(
                                      height: 50.0,
                                      width: 50.0,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Button action
                                  status
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HealthGpt(
                                                healthDataProvider:
                                                    widget.healthDataProvider,
                                                question: text,
                                                route: "step"),
                                          ),
                                        )
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TermsAndConditionsPage(
                                                    healthDataProvider: widget
                                                        .healthDataProvider,
                                                    question: text,
                                                    route: "step"),
                                          ),
                                        );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: textPurple,
                                ),
                                child: Text(
                                  text,
                                  style: const TextStyle(
                                    color: Color(0xff4B007E),
                                  ),
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
