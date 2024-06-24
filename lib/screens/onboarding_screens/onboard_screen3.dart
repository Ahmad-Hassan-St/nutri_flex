import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lifefit/screens/auth_screens/signup_screen.dart';
import 'package:lifefit/utils/flutter_toast_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../chat_module/api/apis.dart';
import '../../components/onBoardcontainer.dart';
import '../../components/topbutton.dart';
import '../../services/auth_services.dart';
import '../../services/dml_services.dart';
import '../account_setup/account_setup_screen.dart';
import '../auth_screens/Loginscreen.dart';
import '../home_feed_screen.dart';

class onBoardScreen3 extends StatefulWidget {
  const onBoardScreen3({super.key});

  @override
  State<onBoardScreen3> createState() => _onBoardScreen3State();
}

class _onBoardScreen3State extends State<onBoardScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Image.asset("assets/images/Ornament4.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 160.0),
                child: Center(child: Image.asset("assets/images/onboard3.png")),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 30, right: 30),
                child: TopRow(
                  text: "Login",
                  textcolor: Theme.of(context).colorScheme.tertiary,
                  backgroundcolor: Theme.of(context).colorScheme.primary,
                  onpressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 95,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: onboardContainer(
                progress: 1,
                text1: "Live Healty & Great",
                text2:
                    "Let’s start this journey and live healty life together ",
                onpressed: () {
                  showCustomDialog(context);
                },
              ),
            ),
          )
        ],
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

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AlertDialog(
                insetPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                content: Builder(
                  builder: (context) {
                    var height = MediaQuery.of(context).size.height;
                    var width = MediaQuery.of(context).size.width;

                    // Adjustments to ensure non-negative dimensions
                    double containerHeight =
                    (height - 400).clamp(0, double.infinity);
                    double containerWidth =
                    (width - 50).clamp(0, double.infinity);

                    return Container(
                      color: Theme.of(context).colorScheme.onBackground,
                      width: containerWidth,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Continue with Email",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            trailing: SvgPicture.asset("assets/icons/email.svg"),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                          ),
                          Divider(
                            indent: 30,
                            endIndent: 30,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          ListTile(
                            title: Text(
                              "Continue with Google",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            trailing: SvgPicture.asset("assets/icons/google.svg"),
                            onTap: () async {
                              UserCredential userCredential =
                              await AuthServices().SignInWithGoogle();
                              User? user = userCredential.user;
                              if (user != null) {
                                SharedPreferences sp =
                                await SharedPreferences.getInstance();
                                sp.setString("email", user.email.toString());

                                ShowToastMsg("Registration with google");

                                print(user);

                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => const UserNameScreen(),
                                //   ),
                                // );
                              }


                              if (user != null) {
                                ShowToastMsg(
                                    "${user.email}. is login successful");

                                final data = await DmlServices().fetchDataUserDetails(user.email);
                                if (data != null && data.isNotEmpty) {
                                  print(data);
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


                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              AlertDialog(
                insetPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                content: Builder(
                  builder: (context) {
                    var height = MediaQuery.of(context).size.height;
                    var width = MediaQuery.of(context).size.width;

                    // Adjustments to ensure non-negative dimensions
                    double containerHeight =
                    (height - 400).clamp(0, double.infinity);
                    double containerWidth =
                    (width - 50).clamp(0, double.infinity);

                    return InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Ink(
                        color: Theme.of(context).colorScheme.onBackground,
                        width: containerWidth,
                        child: ListTile(
                          title: Text(
                            "Cancel",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(color: Colors.red),
                          ),
                          trailing: SvgPicture.asset("assets/icons/cancel.svg"),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
