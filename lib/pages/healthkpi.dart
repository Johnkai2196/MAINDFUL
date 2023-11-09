import 'package:flutter/material.dart';
// import 'package:innovation_project/constants/constants.dart';
// import 'package:innovation_project/pages/healthgpt_page.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';
import 'package:innovation_project/widgets/fitness_tile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HealthKpi extends StatelessWidget {
  const HealthKpi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      appBar: const CustomAppBar(
        withIcon: true,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height *
                0.4, // 50% of screen height
            width: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/pexels-christian-salwa-244483.png'), // Replace with your local photo file path
                fit: BoxFit.cover,
              ),
            ),
            child: Card(
              color: Colors.transparent, // Make the card background transparent
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Title',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // You can add more widgets or customize as needed
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height *
                0.5, // 50% of screen height
            padding: EdgeInsets.all(16),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
