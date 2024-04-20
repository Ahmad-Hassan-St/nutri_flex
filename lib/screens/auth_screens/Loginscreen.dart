import 'package:flutter/material.dart';
import 'package:lifefit/screens/account_setup/account_setup_screen.dart';
import 'package:lifefit/screens/auth_screens/forgetpasswordscreen.dart';
import 'package:lifefit/screens/splashscreen.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../components/TextFieldWidget.dart';
import '../../services/local_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, left: 30),
                  child: Container(
                    height: 70,
                    width: 70,
                    child: FittedBox(
                      child: FloatingActionButton(
                        heroTag: null,
                        elevation: 0,
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
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
              "Welcome Back 👋",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              "Hi there, you've been missed",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                children: [
                  TextfieldWidget(
                    text: 'Email',
                    icon: Icons.mail,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextfieldWidget(
                          text: "Password",
                          icon: Icons.lock,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        child: FittedBox(
                          child: FloatingActionButton(
                            heroTag: null,
                            elevation: 0,
                            backgroundColor: const Color(0xFF19b888),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            onPressed: () async {
                              final isAuthenticated =
                                  await LocalAuthApi.authenticate();
                              print(isAuthenticated);
                              if (isAuthenticated) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => SplashScreen()),
                                );
                              }
                            },
                            child: const Icon(
                              Icons.fingerprint_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 180.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPassword()));
                },
                child: Text(
                  "Forget password?",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SlideAction(
                sliderRotate: false,
                height: 60,
                elevation: 0,
                text: 'Login',
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
                      MaterialPageRoute(builder: (context) => UserNameScreen()));
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