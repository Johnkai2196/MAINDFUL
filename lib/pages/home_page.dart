import 'package:flutter/material.dart';
import 'package:innovation_project/constants/constants.dart';
// import 'package:innovation_project/constants/constants.dart';
// import 'package:innovation_project/pages/healthgpt_page.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';
import 'package:innovation_project/widgets/fitness_tile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        double imageSize = sizingInformation.isMobile ? 150.0 : 250.0;

        return Scaffold(
          backgroundColor: Colors.transparent,
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
              Align(
                alignment: Alignment.topCenter, // Align to the top center
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 90.0, left: 16.0, right: 16.0),
                  child: SvgPicture.asset(
                    'assets/icons/robot-svgrepo-com (6).svg',
                    height: 250,
                  ),
                ),
              ),
              const Column(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Align content to the bottom
                children: <Widget>[
                  ChatCard(),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SleepCard(
                            title: '8h 15min',
                          ),
                          HeartCard(
                            beats: '86 bpm',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          StepsCard(
                            steps: '10 000',
                          ),
                          BreathingCard(
                            breath: '35 vo2max',
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
