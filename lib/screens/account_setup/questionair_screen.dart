import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lifefit/models/body_composition.dart';
import 'package:lifefit/models/user_setup_model.dart';
import 'package:lifefit/screens/diet%20plan/diet_plan.dart';

import '../../components/onBoardcontainer.dart';
import '../../constants/questions.dart';

class QuestionnaireScreen extends StatefulWidget {
   QuestionnaireScreen({super.key, required this.bodyComposition,required this.userSetup});
  UserSetup userSetup;
  BodyComposition bodyComposition;

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final Map<int, String> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

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
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(width: 8),
                Text(
                  "Questions?",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              "We will use this data to give you\n a better diet type for you",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Colors.grey,
                  ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: screenSize.height * 0.02),
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
                                  style: Theme.of(context)
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
            Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.03),
              child: FloatingActionButtonProgressWidget(
                progress: 0.95,
                onPressed: () {
                  double score = 0.0;

                  // Iterate over each question
                  for (int index in selectedOptions.keys) {
                    String selectedOption = selectedOptions[index] ?? "";
                    // Handle case if user didn't select any option
                    Map<String, dynamic> question = questions[index];
                    double factor = question["factor"];

                    // Get the index of selected option and multiply it by the factor
                    int selectedIndex = question["options"].indexOf(selectedOption);

                    double optionValue = selectedIndex.toDouble(); // Convert to double
                    score += optionValue * factor;
                    // print(index);
                  }

                  // Now, 'score' contains the calculated score based on user's answers
                  print("Calculated Score: $score");

                  widget.bodyComposition.questionnaireScore=score;
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>BMIScreen(BMI: widget.userSetup.BMI, userSetup: widget.userSetup, bodyComposition: widget.bodyComposition)));


                  // Proceed with further actions based on the score
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
