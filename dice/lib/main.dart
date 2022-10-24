import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: const Text('Dice'),
          backgroundColor: Colors.red,
        ),
        body: MyDicePage(),
      ),
    ),
  );
}

class MyDicePage extends StatefulWidget {
  const MyDicePage({Key? key}) : super(key: key);

  @override
  State<MyDicePage> createState() => _MyDicePageState();
}

class _MyDicePageState extends State<MyDicePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;

  void shuffleNumbers() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children:  [
          Expanded(
            child: TextButton(
              onPressed: shuffleNumbers,
              child: Image.asset('images/dice$leftDiceNumber.png'),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: shuffleNumbers,
              child: Image.asset('images/dice$rightDiceNumber.png'),
            ),
          ),
        ],
      ),
    );
  }
}