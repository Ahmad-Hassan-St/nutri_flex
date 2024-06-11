import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../services/diet_plan_tracking.dart';

class CalorieTracker extends StatefulWidget {
  @override
  _CalorieTrackerState createState() => _CalorieTrackerState();
}

class _CalorieTrackerState extends State<CalorieTracker> {
  double breakfastData = 0;
  double lunchData = 0;
  double dinnerData = 0;
  double otherData = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final data = await DietPlanTracking().getDiet("ahmad@gmail.com", "day");
    Map<String, double> totalCalories = {
      'breakfast': 0,
      'lunch': 0,
      'dinner': 0,
      'other': 0
    };

    data.docs.forEach((doc) {
      final dietData = doc.data() as Map<String, dynamic>;
      dietData.forEach((mealType, meals) {
        double mealTotal = 0;
        if (meals is List) {
          meals.forEach((meal) {
            mealTotal += meal['kcal'];
          });
        } else if (meals is Map) {
          mealTotal += meals['kcal'];
        }

        if (mealType == 'Break Fast') {
          totalCalories['breakfast'] = (totalCalories['breakfast'] ?? 0) + mealTotal;
        } else if (mealType == 'Lunch') {
          totalCalories['lunch'] = (totalCalories['lunch'] ?? 0) + mealTotal;
        } else if (mealType == 'Dinner') {
          totalCalories['dinner'] = (totalCalories['dinner'] ?? 0) + mealTotal;
        } else if (mealType == 'Other') {
          totalCalories['other'] = (totalCalories['other'] ?? 0) + mealTotal;
        }
      });
    });

    setState(() {
      breakfastData = totalCalories['breakfast'] ?? 0;
      lunchData = totalCalories['lunch'] ?? 0;
      dinnerData = totalCalories['dinner'] ?? 0;
      otherData = totalCalories['other'] ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Text(
                "Calorie Tracking",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Container(
              height: screenHeight * 0.47,
              decoration: BoxDecoration(
                color: const Color(0xffebf6d6),
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    '${breakfastData + lunchData + dinnerData + otherData} kcal',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    '892 Avg cals - 2925 Goal Cals',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  AspectRatio(
                    aspectRatio: 1.6,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: true),
                          titlesData: const FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                FlSpot(0, breakfastData),
                                FlSpot(1, lunchData),
                                FlSpot(2, dinnerData),
                                FlSpot(3, otherData),
                              ],
                              isCurved: true,
                              color: const Color(0xff9DD030),
                              barWidth: 2,
                              isStrokeCapRound: true,
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xff9DD030).withOpacity(0.2),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      legendItem(color: const Color(0xff9DD030), text: "Breakfast"),
                      legendItem(color: const Color(0xff19B888), text: "Lunch"),
                      legendItem(color: const Color(0xff39ACFF), text: "Dinner"),
                      legendItem(color: const Color(0xff8439FF), text: "Snacks"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Container(
                  height: screenHeight * 0.22,
                  decoration: BoxDecoration(
                    color: const Color(0xffF6F7F7),
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.02),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CalorieDetail(
                              title: 'Breakfast',
                              kcal: breakfastData.toInt(),
                              percentage: ((breakfastData / (breakfastData + lunchData + dinnerData + otherData)) * 100).toInt(),
                              color: const Color(0xff9DD030),
                            ),
                            CalorieDetail(
                              title: 'Lunch',
                              kcal: lunchData.toInt(),
                              percentage: ((lunchData / (breakfastData + lunchData + dinnerData + otherData)) * 100).toInt(),
                              color: const Color(0xff19B888),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CalorieDetail(
                              title: 'Dinner',
                              kcal: dinnerData.toInt(),
                              percentage: ((dinnerData / (breakfastData + lunchData + dinnerData + otherData)) * 100).toInt(),
                              color: const Color(0xff39ACFF),
                            ),
                            CalorieDetail(
                              title: 'Other',
                              kcal: otherData.toInt(),
                              percentage: ((otherData / (breakfastData + lunchData + dinnerData + otherData)) * 100).toInt(),
                              color: const Color(0xff8439FF),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget legendItem({required Color color, required String text}) {
    return Row(
      children: [
        Icon(
          Icons.circle_rounded,
          color: color,
          size: 10,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(width: 11),
      ],
    );
  }
}

class CalorieDetail extends StatelessWidget {
  final String title;
  final int kcal;
  final int percentage;
  final Color color;

  CalorieDetail({
    required this.title,
    required this.kcal,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.05),
                child: Text(
                  '$kcal kcal',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(width: screenWidth * 0.09),
              Text(
                '$percentage%',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 18,
                    color: color
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.01),
          Stack(
            children: [
              Container(
                width: screenWidth * 0.3,
                height: 5,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Container(
                width: screenWidth * 0.3 * (percentage / 100),
                height: 5,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
