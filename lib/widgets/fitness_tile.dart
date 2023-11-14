import 'package:flutter/material.dart';
import 'package:innovation_project/constants/constants.dart';

class SleepCard extends StatelessWidget {
  final String title;
  const SleepCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Sleep card tapped");
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
            width: 190,
            height: 154,
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
    return GestureDetector(
      onTap: () {
        print("Heart card tapped");
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
            width: 190,
            height: 154,
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
  const StepsCard({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Steps card tapped");
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
            width: 190,
            height: 154,
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
    return GestureDetector(
      onTap: () {
        print("Breathing card tapped");
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
            width: 190,
            height: 154,
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

class ChatCard extends StatelessWidget {
  const ChatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Chat card tapped");
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
          child: const Padding(
            padding: EdgeInsets.only(bottom: 16), // Add padding if needed
            child: SizedBox(
              width: 396,
              height: 100,
              child: Column(
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
