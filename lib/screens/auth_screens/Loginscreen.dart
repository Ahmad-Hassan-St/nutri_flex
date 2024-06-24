import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifefit/constants/colors.dart';
import 'package:lifefit/screens/account_setup/account_setup_screen.dart';
import 'package:lifefit/screens/auth_screens/forgetpasswordscreen.dart';
import 'package:lifefit/screens/auth_screens/signup_screen.dart';
import 'package:lifefit/screens/home_feed_screen.dart';
import 'package:lifefit/screens/splashscreen.dart';
import 'package:lifefit/services/auth_services.dart';
import 'package:lifefit/services/dml_services.dart';
import 'package:lifefit/utils/flutter_toast_message.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../../chat_module/api/apis.dart';
import '../../chat_module/helper/dialogs.dart';
import '../../components/TextFieldWidget.dart';
import '../../services/local_auth.dart';
import '../../utils/validations.dart';

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

  bool isBiometricAuth = false;

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
                      if (!isValidEmail(value)) {
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
                            if (!isValidPassword(value)) {
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
                            backgroundColor:
                                isBiometricAuth ? kGreenColor : kRedColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(screenHeight * 0.05),
                            ),
                            onPressed: () async {
                              final isAuthenticated =
                                  await LocalAuthApi.authenticate();
                              print(isAuthenticated);
                              if (isAuthenticated) {
                                setState(() {
                                  isBiometricAuth = true;
                                });
                              } else {
                                setState(() {
                                  isBiometricAuth = false;
                                });
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
              padding: const EdgeInsets.only(top: 18.0),
              child: isBiometricAuth
                  ? Text(
                      "Biometric Authentication Successfully",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: kGreenColor),
                    )
                  : Text(
                      "Authenticate Biometric First",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: kRedColor,
                              ),
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.06),
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
                onSubmit: () async {
                  if (!isBiometricAuth) {
                    ShowToastMsg("First authenticate Biometric");
                  } else {
                    try {
                      UserCredential user = await AuthServices().signInAuth(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                      if (user != null) {
                        ShowToastMsg(
                            "${user.user?.email}. is login successful");

                        final data = await DmlServices()
                            .fetchDataUserDetails(_emailController.text.trim());
                        if (data != null) {
                          _checKUserExistsOrAdd();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeFeedScreen(),
                            ),
                          );
                        } else {
                          _checKUserExistsOrAdd();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserNameScreen(),
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
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

  _checKUserExistsOrAdd() async {
    //for showing progress bar

    if (await APIs.userExists() && mounted) {
    } else {
      await APIs.createUser();
    }
  }
}
