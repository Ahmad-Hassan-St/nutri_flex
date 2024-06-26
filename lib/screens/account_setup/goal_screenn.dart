import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifefit/components/onBoardcontainer.dart';
import 'package:lifefit/constants/colors.dart';
import 'package:lifefit/screens/account_setup/account_setup_screen.dart';
import 'package:lifefit/screens/account_setup/gender_screen.dart';
import 'package:lifefit/utils/flutter_toast_message.dart';

import '../../models/user_setup_model.dart';

class GoalScreen extends StatefulWidget {
  UserSetup userSetup;

  GoalScreen({super.key, required this.userSetup});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  // Define a list of objects where each object contains text and image information
  final List<Map<String, dynamic>> goals = [
    {"text": "Lose weight", "imagePath": "assets/icons/banana.svg"},
    {"text": "Gain weight", "imagePath": "assets/icons/dumbel.svg"},
    {"text": "Stay healthy", "imagePath": "assets/icons/victory.svg"},
  ];

  String goal = "";

  @override
  Widget build(BuildContext context) {
    // Getting screen size
    final Size screenSize = MediaQuery.of(context).size;
    print(goal);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.03,
          left: screenSize.width * 0.01,
          right: screenSize.width * 0.01,
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
                          Navigator.pop(context);
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
            SizedBox(height: screenSize.height * 0.02),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "2",
                  style: TextStyle(
                    fontFamily: "Zen Kaku Gothic Antique",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "/9",
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
                  "What is your",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "goal?",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.039),
                child: ListView.builder(
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    // Get the text and image information from the list
                    final String text = goals[index]["text"];
                    final String imagePath = goals[index]["imagePath"];
                    final bool isSelected = goal == text;

                    final Color? containerColor =  index == 1 ? const Color(0xffebf6d6) : Colors.grey[200];

                    return Padding(
                      padding: EdgeInsets.only(
                        top: screenSize.height * 0.015,
                        left: screenSize.width * 0.05,
                        right: screenSize.width * 0.05,
                      ),
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(screenSize.height * 0.02),
                        onTap: () {
                          setState(() {
                            goal = goals[index]["text"];


                          });
                        },
                        child: Ink(
                          height: screenSize.height * 0.135,
                          decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: BorderRadius.circular(screenSize.height * 0.02),
                            border: Border.all(color: isSelected ? kBlackColor : Colors.transparent, width: 2), // Add border based on selection
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.05,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  text,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        fontSize: screenSize.height * 0.02,
                                      ),
                                ),
                                SvgPicture.asset(imagePath),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.03),
              child: FloatingActionButtonProgressWidget(
                progress: 0.22,
                onPressed: () {
                  if(goal != "") {
                    widget.userSetup.goal = goal;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GenderScreen(
                              userSetup: widget.userSetup,
                            ),
                      ),
                    );
                  }
                  else{
                    ShowToastMsg("Please select your Goal !");
                  }
                },
                icon: Icons.arrow_forward_ios_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
