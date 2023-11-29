// HebrewPage.dart
import 'package:flutter/material.dart';

class HebrewPage extends StatefulWidget {
  @override
  _HebrewPageState createState() => _HebrewPageState();
}

class _HebrewPageState extends State<HebrewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hebrew Page'),
      ),
      body: Center(
        child: Text(
          'This is the Hebrew Page',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
