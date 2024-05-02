import 'package:flutter/material.dart';
import 'package:lifefit/services/diet_plan_services.dart';

import '../../models/user_setup_model.dart';

class BMIScreen extends StatefulWidget {
  String BMI;
  UserSetup userSetup;

  BMIScreen({
    super.key,
    required this.BMI,
    required this.userSetup,
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
            return Center(child: CircularProgressIndicator());
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
                    SizedBox(height: 20), // Add some spacing
                    Text(data["day_1"]['breakfast']['items'][2].toString()),
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
