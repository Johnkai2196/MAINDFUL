import 'package:flutter/material.dart';
import 'package:innovation_project/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SleepCard extends StatelessWidget {
  const SleepCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Card(
          color: surfaceContainerHighest,
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/moon-svgrepo-com (1).svg', // Replace with the path to your SVG icon
                width: 64, // Adjust the width as needed
                height: 64, // Adjust the height as needed
              ),
              const SizedBox(
                  height: 16), // Add spacing between the icon and text
              const Text(
                'SLEEP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontFamily: "ConcertOne",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeartCard extends StatelessWidget {
  const HeartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Card(
          color: surfaceContainerHighest,
          child: const SizedBox(
            width: 164,
            height: 154,
            child: Center(
              child: Text(
                'HEART',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontFamily: "ConcertOne",
                ),
              ),
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
          color: surfaceContainerHighest,
          child: const SizedBox(
            width: 164,
            height: 154,
            child: Center(
              child: Text(
                'STEPS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontFamily: "ConcertOne",
                ),
              ),
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
          color: surfaceContainerHighest,
          child: const SizedBox(
            width: 164,
            height: 154,
            child: Center(
              child: Text(
                'BREATHING',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontFamily: "ConcertOne",
                ),
              ),
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
          color: surfaceContainerHighest,
          child: const SizedBox(
              width: 348,
              height: 134,
              child: Center(
                child: Wrap(children: <Widget>[
                  Text(
                    'CHAT WITH MAINDFUL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: "ConcertOne",
                    ),
                  ),
                ]),
              )),
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
