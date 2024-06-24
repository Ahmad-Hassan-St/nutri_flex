import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lifefit/screens/auth_screens/Loginscreen.dart';
import 'package:lifefit/utils/flutter_toast_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/validations.dart';



class AuthServices {
  final _auth = FirebaseAuth.instance;

  SignInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credentials = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    return await _auth.signInWithCredential(credentials);
  }
  forgetPassword(String email) async {
    await _auth.sendPasswordResetEmail(
      email: email,
    );
    ShowToastMsg("Check your EMail");
  }

  signUpAuth({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        return user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ShowToastMsg('Try another Email, It\'s already in use');
      } else {
        print("Error : ${e.code}");
        ShowToastMsg("Something is wrong");
      }
    }
  }

  signInAuth({required String email, required String password}) async {
    if (!isValidEmail(email)
    // && !isPasswordValid(password)
    ) {
      ShowToastMsg("Please enter a valid email and password");
    }
    else {
      try {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString("email", email);
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (user != null) {
          return user;
        }
      } on FirebaseException catch (e) {
        ShowToastMsg("Error: " + e.message.toString());
        print(e.toString());
      }
    }
  }

  void changePassword(String newPassword) async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    try {
      // Update the user's password
      await user?.updatePassword(newPassword);

      // Password change successful
      print("Password changed successfully!");
    } catch (e) {
      // Handle password change errors
      print("Failed to change password: $e");
    }
  }

  handleLogout(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('email');
    sp.remove('dietPlan');
    sp.remove('target');

    await _auth.signOut();
    ShowToastMsg("You are logout");
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
    );
  }
}