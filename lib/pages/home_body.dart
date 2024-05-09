import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:psycho_psycho/pages/QuestionPage.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuestionPage(subject: 'a')),
                    );
                  },
                  child: ColoredBlock(
                    color: Colors.lightBlue,
                    description: "תרגול כל השאלות",
                    svgPath: "assets/icons/all.svg",
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuestionPage(subject: 'm')),
                    );
                  },
                  child: ColoredBlock(
                    color: Colors.orangeAccent,
                    description: "תרגול שאלות במתמטיקה",
                    svgPath: "assets/icons/math.svg",
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuestionPage(subject: 'h')),
                    );
                  },
                  child: ColoredBlock(
                    color: Colors.lightGreen,
                    description: "תרגול שאלות בעברית",
                    svgPath: "assets/icons/hebrew.svg",
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuestionPage(subject: 'e')),
                    );
                  },
                  child: ColoredBlock(
                    color: Colors.redAccent,
                    description: "תרגול שאלות באנגלית",
                    svgPath: "assets/icons/english.svg",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class ColoredBlock extends StatelessWidget {
  final Color color;
  final String description;
  final String svgPath;

  const ColoredBlock({
    Key? key,
    required this.color,
    required this.description,
    required this.svgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0), // Set the radius for rounded corners
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1, // Set the height as needed
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SvgPicture.asset(
                svgPath,
                width: 50.0, // Set fixed width for the SVG
                height: 50.0, // Set fixed height for the SVG
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl, // Right-to-left text direction
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
