import 'package:flutter/material.dart';
import 'package:ui/grid_images.dart';
import 'package:ui/image_carousel.dart';

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
      home:  GridImages(),
    );
  }
}
