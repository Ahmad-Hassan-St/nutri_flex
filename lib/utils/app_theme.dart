
import 'package:flutter/material.dart';

import '../constants/colors.dart';

ThemeData appTheme=ThemeData(

  // brightness: Brightness.light,
  colorScheme:  const ColorScheme.light(
    primary: primaryColorGreen,
    secondary: secondaryDarkGreen,
    tertiary: whiteColor,
    background: blackColor,
    surface: containerWhiteColor,
    onBackground: Colors.white
  ),
  scaffoldBackgroundColor: Colors.white,

);