import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:lifefit/firebase_options.dart';
import 'package:lifefit/screens/auth_screens/Loginscreen.dart';
import 'package:lifefit/screens/splashscreen.dart';
import 'package:lifefit/services/auth_services.dart';
import 'package:lifefit/services/check_internet_services.dart';
import 'package:lifefit/utils/app_theme.dart';


List<CameraDescription> cameras = [];
late Size mq = Size(0, 0);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) async {
    _initializeFirebase();
    cameras = await availableCameras();

    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // AuthServices().handleLogout(context);
    return SafeArea(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          home: SplashScreen(),
      ),
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var result = await FlutterNotificationChannel().registerNotificationChannel(
      description: 'For Showing Message Notification',
      id: 'chats',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats');

  print('\nNotification Channel Result: $result');
}
