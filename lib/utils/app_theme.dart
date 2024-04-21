import 'package:flutter/material.dart';

import '../constants/colors.dart';

ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: kPrimaryColorGreen,
    secondary: kSecondaryDarkGreen,
    tertiary: kWhiteColor,
    background: kBlackColor,
    surface: kContainerWhiteColor,
    onBackground: Colors.white,
    tertiaryContainer: kGreyColor,
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: "Zen Kaku Gothic Antique",
      fontSize: 26,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontFamily: "Zen Kaku Gothic Antique",
      fontSize: 15,
    ),
    displaySmall: TextStyle(
      fontFamily: "Zen Kaku Gothic Antique",
      fontSize: 10,
    ),
    labelLarge: TextStyle(
      fontFamily: "Zen Kaku Gothic Antique",
      fontSize: 44,
      color: kSecondaryDarkGreen,
      fontWeight: FontWeight.bold,
    ),
  ),
  // elevatedButtonTheme: ElevatedButtonThemeData(),
  iconTheme: IconThemeData(),
  floatingActionButtonTheme: FloatingActionButtonThemeData(),
);
