import 'package:flutter/material.dart';
import 'package:psycho_psycho/pages/QuestionPage.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text block
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'Choose a subject:',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(

          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to the QuestionPage with subject 'm' when the red block is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuestionPage(subject: 'a')),
                  );
                },
                child: ColoredBlock(color: Colors.black, description: "תרגול כל השאלות", imagePath: "assets/PLACEHOLDER.jpg",),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  // Navigate to the QuestionPage with subject 'm' when the red block is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuestionPage(subject: 'm')),
                  );
                },
                child: ColoredBlock(color: Colors.red, description: "תרגול שאלות במתמטיקה", imagePath: "assets/PLACEHOLDER.jpg",),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  // Navigate to the QuestionPage with subject 'h' when the green block is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuestionPage(subject: 'h')),
                  );
                },
                child: ColoredBlock(color: Colors.green, description: "תרגול שאלות בעברית", imagePath: "assets/PLACEHOLDER.jpg",),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  // Navigate to the QuestionPage with subject 'e' when the yellow block is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuestionPage(subject: 'e')),
                  );
                },
                child: ColoredBlock(color: Colors.yellow, description: "תרגול שאלות באנגלית", imagePath: "assets/PLACEHOLDER.jpg",),
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
  final String description;
  final String imagePath;

  const ColoredBlock({
    Key? key,
    required this.color,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height*0.1, // Set the height as needed
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15.0),
            width: 100.0, // Set fixed width for the image
            height: 50.0, // Set fixed height for the image
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover, // Adjust image fit as needed
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 15.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl, // Right-to-left text direction
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

