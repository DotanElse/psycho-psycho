// question_page.dart
import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Page'),
      ),
      body: Center(
        child: Text(
          'This is the Question Page',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
