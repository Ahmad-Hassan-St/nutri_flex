import 'package:flutter/material.dart';
import 'package:lifefit/components/topbutton.dart';
import 'package:lifefit/screens/onboarding_screens/onboard_screen2.dart';
import 'package:lifefit/screens/onboarding_screens/onboard_screen3.dart';
import '../../components/onBoardcontainer.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Positioned(
              right: 0,
              top: 1,
              child: Image.asset("assets/images/Ornament2.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 160.0),
              child: Center(child: Image.asset("assets/images/onboard1.png")),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 30, right: 30),
              child: TopRow(
                text: "Skip",
                textcolor:Theme.of(context).colorScheme.background,
                backgroundcolor: Theme.of(context).colorScheme.tertiary,
                onpressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>onBoardScreen3()));
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
              progress:0.33,
              icon: Icons.arrow_forward_ios,
              text1: "Know What You Eat",
              text2: "Gain insights in your nutritional habits with detailed statistics",
              onpressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => onboardScreen2()));
              },
            ),
          ),
        )
      ],
    ));
  }
}
