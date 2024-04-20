import 'package:flutter/material.dart';
import 'package:lifefit/screens/account_setup_screen.dart';
import 'package:lifefit/screens/forgetpasswordscreen.dart';
import 'package:lifefit/screens/goal_screenn.dart';
import 'package:lifefit/screens/splashscreen.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../components/TextFieldWidget.dart';
import '../services/local_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    // Define padding and height based on screen size
    double paddingValue = screenSize.width < 600 ? 20.0 : 30.0;
    double actionButtonHeight = screenSize.width < 600 ? 60.0 : 60.0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: paddingValue, left: paddingValue),
                  child: Container(
                    height: 70,
                    width: 70,
                    child: FittedBox(
                      child: FloatingActionButton(
                        heroTag: null,
                        elevation: 0,
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context).colorScheme.background,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 90,
            ),
            Text(
              "Welcome 👋",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              "Hi there, Please Sign up",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingValue),
              child: Column(
                children: [
                  TextfieldWidget(
                    text: 'Email',
                    icon: Icons.mail,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextfieldWidget(
                    text: "Password",
                    icon: Icons.lock,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextfieldWidget(
                    text: "Confirm Password",
                    icon: Icons.lock,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingValue),
              child: SlideAction(
                sliderRotate: false,
                height: actionButtonHeight,
                elevation: 0,
                text: 'Signup',
                textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                borderRadius: 25,
                sliderButtonIcon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF19b888),
                  size: 13,
                ),
                innerColor: const Color(0xFF173430),
                outerColor: const Color(0xFF173430),
                onSubmit: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => GoalScreen()));
                },
                submittedIcon: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
