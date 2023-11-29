// EnglishPage.dart
import 'package:flutter/material.dart';

class EnglishPage extends StatefulWidget {
  @override
  _EnglishPageState createState() => _EnglishPageState();
}

class _EnglishPageState extends State<EnglishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('English Page'),
      ),
      body: Center(
        child: Text(
          'This is the English Page',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
