import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seller_app/screens/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  setTimer() {
    Timer(const Duration(seconds: 5), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AuthScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    setTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset('images/splash.jpg'),
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                "Sell Your food here",
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Signatra',
                  letterSpacing: 3,
                  color: Colors.black54
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
