import 'package:flutter/material.dart';
import 'package:innovation_project/constants/constants.dart';
import 'package:innovation_project/pages/healthgpt_page.dart';
import 'package:innovation_project/pages/healthkpi_sleep.dart';
import 'package:innovation_project/pages/healthkpi_breath.dart';
import 'package:innovation_project/pages/healthkpi_heart.dart';
import 'package:innovation_project/pages/healthkpi_steps.dart';
import 'package:innovation_project/pages/term_and_condition_page.dart';

import 'package:innovation_project/providers/health_providers.dart';
import 'package:innovation_project/providers/quote_providers.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SleepCard extends StatelessWidget {
  final HealthDataProvider healthDataProvider;
  final QuoteProvider quoteProvider;
  const SleepCard(
      {super.key,
      required this.quoteProvider,
      required this.healthDataProvider});

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.45;
    double cardHeight = MediaQuery.of(context).size.width * 0.4;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HealthKPISleep(
                healthDataProvider: healthDataProvider,
                quoteProfider: quoteProvider),
            settings: const RouteSettings(name: '/sleep'),
          ),
        );
      },
      child: Center(
        child: Card(
          elevation: 10,
          color: surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Colors.black,
              width: 2.5,
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
                  healthDataProvider.sleepData == ''
                      ? 'No Data'
                      : healthDataProvider.sleepData,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
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
  final HealthDataProvider healthDataProvider;
  final QuoteProvider quoteProvider;
  const HeartCard(
      {super.key,
      required this.quoteProvider,
      required this.healthDataProvider});

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.45;
    double cardHeight = MediaQuery.of(context).size.width * 0.4;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HealthKPIHeart(
                healthDataProvider: healthDataProvider,
                quoteProfider: quoteProvider),
            settings: const RouteSettings(name: '/heart'),
          ),
        );
      },
      child: Center(
        child: Card(
          elevation: 10, // Adjust the elevation to control the shadow depth
          color: surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Colors.black, // Set the border color
              width: 2.5, // Set the border width
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
                  healthDataProvider.heartRate == 0
                      ? 'No Data'
                      : '${healthDataProvider.heartRate} bpm',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
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
  final HealthDataProvider healthDataProvider;
  final QuoteProvider quoteProvider;

  const StepsCard(
      {super.key,
      required this.healthDataProvider,
      required this.quoteProvider});

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
                healthDataProvider: healthDataProvider,
                quoteProfider: quoteProvider),
            settings: const RouteSettings(name: '/step'),
          ),
        );
      },
      child: Center(
        child: Card(
          elevation: 10, // Adjust the elevation to control the shadow depth
          color: surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Colors.black, // Set the border color
              width: 2.5, // Set the border width
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
                  healthDataProvider.steps == 0
                      ? 'No Data'
                      : '${healthDataProvider.steps}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
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
  final HealthDataProvider healthDataProvider;

  final QuoteProvider quoteProvider;
  const BreathingCard(
      {super.key,
      required this.quoteProvider,
      required this.healthDataProvider});

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.45;
    double cardHeight = MediaQuery.of(context).size.width * 0.4;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HealthKPIBreath(
              healthDataProvider: healthDataProvider,
              quoteProfider: quoteProvider,
            ),
            settings: const RouteSettings(name: '/breath'),
          ),
        );
      },
      child: Center(
        child: Card(
          elevation: 10, // Adjust the elevation to control the shadow depth
          color: surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Colors.black, // Set the border color
              width: 2.5, // Set the border width
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
                  healthDataProvider.v02Max == 0
                      ? 'No Data'
                      : '${healthDataProvider.v02Max} VO₂max',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
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
