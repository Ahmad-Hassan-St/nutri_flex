import 'package:flutter/material.dart';
import 'package:lifefit/screens/home_feed_screen.dart';
import 'package:lifefit/screens/splashscreen.dart';
import 'package:lifefit/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: SplashScreen(),
      ),
    );
  }
}
