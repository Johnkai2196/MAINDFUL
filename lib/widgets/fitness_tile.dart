import 'package:flutter/material.dart';
import 'package:innovation_project/constants/constants.dart';
import 'package:innovation_project/pages/healthgpt_page.dart';
import 'package:innovation_project/pages/healthkpi.dart';
import 'package:innovation_project/pages/healthkpi_breath.dart';
import 'package:innovation_project/pages/healthkpi_heart.dart';
import 'package:innovation_project/pages/healthkpi_steps.dart';
import 'package:innovation_project/pages/term_and_condition_page.dart';

import 'package:innovation_project/providers/health_providers.dart';
import 'package:innovation_project/providers/quote_providers.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SleepCard extends StatelessWidget {
  final String title;
  const SleepCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.45;
    double cardHeight = MediaQuery.of(context).size.width * 0.4;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HealthKPI(title: "Sleep", value: title)),
        );
      },
      child: Center(
        child: Card(
          elevation: 8,
          color: surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          child: SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'SLEEP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: "ConcertOne",
                  ),
                ),
                const SizedBox(
                    height: 8), // Add spacing between the icon and text
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    // fontFamily: "ConcertOne",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeartCard extends StatelessWidget {
  final String beats;
  const HeartCard({super.key, required this.beats});

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.45;
    double cardHeight = MediaQuery.of(context).size.width * 0.4;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HealthKPIHeart(title: "Heart", value: beats)),
        );
      },
      child: Center(
        child: Card(
          elevation: 8, // Adjust the elevation to control the shadow depth
          color: surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Colors.black, // Set the border color
              width: 2.0, // Set the border width
            ),
          ),
          child: SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'HEART',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: "ConcertOne",
                  ),
                ),
                const SizedBox(
                    height: 8), // Add spacing between the icon and text
                Text(
                  // "",
                  beats,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    // fontFamily: "ConcertOne",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StepsCard extends StatelessWidget {
  final String steps;
  final QuoteProvider quoteProvider; // Add this line

  const StepsCard(
      {super.key, required this.steps, required this.quoteProvider});

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.45;
    double cardHeight = MediaQuery.of(context).size.width * 0.4;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HealthKPISteps(
                  title: "Steps", value: steps, quoteProfider: quoteProvider)),
        );
      },
      child: Center(
        child: Card(
          elevation: 8, // Adjust the elevation to control the shadow depth
          color: surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Colors.black, // Set the border color
              width: 2.0, // Set the border width
            ),
          ),
          child: SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'STEPS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: "ConcertOne",
                  ),
                ),
                const SizedBox(
                    height: 8), // Add spacing between the icon and text
                Text(
                  steps,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    // fontFamily: "ConcertOne",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BreathingCard extends StatelessWidget {
  final String breath;
  const BreathingCard({super.key, required this.breath});

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.45;
    double cardHeight = MediaQuery.of(context).size.width * 0.4;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HealthKPIBreath(title: "Breath", value: breath)),
        );
      },
      child: Center(
        child: Card(
          elevation: 8, // Adjust the elevation to control the shadow depth
          color: surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Colors.black, // Set the border color
              width: 2.0, // Set the border width
            ),
          ),
          child: SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'BREATHING',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: "ConcertOne",
                  ),
                ),
                const SizedBox(
                    height: 8), // Add spacing between the icon and text
                Text(
                  breath,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    // fontFamily: "ConcertOne",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatCard extends StatefulWidget {
  final HealthDataProvider healthDataProvider;

  const ChatCard({super.key, required this.healthDataProvider});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  late bool status;
  @override
  void initState() {
    super.initState();
    _getStatus();
  }

  void _getStatus() async {
    final prefs = await SharedPreferences.getInstance();

    var status = prefs.getBool('status');

    setState(() => this.status = status ?? false);
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.85;
    double cardHeight = MediaQuery.of(context).size.width * 0.2;
    _getStatus();
    return GestureDetector(
      onTap: () {
        status
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HealthGpt(
                    healthDataProvider: widget.healthDataProvider,
                  ),
                ),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TermsAndConditionsPage(
                    healthDataProvider: widget.healthDataProvider,
                  ),
                ),
              );
      },
      child: Center(
        child: Card(
          elevation: 10, // Adjust the elevation to control the shadow depth
          color: surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: textPurple, // Set the border color
              width: 4.0, // Set the border width
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'MAICHAT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 46,
                      fontFamily: "ConcertOne",
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
