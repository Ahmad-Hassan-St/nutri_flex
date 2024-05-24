import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifefit/models/body_composition.dart';
import 'package:lifefit/screens/account_setup/questionair_screen.dart';
import 'package:lifefit/screens/diet%20plan/diet_plan.dart';
import 'package:lifefit/services/diet_plan_services.dart';

import '../../components/Frequency_slider.dart';
import '../../components/number_container_widget.dart';
import '../../components/onBoardcontainer.dart';
import '../../constants/colors.dart';
import '../../models/user_setup_model.dart';
import '../../services/body_composition_calculations.dart';

class BicepScreen extends StatefulWidget {
  UserSetup userSetup;

  BicepScreen({super.key, required this.userSetup});

  @override
  State<BicepScreen> createState() => _BicepScreenState();
}

class _BicepScreenState extends State<BicepScreen> {
  @override
  int bicepSize = 10;

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
            SizedBox(height: screenSize.height * 0.04),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "8",
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
                  "Your",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Bicep Circumference",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
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
            SizedBox(height: screenSize.height * 0.025),
            SvgPicture.asset("assets/shapes/polygon.svg"),
            SizedBox(height: screenSize.height * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dynamicPadding,
              ),
              child: NumberContainerWidget(
                screenSize: screenSize,
                text: bicepSize,
                dynamicPadding: dynamicPadding,
                height: 130,
                width: 120,
                color: kLimeGreen,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            RadioFrequencySlider(
              intialValue: 15,
              minCurrentVal: 10,
              maxCurrentVal: 70,
              onValueChanged: (value) {
                setState(() {
                  bicepSize = value.toInt();
                });
                print("Current value: $value");
              },
            ),
            SizedBox(height: screenSize.height * 0.08),
            FloatingActionButtonProgressWidget(
              progress: 0.88,
              onPressed: () {
                BodyComposition bodyComposition = BodyComposition();

                widget.userSetup.bicepSize = bicepSize;
                print(widget.userSetup.age);
                double height = widget.userSetup.height.toDouble();
                double weight = widget.userSetup.weight.toDouble();
                int age = int.parse(widget.userSetup.age);
                double bicep = bicepSize.toDouble();
                String gender = widget.userSetup.gender;

                double bodyFatPercentage =
                    BodyCompositionCalculation.bodyFatPercentage(
                  bicepSize: bicep,
                  height: height,
                );
                double fatMass = BodyCompositionCalculation.fatMass(
                  totalBodyWeight: weight,
                  bodyFatPercentage: bodyFatPercentage,
                );

                double leanMass = BodyCompositionCalculation.leanMass(
                    bodyWeight: weight, bodyFatPercentage: bodyFatPercentage);
                double muscleMass = BodyCompositionCalculation.muscleMass(
                  totalBodyWeight: weight,
                  fatMass: fatMass,
                );

                double calories = BodyCompositionCalculation.calories(
                  weight: weight,
                  height: height,
                  gender: widget.userSetup.gender,
                  age: age,
                );

                double bodyWaterPercentage =
                    BodyCompositionCalculation.totalBodyWaterPercentage(
                        weight: weight,
                        height: height,
                        gender: gender,
                        age: age);

                double results = bodyWaterPercentage +
                    fatMass +
                    leanMass +
                    muscleMass +
                    bodyWaterPercentage;

                bodyComposition.fatMass = fatMass;
                bodyComposition.leanMass = leanMass;
                bodyComposition.muscleMass = muscleMass;
                bodyComposition.calories = calories;
                bodyComposition.bodyWaterPercentage = bodyWaterPercentage;
                bodyComposition.bodyFatPercentage = bodyFatPercentage;

                print(bodyFatPercentage);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuestionnaireScreen(
                      userSetup: widget.userSetup,
                      bodyComposition: bodyComposition,
                    ),
                  ),
                );
              },
              icon: Icons.arrow_forward_ios_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
