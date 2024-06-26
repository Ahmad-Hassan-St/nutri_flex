import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lifefit/models/body_composition.dart';
import 'package:lifefit/models/user_setup_model.dart';
import 'package:lifefit/screens/diet%20plan/diet_plan.dart';
import 'package:lifefit/screens/home_feed_screen.dart';
import 'package:lifefit/utils/flutter_toast_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/onBoardcontainer.dart';
import '../../constants/questions.dart';
import '../../services/body_composition_calculations.dart';
import '../../services/dml_services.dart';
import '../animation_screen/loading_screen.dart';

class QuestionnaireScreen extends StatefulWidget {
  QuestionnaireScreen(
      {super.key, required this.bodyComposition, required this.userSetup});

  UserSetup userSetup;
  BodyComposition bodyComposition;

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final Map<int, String> selectedOptions = {};
  void _submitAnswers(BuildContext context) {
    // Navigate to the loading screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoadingScreen()),
    );

    // Wait for one minute and then navigate to the diet plan screen
    Future.delayed(Duration(seconds: 4 ), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeFeedScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: screenSize.width * 0.01,
          right: screenSize.width * 0.01,
        ),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.03,

                )
            ),
            Padding(
              padding: EdgeInsets.only(left: screenSize.width * 0.05),
              child: Container(
                width: double.infinity,
                color: Colors.white,
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
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .background,
                              size: screenSize.height * 0.025,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: screenSize.height * 0.02,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              height: screenSize.height * 0.14,
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "9",
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

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "We ask some",
                        style: Theme
                            .of(context)
                            .textTheme
                            .displayLarge,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Questions?",
                        style: Theme
                            .of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Theme
                            .of(context)
                            .colorScheme
                            .primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "We will use this data to give you\n a better diet type for you",
                    textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: screenSize.height * 0.02),
                child: Container(
                  child: Column(
                    children: questions.map((question) {
                      final index = questions.indexOf(question);
                      final text = question["text"];
                      final options = List<String>.from(question["options"]);
                      final Color? containerColor = index % 2 != 0
                          ? const Color(0xffebf6d6)
                          : Colors.grey[200];
                      return Padding(
                        padding: EdgeInsets.only(
                          top: screenSize.height * 0.015,
                          left: screenSize.width * 0.05,
                          right: screenSize.width * 0.05,
                        ),
                        child: InkWell(
                          borderRadius:
                          BorderRadius.circular(screenSize.height * 0.02),
                          onTap: () {},
                          child: Ink(
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius:
                              BorderRadius.circular(screenSize.height * 0.02),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.05,
                                vertical: screenSize.height * 0.02,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${index + 1}. $text",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                      fontSize: screenSize.height * 0.02,
                                    ),
                                  ),
                                  Column(
                                    children: options.map((option) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
                                        child: RadioListTile<String>(
                                          title: Text(option),
                                          value: option,
                                          groupValue: selectedOptions[index],
                                          onChanged: (value) {
                                            setState(() {
                                              selectedOptions[index] =
                                                  value.toString();

                                              print(selectedOptions);
                                            });
                                          },
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.03),
              child: FloatingActionButtonProgressWidget(
                progress: 0.95,
                onPressed: () async {
                  // Check if any question is unanswered
                  bool allQuestionsAnswered = selectedOptions.length ==
                      questions.length;

                  if (!allQuestionsAnswered) {
                    // Find the first unanswered question
                    int unansweredQuestion = 0;
                    for (int i = 0; i < questions.length; i++) {
                      if (!selectedOptions.containsKey(i)) {
                        unansweredQuestion = i + 1;
                        break;
                      }
                    }

                    // Display a message indicating the unanswered question
                    ShowToastMsg(
                        "Please answer question $unansweredQuestion before proceeding.");
                  } else {
                    // Proceed with calculating the score and navigating to the next screen
                    double score = 0.0;

                    // Iterate over each question
                    for (int index in selectedOptions.keys) {
                      String selectedOption = selectedOptions[index] ?? "";
                      // Handle case if user didn't select any option
                      Map<String, dynamic> question = questions[index];
                      double factor = question["factor"];

                      // Get the index of selected option and multiply it by the factor
                      int selectedIndex = question["options"].indexOf(
                          selectedOption);

                      double optionValue = selectedIndex
                          .toDouble(); // Convert to double
                      score += optionValue * factor;
                    }

                    // Now, 'score' contains the calculated score based on user's answers
                    print("Calculated Score: $score");


                    widget.bodyComposition.questionnaireScore = score;
                    double bmiscore = double.parse(widget.userSetup.BMI);
                    double dietPlan = BodyCompositionCalculation
                        .bodyResultScroe(
                        boydFatPercentage: widget.bodyComposition
                            .bodyFatPercentage,
                        waterPercentage: widget.bodyComposition
                            .bodyWaterPercentage,
                        questionScore: widget.bodyComposition
                            .questionnaireScore, bmi: bmiscore);

                    int diet = dietPlan.round();

                    print(diet);
                    if(widget.userSetup.isUpdate!=true){
                    try {
                      DmlServices.insertUserData(userSetup: widget.userSetup);
                      DmlServices.insertUserBodyCompositionData(
                          userSetup: widget.userSetup,
                          bodyComposition: widget.bodyComposition,
                          dietPlan: diet);
                      _submitAnswers(context);

                    } catch (e) {
                      ShowToastMsg("Something went wrong");
                    }
                  }
                    else {

                      SharedPreferences sp = await SharedPreferences.getInstance();
                      sp.remove('dietPlan');
                      sp.remove('target');

                      try {
                        DmlServices().updateUsersData(userSetup: widget.userSetup);
                        DmlServices().updateUserBodyComposition(
                            userSetup: widget.userSetup,
                            bodyComposition: widget.bodyComposition,
                            dietPlan: diet);
                        print("updated");
                        _submitAnswers(context);

                      } catch (e) {
                        ShowToastMsg("Something went wrong");
                      }

                    }
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
