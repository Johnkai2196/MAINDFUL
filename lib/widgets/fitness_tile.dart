import 'package:flutter/material.dart';
import 'package:innovation_project/constants/constants.dart';

class SleepCard extends StatelessWidget {
  final String title;
  const SleepCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Card(
          elevation: 6, // Adjust the elevation to control the shadow depth
          color: surfaceContainerHighest,
          child: SizedBox(
            width: 164,
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
      onTap: () {},
      child: Center(
        child: Card(
          elevation: 6, // Adjust the elevation to control the shadow depth
          color: surfaceContainerHighest,
          child: const SizedBox(
            width: 164,
            height: 154,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'HEART',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: "ConcertOne",
                  ),
                ),
                SizedBox(height: 8), // Add spacing between the icon and text
                Text(
                  "",
                  // beats,
                  style: TextStyle(
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
  const StepsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Card(
          elevation: 6, // Adjust the elevation to control the shadow depth
          color: surfaceContainerHighest,
          child: const SizedBox(
            width: 164,
            height: 154,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'STEPS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: "ConcertOne",
                  ),
                ),
                SizedBox(height: 8), // Add spacing between the icon and text
                Text(
                  "",
                  style: TextStyle(
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
  const BreathingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Card(
          elevation: 6, // Adjust the elevation to control the shadow depth
          color: surfaceContainerHighest,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(10.0),
          //   side: const BorderSide(
          //     color: Colors.black, // Set the border color
          //     width: 2.0, // Set the border width
          //   ),
          // ),
          child: const SizedBox(
            width: 164,
            height: 154,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'BREATHING',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: "ConcertOne",
                  ),
                ),
                SizedBox(height: 8), // Add spacing between the icon and text
                Text(
                  "",
                  style: TextStyle(
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
      onTap: () {},
      child: Center(
        child: Card(
          elevation: 6, // Adjust the elevation to control the shadow depth
          color: surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Colors.black, // Set the border color
              width: 4.0, // Set the border width
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(bottom: 16), // Add padding if needed
            child: SizedBox(
              width: 348,
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

// class FitnessTile extends StatelessWidget {
//   const FitnessTile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 7.0),
//         child: FractionallySizedBox(
//           widthFactor: 0.95, // 95% of the screen width
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: 104,
//                 clipBehavior: Clip.antiAlias,
//                 decoration: ShapeDecoration(
//                   color: Colors.green,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 10,
//                         ),
//                         child: Text(
//                           "Sleep",
//                           style: TextStyle(
//                             color: textPurple,
//                             fontSize: 32,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         "8h",
//                         style: TextStyle(
//                           color: textWhite,
//                           fontSize: 32,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
