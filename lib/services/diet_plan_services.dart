import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

class DietPlanService {

static double muscleMass({required int totalBodyWeight,required double fatMass}){
  return totalBodyWeight - fatMass;
}

static double fatMass({required double totalBodyWeight,required double bodyFatPercentage}){
  return totalBodyWeight * bodyFatPercentage;
}

static double bodyFatPercentage({required double bicepSize,required double height}){
  //Yuhasz equation.
  return ((0.31457 * bicepSize -3.125)/height)*100;
}

static double calories({required double weight,required double height, required String gender,required int age}){
//Harris-Benedict equation,
  if (gender == "Male"){
    double maleCalories = 88.362 +(13.397 * weight ) + (4.799 * height) - (5.677 * age);
    return maleCalories;
  }
  else{
    double femaleCalories = 447.593 +(9.247 * weight ) + (3.098 * height) - (4.330 * age);
    return femaleCalories;
  }
}


static double bodyWaterPercentage({required double leanMass, required double bodyWeight}){

  return (leanMass/bodyWeight)*100;
}

static double leanMass({required double bodyWeight,required double bodyFatPercentage}){
  return bodyWeight * (1- bodyFatPercentage);
}

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
    int index = Random().nextInt(3);
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
    print(result['meal_plan']);
    return result['meal_plan'];
  }
}
