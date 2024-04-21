import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifefit/components/onBoardcontainer.dart';
import 'package:lifefit/screens/account_setup/date_of_birth_screen.dart';
import 'package:lifefit/screens/account_setup/goal_screenn.dart';

class GenderScreen extends StatelessWidget {
  // Define a list of objects where each object contains text and image information
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
                          borderRadius: BorderRadius.circular(screenSize.height * 0.06),
                        ),
                        onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GoalScreen()));},
                        child: Padding(
                          padding: EdgeInsets.only(left: screenSize.width * 0.025),
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
                  "3",
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
                  "What is your",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "gender?",
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
            SizedBox(height: screenSize.height * 0.088),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int index = 0; index < goals.length; index++)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: dynamicPadding,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: screenSize.height * 0.26,
                        width: screenSize.width * 0.43,
                        decoration: BoxDecoration(
                          color: index == 1 ? const Color(0xffebf6d6) : Colors.grey[200],
                          borderRadius: BorderRadius.circular(screenSize.height * 0.04),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: dynamicPadding,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(goals[index]["imagePath"]),
                              Text(
                                goals[index]["text"],
                                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontSize: screenSize.height * 0.02,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.18),
            FloatingActionButtonProgressWidget(
                progress: 0.375,
                onpressed: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const DateBirthScreen()));},
                icon: Icons.arrow_forward_ios_outlined)
          ],
        ),
      ),
    );
  }
}
