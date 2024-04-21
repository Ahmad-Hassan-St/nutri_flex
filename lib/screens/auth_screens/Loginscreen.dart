import 'package:flutter/material.dart';
import 'package:lifefit/screens/account_setup/account_setup_screen.dart';
import 'package:lifefit/screens/auth_screens/forgetpasswordscreen.dart';
import 'package:lifefit/screens/auth_screens/signup_screen.dart';
import 'package:lifefit/screens/splashscreen.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../../components/TextFieldWidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.04,
                    left: screenWidth * 0.05,
                  ),
                  child: Container(
                    height: screenHeight * 0.08,
                    width: screenHeight * 0.08,
                    child: FittedBox(
                      child: FloatingActionButton(
                        heroTag: null,
                        elevation: 0,
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenHeight * 0.05),
                        ),
                        onPressed: () {},
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
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Text(
              "Welcome Back 👋",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              "Hi there, you've been missed",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(
              height: screenHeight * 0.08,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextfieldWidget(
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
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      Container(
                        height: screenHeight * 0.08,
                        width: screenHeight * 0.08,
                        child: FittedBox(
                          child: FloatingActionButton(
                            heroTag: null,
                            elevation: 0,
                            backgroundColor: const Color(0xFF19b888),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(screenHeight * 0.05),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => SplashScreen(),
                                ),
                              );
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
              padding: EdgeInsets.only(top: screenHeight * 0.15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPassword(),
                        ),
                      );
                    },
                    child: Text(
                      'Forget password?',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Signup',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: SlideAction(
                sliderRotate: false,
                height: screenHeight * 0.07,
                elevation: 0,
                text: 'Login',
                textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                borderRadius: screenHeight * 0.03,
                sliderButtonIcon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF19b888),
                  size: 13,
                ),
                innerColor: const Color(0xFF173430),
                outerColor: const Color(0xFF173430),
                onSubmit: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserNameScreen(),
                    ),
                  );
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

  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    final passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return passwordRegExp.hasMatch(password);
  }
}
