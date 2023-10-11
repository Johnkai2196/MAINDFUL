import 'package:flutter/material.dart';
import 'package:innovation_project/pages/healthgpt_page.dart';
import 'package:innovation_project/widgets/custom_app_bar.dart';
import 'package:innovation_project/widgets/fitness_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      appBar: const CustomAppBar(
        withIcon: false,
      ), // Use the custom AppBar
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HealthGpt()),
                );
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Chat with MAINDFUL",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) => const FitnessTile(),
            ),
          ),
        ],
      ),
    );
  }
}
