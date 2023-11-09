import 'package:flutter/material.dart';
// import 'package:innovation_project/constants/constants.dart';
// import 'package:innovation_project/pages/healthgpt_page.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';
import 'package:innovation_project/widgets/fitness_tile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: const CustomAppBar(
          withIcon: false,
        ),
        body: Stack(
          children: <Widget>[
            // Background image (SVG)
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/blob-scene-haikei (3).svg',
                fit: BoxFit.cover, // You can adjust the fit as needed
              ),
            ),
            const Column(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Align content to the bottom
              children: <Widget>[
                ChatCard(),
                Padding(
                  padding: EdgeInsets.only(
                      top: 16.0), // Adjust the top padding as needed
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SleepCard(
                          title: '8h',
                        ),
                        HeartCard(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 16.0,
                      bottom: 16.0), // Adjust the top padding as needed
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        StepsCard(),
                        BreathingCard(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
