import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lifefit/firebase_options.dart';
import 'package:lifefit/screens/account_setup/account_setup_screen.dart';
import 'package:lifefit/screens/account_setup/date_of_birth_screen.dart';
import 'package:lifefit/screens/account_setup/height_screen.dart';
import 'package:lifefit/screens/account_setup/weight_screen.dart';
import 'package:lifefit/screens/auth_screens/Loginscreen.dart';
import 'package:lifefit/screens/home_feed_screen.dart';
import 'package:lifefit/screens/auth_screens/signup_screen.dart';
import 'package:lifefit/screens/profile%20screens/profile_screen.dart';
import 'package:lifefit/screens/splashscreen.dart';
import 'package:lifefit/utils/app_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        home:const ProfileScreen(),
      ),
    );
  }
}
