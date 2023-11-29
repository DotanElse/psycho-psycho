// home_screen.dart
import 'package:flutter/material.dart';
import 'package:psycho_psycho/pages/QuestionPage.dart';
import 'package:psycho_psycho/pages/MathPage.dart';
import 'package:psycho_psycho/pages/HebrewPage.dart';
import 'package:psycho_psycho/pages/EnglishPage.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Large container at the top (30% of screen height, 90% width with margin)
        GestureDetector(
          onTap: () {
            // Navigate to the QuestionPage when the blue container is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuestionPage()),
            );
          },
          child: Container(
            margin: EdgeInsets.all(16.0), // Adjust the margin as needed
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.9,
            color: Colors.blue, // Set the color as needed
            // Add your content inside the large container
          ),
        ),
        SizedBox(height: 16.0), // Add some spacing between the large container and the smaller blocks
        // Three smaller colored blocks
        Expanded(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to the MathPage when the red block is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MathPage()),
                  );
                },
                child: ColoredBlock(color: Colors.red),
              ),
              SizedBox(height: 5,),
              GestureDetector(
                onTap: () {
                  // Navigate to the HebrewPage when the green block is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HebrewPage()),
                  );
                },
                child: ColoredBlock(color: Colors.green),
              ),
              SizedBox(height: 5,),
              GestureDetector(
                onTap: () {
                  // Navigate to the EnglishPage when the yellow block is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EnglishPage()),
                  );
                },
                child: ColoredBlock(color: Colors.yellow),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ColoredBlock extends StatelessWidget {
  final Color color;

  const ColoredBlock({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0, // Set the height as needed
      color: color,
      // Add your content inside each colored block
    );
  }
}
