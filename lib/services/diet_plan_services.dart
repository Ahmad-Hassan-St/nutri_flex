import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

class DietPlanService {


  static const List balancedDietPlan = [
    "balanced diet plan 1.json",
    "balanced diet plan 2.json",
    "balanced diet plan 3.json",
  ];
  static const List weightGainDietPlan = [
    "weight gain plan1.json",
    "weight gain plan2.json",
    "weight gain plan3.json",
  ];
  static const List weightLossDietPlan = [
    "weight loss diet plan 1.json",
    "weight loss diet plan 2.json",
    "weight loss diet plan 3.json",
  ];

  static Future<Map<String, dynamic>> suggestDietPlan(String goal) async {
    // int index = Random().nextInt(3)
    int index = 1;
    print(index);
    List dietPlan = [];
    if (goal == "Lose weight") {
      dietPlan = weightLossDietPlan;
    } else if (goal == "Gain weight") {
      dietPlan = weightGainDietPlan;
    } else {
      dietPlan = balancedDietPlan;
    }

    final String response =
        await rootBundle.loadString("assets/diet_plan/${dietPlan[index]}");
    final result = await json.decode(response);
    // print(result['meal_plan']);
    return result;
  }
}
