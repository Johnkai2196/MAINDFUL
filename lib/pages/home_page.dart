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
                  fontSize: 30.0,
                  fontFamily: "ConcertOne",
                  // Increase font size
                ),
              ),
              TextSpan(
                text: "AI",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0, // Color for the "AI" letters
                  fontFamily: "ConcertOne",
                ),
              ),
              TextSpan(
                text: "NFULL",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  fontFamily: "ConcertOne", // Font family
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
