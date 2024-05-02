import 'package:flutter/material.dart';
import 'package:lifefit/services/diet_plan_services.dart';

import '../../models/user_setup_model.dart';

class BMIScreen extends StatefulWidget {
  String BMI;
  UserSetup userSetup;

  BMIScreen({super.key, required this.BMI,required this.userSetup,});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {

  void dietPlan(){
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
    dietPlan();
    return  Scaffold(
      body: Center(
        child: Text('BMI Calculator ${widget.BMI}'),
      ),
    );
  }
}
