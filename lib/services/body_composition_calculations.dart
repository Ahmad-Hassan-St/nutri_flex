class BodyCompositionCalculation {
  static double muscleMass(
      {required double totalBodyWeight, required double fatMass}) {
    return totalBodyWeight - fatMass;
  }

  static double fatMass(
      {required double totalBodyWeight, required double bodyFatPercentage}) {
    return totalBodyWeight * bodyFatPercentage;
  }

  static double bodyFatPercentage(
      {required double bicepSize, required double height}) {
    //Yuhasz equation.
    return (((0.31457 * bicepSize) - 3.125) / height) * 100;
  }

  static double calories(
      {required double weight,
      required double height,
      required String gender,
      required int age}) {
//Harris-Benedict equation,
    if (gender == "Male") {
      double maleCalories =
          88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
      return maleCalories;
    } else {
      double femaleCalories =
          447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
      return femaleCalories;
    }
  }

  //
  // static double bodyWaterPercentage({required double leanMass, required double bodyWeight}){
  //
  //   return (leanMass/bodyWeight)*100;
  // }

  static double leanMass(
      {required double bodyWeight, required double bodyFatPercentage}) {
    return bodyWeight * (1 - bodyFatPercentage);
  }

  // Calculates total body water (TBW) using Dr. P.E. Watson's formula and returns it as a percentage of body weight
  static double totalBodyWaterPercentage(
      {required double weight,
      required double height,
      required String gender,
      required int age}) {
    double tbw;
    if (gender == "Male") {
      tbw = 2.447 - (0.09516 * age) + (0.1074 * height) + (0.3362 * weight);
    } else {
      tbw = -2.097 + (0.1069 * height) + (0.2466 * weight);
    }
    return (tbw / weight) * 100;
  }

 static double bodyResultScroe(

      {required double boydFatPercentage,
      required double waterPercentage,
      required double questionScore,
      required double bmi}) {

      int bmiScore = 0;

      if (bmi > 30) {
        bmiScore = 0;
      } else if (bmi >= 29 && bmi <= 30) {
        bmiScore = 1;
      } else if (bmi >= 27 && bmi < 29) {
        bmiScore = 2;
      } else if (bmi >= 25 && bmi < 27) {
        bmiScore = 3;
      } else if (bmi >= 22 && bmi < 25) {
        bmiScore = 6;
      } else if (bmi >= 20 && bmi < 22) {
        bmiScore = 5;
      } else if (bmi >= 18.5 && bmi < 20) {
        bmiScore = 4;
      } else if (bmi >= 17 && bmi < 18.5) {
        bmiScore = 7;
      } else if (bmi >= 16 && bmi < 17) {
        bmiScore = 8;
      } else if (bmi < 16) {
        bmiScore = 9+2;
      }


     double score = (boydFatPercentage + (waterPercentage / 10) + bmiScore)  / 3;
     score = score - questionScore;
    return score;
  }
}
