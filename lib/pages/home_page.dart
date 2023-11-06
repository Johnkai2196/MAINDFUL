import 'package:flutter/material.dart';
import 'package:innovation_project/constants/constants.dart';
import 'package:innovation_project/pages/healthgpt_page.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';
import 'package:innovation_project/widgets/fitness_tile.dart';

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
        appBar: AppBar(title: const Text('Card Examples')),
        body: Stack(
          children: <Widget>[
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/aerial-1822139_1280.png',

                fit: BoxFit.cover, // You can adjust the fit as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
