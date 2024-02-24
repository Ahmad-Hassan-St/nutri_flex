import 'package:flutter/material.dart';
import 'package:lifefit/screens/onboardscreen_1.dart';

import '../components/onBoardcontainer.dart';
import '../components/topbutton.dart';
import 'Loginscreen.dart';

class onBoardScreen3 extends StatefulWidget {
  const onBoardScreen3({super.key});

  @override
  State<onBoardScreen3> createState() => _onBoardScreen3State();
}

class _onBoardScreen3State extends State<onBoardScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Image.asset("assets/images/Ornament4.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 160.0),
                child: Center(child: Image.asset("assets/images/onboard3.png")),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 30, right: 30),
                child: TopRow(
                  text: "Login",
                  textcolor: Colors.white,
                  backgroundcolor: Color(0xFF19b597),
                  onpressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
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
                progress: 1,
                text1: "Live Healty & Great",
                text2:
                    "Let’s start this journey and live healty life together ",
                onpressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
