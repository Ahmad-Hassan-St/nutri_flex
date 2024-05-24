import 'package:flutter/material.dart';
import 'package:lifefit/services/diet_plan_services.dart';

import '../../models/user_setup_model.dart';
import '../../models/body_composition.dart';

class BMIScreen extends StatefulWidget {
  String BMI;
  UserSetup userSetup;
  BodyComposition  bodyComposition;

  BMIScreen({
    super.key,
    required this.BMI,
    required this.userSetup,
    required this.bodyComposition,
  });

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  void dietPlan() {
    print(widget.userSetup.goal);
    DietPlanService.suggestDietPlan(widget.userSetup.goal);
  }

  @override
  void initState() {
    dietPlan();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: DietPlanService.suggestDietPlan(widget.userSetup.goal),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If an error occurred
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // If data has been loaded successfully
            var data = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('BMI Calculator ${widget.BMI}'),
                    const SizedBox(height: 20), // Add some spacing
                    Text(data.toString()),

                    const Text("------------------------------------------------"),
                    const Text("Body information",style: TextStyle(fontSize: 40),),

                    Text("Weight: ${widget.userSetup.weight}"),
                    Text("Height: ${widget.userSetup.height}"),

                    Text("gender: ${widget.userSetup.gender}"),
                    Text("age: ${widget.userSetup.age}"),
                    Text("Bicep: ${widget.userSetup.bicepSize}"),

                    Text("BMi: ${widget.userSetup.BMI}"),

                    const Text("------------------------------------------------"),
                    const Text("Body COmposition",style: TextStyle(fontSize: 40),),

                    Text("Fat Mass: ${widget.bodyComposition.fatMass.toStringAsFixed(2)}"),
                    Text("Lean Mass: ${widget.bodyComposition.leanMass.toStringAsFixed(2)}"),
                    Text("Muscle Mass: ${widget.bodyComposition.muscleMass.toStringAsFixed(2)}"),
                    Text("Calories: ${widget.bodyComposition.calories.toStringAsFixed(2)}"),
                    Text(
                        "Body Water Percentage: ${widget.bodyComposition.bodyWaterPercentage.toStringAsFixed(2)}%"),
                    Text(
                        "Body Fat Percentage: ${widget.bodyComposition.bodyFatPercentage.toStringAsFixed(2)}%"),

                    Text("----------------------------------------------------------------"),
                    Text("Question Score",style: TextStyle(fontSize: 50),),
                    Text("Score : ${widget.bodyComposition.questionnaireScore.toStringAsFixed(2)}")
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

}
