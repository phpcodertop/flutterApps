import 'package:bmicalculator/constants.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {

  VoidCallback? onPress;
  String titleStr;

  BottomButton({super.key, this.onPress, required this.titleStr});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        color: kBottomContainerColor,
        margin: const EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: 80.0,
        padding: const EdgeInsets.only(bottom: 10.0,),
        child: Center(
          child: Text(
            titleStr,
            style: kLargeButtonStyle,
          ),
        ),
      ),
    );
  }
}
