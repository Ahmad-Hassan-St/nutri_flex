import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/diet_plan_tracking.dart';
import '../scanner/scanner_screen.dart';
import 'calories_details.dart';

List<CameraDescription> cameras = [];

class CalorieTracker extends StatefulWidget {
  @override
  _CalorieTrackerState createState() => _CalorieTrackerState();
}

class _CalorieTrackerState extends State<CalorieTracker> {
  List<FlSpot> breakfastSpots = [];
  List<FlSpot> lunchSpots = [];
  List<FlSpot> dinnerSpots = [];
  List<FlSpot> otherSpots = [];

  double totalBreakfastCalories = 0;
  double totalLunchCalories = 0;
  double totalDinnerCalories = 0;
  double totalOtherCalories = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  bool isData = false;

  void getData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? email = sp.getString("email");
    final data = await DietPlanTracking().getDiet("huzaifa@gmail.com", "day");
    Map<String, List<double>> mealData = {
      'breakfast': [],
      'lunch': [],
      'dinner': [],
      'other': []
    };
    cameras = await availableCameras();

    int dayCounter = 0;

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
          mealData['breakfast']?.add(mealTotal);
        } else if (mealType == 'Lunch') {
          mealData['lunch']?.add(mealTotal);
        } else if (mealType == 'Dinner') {
          mealData['dinner']?.add(mealTotal);
        } else if (mealType == 'Other') {
          mealData['other']?.add(mealTotal);
        }
      });
      dayCounter++;
    });

    // Find the maximum length among all lists in mealData
    int maxLength = mealData.values
        .map((list) => list.length)
        .reduce((a, b) => a > b ? a : b);

    // Pad the shorter lists with zeros up to the maximum length
    mealData.forEach((key, value) {
      if (value.length < maxLength) {
        int paddingCount = maxLength - value.length;
        mealData[key] = List.generate(paddingCount, (_) => 0.0)..addAll(value);
      }
    });

    setState(() {
      totalBreakfastCalories =
          mealData['breakfast']?.reduce((a, b) => a + b) ?? 0;
      totalLunchCalories = mealData['lunch']?.reduce((a, b) => a + b) ?? 0;
      totalDinnerCalories = mealData['dinner']?.reduce((a, b) => a + b) ?? 0;
      totalOtherCalories = mealData['other']?.reduce((a, b) => a + b) ?? 0;

      for (int i = 0; i < dayCounter; i++) {
        breakfastSpots
            .add(FlSpot(i.toDouble(), mealData['breakfast']?[i] ?? 0));
        lunchSpots.add(FlSpot(i.toDouble(), mealData['lunch']?[i] ?? 0));
        dinnerSpots.add(FlSpot(i.toDouble(), mealData['dinner']?[i] ?? 0));
        otherSpots.add(FlSpot(i.toDouble(), mealData['other']?[i] ?? 0));
      }
      isData = true;
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
                Padding(
                  padding: const EdgeInsets.only(top: 28.0, bottom: 20,left: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Calorie Tracking",
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 30
                  )
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        child: FloatingActionButton(
                          elevation: 0,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ScannerScreen(camera: cameras.first,)),
                            );

                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: SvgPicture.asset("assets/images/scanner.svg",),

                        ),
                      )
                    ],
                  ),
                ),
                isData ?
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
                        Container(
                          height: 52,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              '${(totalBreakfastCalories + totalLunchCalories + totalDinnerCalories + totalOtherCalories).toStringAsFixed(1)} kcal',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    fontSize: 23,
                                  ),
                            ),
                          ),
                        ),
                        Text(
                          '892 Avg cals - 2925 Goal Cals',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        AspectRatio(
                          aspectRatio: 1.6,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05),
                            child: LineChart(
                              LineChartData(
                                gridData: const FlGridData(show: true),
                                titlesData: const FlTitlesData(show: false),
                                borderData: FlBorderData(show: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: breakfastSpots,
                                    isCurved: true,
                                    color: const Color(0xff9DD030),
                                    barWidth: 2,
                                    isStrokeCapRound: true,
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color(0xff9DD030)
                                              .withOpacity(0.2),
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                  LineChartBarData(
                                    spots: lunchSpots,
                                    isCurved: true,
                                    color: const Color(0xff19B888),
                                    barWidth: 2,
                                    isStrokeCapRound: true,
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color(0xff19B888)
                                              .withOpacity(0.2),
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                  LineChartBarData(
                                    spots: dinnerSpots,
                                    isCurved: true,
                                    color: const Color(0xff39ACFF),
                                    barWidth: 2,
                                    isStrokeCapRound: true,
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color(0xff39ACFF)
                                              .withOpacity(0.2),
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                  LineChartBarData(
                                    spots: otherSpots,
                                    isCurved: true,
                                    color: const Color(0xff8439FF),
                                    barWidth: 2,
                                    isStrokeCapRound: true,
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color(0xff8439FF)
                                              .withOpacity(0.2),
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
                            legendItem(
                                color: const Color(0xff9DD030),
                                text: "Breakfast"),
                            legendItem(
                                color: const Color(0xff19B888), text: "Lunch"),
                            legendItem(
                                color: const Color(0xff39ACFF), text: "Dinner"),
                            legendItem(
                                color: const Color(0xff8439FF), text: "Other"),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                    : Padding(
                      padding:  EdgeInsets.only(top:screenHeight * 0.35),
                      child: Text("Add Meals for Tracking"),
                    ),

                isData ? Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Container(
                        height: screenHeight * 0.22,
                        decoration: BoxDecoration(
                          color: const Color(0xffF6F7F7),
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.05),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CalorieDetail(
                                    title: 'Breakfast',
                                    kcal: totalBreakfastCalories.toInt(),
                                    percentage: (totalBreakfastCalories /
                                            (totalBreakfastCalories +
                                                totalLunchCalories +
                                                totalDinnerCalories +
                                                totalOtherCalories) *
                                            100)
                                        .toInt(),
                                    color: const Color(0xff9DD030),
                                  ),
                                  CalorieDetail(
                                    title: 'Lunch',
                                    kcal: totalLunchCalories.toInt(),
                                    percentage: (totalLunchCalories /
                                            (totalBreakfastCalories +
                                                totalLunchCalories +
                                                totalDinnerCalories +
                                                totalOtherCalories) *
                                            100)
                                        .toInt(),
                                    color: const Color(0xff19B888),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CalorieDetail(
                                    title: 'Dinner',
                                    kcal: totalDinnerCalories.toInt(),
                                    percentage: (totalDinnerCalories /
                                            (totalBreakfastCalories +
                                                totalLunchCalories +
                                                totalDinnerCalories +
                                                totalOtherCalories) *
                                            100)
                                        .toInt(),
                                    color: const Color(0xff39ACFF),
                                  ),
                                  CalorieDetail(
                                    title: 'Other',
                                    kcal: totalOtherCalories.toInt(),
                                    percentage: (totalOtherCalories /
                                            (totalBreakfastCalories +
                                                totalLunchCalories +
                                                totalDinnerCalories +
                                                totalOtherCalories) *
                                            100)
                                        .toInt(),
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
                ) : Text(""),

              ],
            )
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
