import 'package:flutter/material.dart';
import 'package:lifefit/screens/onboard_screen3.dart';

import '../components/onBoardcontainer.dart';
import '../components/topbutton.dart';
import 'onboardscreen_1.dart';

class onboardScreen2 extends StatefulWidget {
  const onboardScreen2({super.key});

  @override
  State<onboardScreen2> createState() => _onboardScreen2State();
}

class _onboardScreen2State extends State<onboardScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Positioned(
              right: 2,
              top: 2,
              child: Image.asset("assets/images/Ornament3.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 160.0),
              child: Center(child: Image.asset("assets/images/onboard2.png")),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 30, right: 30),
              child: TopRow(
                text: "Skip",
                textcolor: Colors.black,
                backgroundcolor: const Color(0xFFf6f7f7),
                onpressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => onBoardScreen3()));
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 95,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: onboardContainer(
              progress:0.66,

              icon: Icons.arrow_forward_ios,
              text1: "Track Your Diet",
              text2:
                  "We will help you lose weight, stay fit, or build muscle",
              onpressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => onBoardScreen3()));
              },
            ),
          ),
        )
      ],
    ));
  }
}
