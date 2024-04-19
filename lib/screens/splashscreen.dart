import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lifefit/constants/colors.dart';

import 'onboardscreen_1.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: gradientColor,
            center: Alignment.topCenter,
            radius: 5,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 1,
              bottom: 13,
              child: Image.asset("assets/images/Ornament.png"),
            ),
            // Background image
            Center(
              child: Image.asset(
                'assets/images/Logo.png',
                height: 150,
              ),
            ),
          ], // Add your other Stack children here
        ),
      ),
    );
  }
}
