import 'package:flutter/material.dart';
import 'package:innovation_project/utils/fitness_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "M",
                style: TextStyle(
                  color: Colors.white, // Color for the "M" letter
                  fontWeight: FontWeight.bold, // Make it bold
                  fontSize: 30.0, // Increase font size
                  fontFamily: "ConcertOne", // Font family
                ),
              ),
              TextSpan(
                text: "AI",
                style: TextStyle(
                  color: Colors.red, // Color for the "AI" letters
                  fontWeight: FontWeight.bold, // Make it bold
                  fontSize: 30.0, // Color for the "AI" letters
                  fontFamily: "ConcertOne", // Font family
                ),
              ),
              TextSpan(
                text: "NDFUL",
                style: TextStyle(
                  color: Colors.white, // Color for the "NFULL" letters
                  fontWeight: FontWeight.bold, // Make it bold
                  fontSize: 30.0, // Color for the "NFULL" letters
                  fontFamily: "ConcertOne", // Font family
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 20.0), // Add margin to the top
              child: ElevatedButton(
                onPressed: () {},
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
      ),
    );
  }
}
