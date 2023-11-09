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
                'assets/images/blob-haikei (4).svg',
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topCenter, // Align to the top center
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: SvgPicture.asset(
                  'assets/icons/robot-svgrepo-com (2).svg',
                  height: 350,
                ),
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
