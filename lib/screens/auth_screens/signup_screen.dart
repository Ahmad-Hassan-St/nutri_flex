import 'package:flutter/material.dart';
import 'package:lifefit/screens/auth_screens/Loginscreen.dart';
import 'package:lifefit/screens/account_setup/goal_screenn.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../../components/TextFieldWidget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmpasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmpasswordController= TextEditingController();
  }
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
                        onPressed: () {Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );},
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
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
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!_isValidEmail(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
                  const SizedBox(
                    height: 20,
                  ),
              TextfieldWidget(
                text: 'Password',
                icon: Icons.lock,
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (!_isValidPassword(value)) {
                    return 'Password must contain at least 8 characters\n '
                        '1 uppercase letter\n '
                        '1 special character';
                  }
                  return null;
                },
              ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextfieldWidget(
                    text: 'Confirm Password',
                    icon: Icons.lock,
                    obscureText: true,
                    controller: _confirmpasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Re-enter your password';
                      }
                      if (!_isValidPassword(value)) {
                        return 'Password must contain at least 8 characters\n '
                            '1 uppercase letter\n '
                            '1 special character';
                      }
                      return null;
                    },
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

bool _isValidEmail(String email) {
  final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegExp.hasMatch(email);
}

bool _isValidPassword(String password) {
  final passwordRegExp =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  return passwordRegExp.hasMatch(password);
}
