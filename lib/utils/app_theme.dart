import 'package:flutter/material.dart';

import '../constants/colors.dart';

ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: primaryColorGreen,
    secondary: secondaryDarkGreen,
    tertiary: whiteColor,
    background: blackColor,
    surface: containerWhiteColor,
    onBackground: Colors.white,
    tertiaryContainer: greyColor,
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
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(

  ),
  iconTheme: IconThemeData(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(

)

);
