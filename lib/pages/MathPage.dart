// MathPage.dart
import 'package:flutter/material.dart';

class MathPage extends StatefulWidget {
  @override
  _MathPageState createState() => _MathPageState();
}

class _MathPageState extends State<MathPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Math Page'),
      ),
      body: Center(
        child: Text(
          'This is the Math Page',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
