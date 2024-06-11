import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lifefit/firebase_options.dart';
import 'package:lifefit/screens/account_setup/account_setup_screen.dart';
import 'package:lifefit/screens/diet%20plan/show_dietPlan_screens.dart';
import 'package:lifefit/screens/home_feed_screen.dart';
import 'package:lifefit/screens/profile%20screens/profile_screen.dart';
import 'package:lifefit/screens/scanner/scanner_screen.dart';
import 'package:lifefit/screens/splashscreen.dart';
import 'package:lifefit/utils/app_theme.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          // home:  ScannerScreen(camera: cameras.first,)
          home:  SplashScreen()

      ),
    );
  }
}
