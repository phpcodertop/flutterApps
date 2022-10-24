import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final VoidCallback? onPress;
  final IconData? icon;

  const RoundIconButton({Key? key, this.onPress, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPress,
      elevation: 0,
      shape: const CircleBorder(),
      fillColor: const Color(0xFF4c4F5E),
      constraints: const BoxConstraints.tightFor(
        height: 56.0,
        width: 56.0,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
