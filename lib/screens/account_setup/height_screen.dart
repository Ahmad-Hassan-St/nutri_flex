import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifefit/screens/account_setup/date_of_birth_screen.dart';
import 'package:lifefit/screens/account_setup/goal_screenn.dart';

import '../../components/onBoardcontainer.dart';
import '../../constants/colors.dart';

class HeightScreen extends StatelessWidget {
  HeightScreen({super.key});

  final List<Map<String, dynamic>> goals = [
    {"text": "Male", "imagePath": "assets/icons/male.svg"},
    {"text": "Female", "imagePath": "assets/icons/female.svg"},
  ];

  @override
  Widget build(BuildContext context) {
    // Getting screen size
    final Size screenSize = MediaQuery.of(context).size;

    // Calculate dynamic padding
    final double dynamicPadding = screenSize.width * 0.012;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.03,
          left: dynamicPadding,
          right: dynamicPadding,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: screenSize.width * 0.05),
              child: Row(
                children: [
                  Container(
                    height: screenSize.height * 0.09,
                    width: screenSize.height * 0.09,
                    child: FittedBox(
                      child: FloatingActionButton(
                        heroTag: null,
                        elevation: 0,
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenSize.height * 0.06),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoalScreen()));
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.025),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context).colorScheme.background,
                            size: screenSize.height * 0.025,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.04),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "5",
                  style: TextStyle(
                    fontFamily: "Zen Kaku Gothic Antique",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "/8",
                  style: TextStyle(
                    fontFamily: "Zen Kaku Gothic Antique",
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "How",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Tall",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                Text(
                  " are you?",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "We will use this data to give you\n a better diet type for you",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Colors.grey,
                  ),
            ),
            SizedBox(height: screenSize.height * 0.008),
            Container(
              width: screenSize.width * 0.15,
              height: screenSize.height * 0.04,
              child: Card(
                color: Theme.of(context).colorScheme.secondary,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      "cm",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.028),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dynamicPadding,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      height: 140,
                      width: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xffebf6d6),
                        borderRadius:
                            BorderRadius.circular(screenSize.height * 0.04),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: dynamicPadding,
                        ),
                        child: Center(
                          child: Text(
                            "178",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.028),

                    Container(
                      height: 180,
                      width: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xffebf6d6),
                        borderRadius:
                        BorderRadius.circular(screenSize.height * 0.04),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: dynamicPadding,
                        ),
                        child: Center(
                          child: Text(
                            "179",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.028),

                    Container(
                      height: 140,
                      width: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xffebf6d6),
                        borderRadius:
                        BorderRadius.circular(screenSize.height * 0.04),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: dynamicPadding,
                        ),
                        child: Center(
                          child: Text(
                            "180",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.028),

                    Container(
                      height: 140,
                      width: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xffebf6d6),
                        borderRadius:
                        BorderRadius.circular(screenSize.height * 0.04),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: dynamicPadding,
                        ),
                        child: Center(
                          child: Text(
                            "181",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.18),
            FloatingActionButtonProgressWidget(
                progress: 0.77,
                onpressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DateBirthScreen(),
                    ),
                  );
                },
                icon: Icons.arrow_forward_ios_outlined)
          ],
        ),
      ),
    );
  }
}
