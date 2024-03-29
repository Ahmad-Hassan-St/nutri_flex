import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lifefit/screens/onboardscreen_1.dart';

import '../components/onBoardcontainer.dart';
import '../components/topbutton.dart';
import 'Loginscreen.dart';

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
                  textcolor: Colors.white,
                  backgroundcolor: const Color(0xFF19b597),
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
                  double containerHeight = (height - 400).clamp(0, double.infinity);
                  double containerWidth = (width - 50).clamp(0, double.infinity);

                  return Container(
                    width: containerWidth,
                    child: const Column(
                      children: [
                        ListTile(
                          title: Text("Continue with Email"),
                          trailing: Icon(Icons.email),
                        ),
                        Divider(
                          indent: 30,
                          endIndent: 30,
                        ),
                        ListTile(
                          title: Text("Continue with Google"),
                          trailing: Icon(Icons.apple),
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
                  double containerHeight = (height - 400).clamp(0, double.infinity);
                  double containerWidth = (width - 50).clamp(0, double.infinity);

                  return Container(
                    width: containerWidth,
                    child: const ListTile(
                      title: Text("Cancel"),
                      trailing: Icon(Icons.cancel_outlined),
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
