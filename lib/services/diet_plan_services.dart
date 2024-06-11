import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

class DietPlanService {

  static const List balancedDietPlan = [
    "BDP_1.json",
    "BDP_2.json",
    "BDP_3.json",
  ];
  static const List weightGainDietPlan = [
    "WGP_1.json",
    "WGP_2.json",
    "WGP_3.json",
  ];
  static const List weightLossDietPlan = [
    "WLP_1.json",
    "WLP_2.json",
    "WLP_3.json",

  ];

  static Future<Map<String, dynamic>> suggestDietPlan(String goal,int planNumber) async {
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

    final String response = await rootBundle.loadString("assets/diet_plan/${dietPlan[planNumber]}");
    final result = await json.decode(response);
    // print(result['meal_plan']);
    return result;
  }

}
