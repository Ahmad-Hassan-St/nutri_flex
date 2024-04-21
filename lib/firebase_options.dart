// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyASagstboVreQuLKyL8ItL_leoGq9UR1YQ',
    appId: '1:1065059750636:web:8ba78b0de32f527a034bc9',
    messagingSenderId: '1065059750636',
    projectId: 'nutriflex-d35a9',
    authDomain: 'nutriflex-d35a9.firebaseapp.com',
    storageBucket: 'nutriflex-d35a9.appspot.com',
    measurementId: 'G-PZ8S0ZLLF1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbRQysITy5fEgW004VOYwpHxBiEQKm7BI',
    appId: '1:1065059750636:android:a02f16de995bc70a034bc9',
    messagingSenderId: '1065059750636',
    projectId: 'nutriflex-d35a9',
    storageBucket: 'nutriflex-d35a9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4psByo-u97eZ4m8OuC5XiOD4RsaevykU',
    appId: '1:1065059750636:ios:a8d6541a9f05896b034bc9',
    messagingSenderId: '1065059750636',
    projectId: 'nutriflex-d35a9',
    storageBucket: 'nutriflex-d35a9.appspot.com',
    iosClientId: '1065059750636-kdu3krbop0q7sjld1q2pp8arrot0h966.apps.googleusercontent.com',
    iosBundleId: 'com.example.lifefit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA4psByo-u97eZ4m8OuC5XiOD4RsaevykU',
    appId: '1:1065059750636:ios:24f11ded90ae7fcd034bc9',
    messagingSenderId: '1065059750636',
    projectId: 'nutriflex-d35a9',
    storageBucket: 'nutriflex-d35a9.appspot.com',
    iosClientId: '1065059750636-lcqjtl50cvlsgdbka9dgu4rhgr3c4ijk.apps.googleusercontent.com',
    iosBundleId: 'com.example.lifefit.RunnerTests',
  );
}
