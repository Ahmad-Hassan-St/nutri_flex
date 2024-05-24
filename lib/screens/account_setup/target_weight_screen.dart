import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifefit/screens/account_setup/biceps_screen.dart';
import 'package:lifefit/screens/account_setup/weight_screen.dart';
import 'package:lifefit/screens/diet%20plan/diet_plan.dart';
import 'package:lifefit/services/dml_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/Frequency_slider.dart';
import '../../components/number_container_widget.dart';
import '../../components/onBoardcontainer.dart';
import '../../constants/colors.dart';
import '../../models/user_setup_model.dart';

class TargetWeightScreen extends StatefulWidget {
  int weight;
  UserSetup userSetup;

  TargetWeightScreen(
      {super.key, required this.weight, required this.userSetup});

  @override
  State<TargetWeightScreen> createState() => _TargetWeightScreenState();
}

class _TargetWeightScreenState extends State<TargetWeightScreen> {
  int _weight = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weight = widget.weight;
  }

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
                  "7",
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
                  "target Weight",
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
                      "KG",
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
            Padding(
              padding: const EdgeInsets.only(left: 180.0),
              child: SvgPicture.asset("assets/shapes/polygon.svg"),
            ),
            SizedBox(height: screenSize.height * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dynamicPadding * 6.5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NumberContainerWidget(
                    screenSize: screenSize,
                    text: widget.weight,
                    dynamicPadding: dynamicPadding,
                    height: 130,
                    width: 120,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: kGreyColor,
                        ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 50,
                  ),
                  NumberContainerWidget(
                    screenSize: screenSize,
                    text: _weight,
                    dynamicPadding: dynamicPadding,
                    height: 130,
                    width: 120,
                    color: kLimeGreen,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
            RadioFrequencySlider(
              intialValue: widget.weight.toDouble(),
              minCurrentVal: widget.weight.toDouble() - 20,
              maxCurrentVal: widget.weight.toDouble() + 20,
              onValueChanged: (value) {
                setState(() {
                  _weight = value.toInt();
                });
                print("Current value: $value");
              },
            ),
            SizedBox(height: screenSize.height * 0.08),
            FloatingActionButtonProgressWidget(
              progress: 0.77,
              onpressed: () async {
                // SharedPreferences sp = await SharedPreferences.getInstance();
                // widget.userSetup.email = sp.getString("email").toString();
                //
                double heightMeter = widget.userSetup.height / 100;
                double BMI =
                    widget.userSetup.weight / (heightMeter * heightMeter);

                print(BMI.toStringAsFixed(2));
                widget.userSetup.BMI = BMI.toStringAsFixed(2);
                widget.userSetup.targetWeight = _weight;
                widget.userSetup.age ?? "23";

                // DmlServices.insertUserData(userSetup: widget.userSetup);
                //
                // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>BMIScreen(BMI: BMI.toString(), userSetup: widget.userSetup,)), (route) => false);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BicepScreen(
                      userSetup: widget.userSetup,
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
