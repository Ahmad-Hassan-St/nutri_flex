import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lifefit/constants/colors.dart';
import 'package:lifefit/screens/account_setup/account_setup_screen.dart';
import 'package:lifefit/screens/auth_screens/Loginscreen.dart';
import 'package:lifefit/screens/home_feed_screen.dart';
import 'package:lifefit/screens/profile%20screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_screens/onboardscreen_1.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
            () => checkIsLogin()
    );
  }
  void checkIsLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('email');
    bool ? isShowOnboard=sp.getBool("isShowBoardingScreens");

    print(token);
    print(isShowOnboard);
    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>   HomeFeedScreen()));
    }
    else if (isShowOnboard == true) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
    else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnBoardingScreen()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: kGradientColor,
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
