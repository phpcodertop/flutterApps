import 'package:flutter/material.dart';
import 'tutorial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Demos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  TutorialScreen(),
    );
  }
}
