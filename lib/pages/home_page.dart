import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                text: "NFULL",
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
        backgroundColor: Colors.black,
      ),
      body: const Placeholder(),
    );
  }
}
