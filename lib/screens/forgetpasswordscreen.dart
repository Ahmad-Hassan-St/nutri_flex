import 'package:flutter/material.dart';
import 'package:lifefit/components/TextFieldWidget.dart';
import 'package:lifefit/screens/splashscreen.dart';
import 'package:slide_to_act/slide_to_act.dart';

import 'Loginscreen.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.arrow_back_ios,
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
              height: 140,
            ),
            const Text(
              "Recover Password 🤓",
              style: TextStyle(
                fontFamily: "Zen Kaku Gothic Antique",
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Forget password? No worries!",
              style: TextStyle(
                fontFamily: "Zen Kaku Gothic Antique",
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                children: [
                  TextfieldWidget(text: 'Email', icon: Icons.mail),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(height: 270,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SlideAction(
                sliderRotate: false,
                height: 60,
                elevation: 0,
                text: 'Submit',
                textStyle: const TextStyle(
                  fontFamily: "Zen Kaku Gothic Antique",
                  color: Colors.white,
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
                      MaterialPageRoute(builder: (context) => SplashScreen()));
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
