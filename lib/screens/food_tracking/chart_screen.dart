import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CalorieTracker extends StatefulWidget {
  @override
  _CalorieTrackerState createState() => _CalorieTrackerState();
}

class _CalorieTrackerState extends State<CalorieTracker> {
  List<FlSpot> breakfastData = [
    const FlSpot(0, 0),
    const FlSpot(1, 1500),
    const FlSpot(2, 1572),
    const FlSpot(3, 1433)
  ];
  List<FlSpot> lunchData = [
    const FlSpot(0, 0),
    const FlSpot(1, 3000),
    const FlSpot(2, 4987),
    const FlSpot(3, 1000)
  ];
  List<FlSpot> dinnerData = [
    const FlSpot(0, 0),
    const FlSpot(1, 2000),
    const FlSpot(2, 2091),
    const FlSpot(3, 1632)
  ];
  List<FlSpot> otherData = [
    const FlSpot(0, 0),
    const FlSpot(1, 1800),
    const FlSpot(2, 1932),
    const FlSpot(3, 1144)
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(child: Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Text("Calorie Tracking",style: Theme.of(context).textTheme.displayLarge,),
          )),
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
                  const Text(
                    '10582 kcal',
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
                              spots: breakfastData,
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
                            LineChartBarData(
                              spots: lunchData,
                              isCurved: true,
                              color: const Color(0xff19B888),
                              barWidth: 4,
                              isStrokeCapRound: true,
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xff19B888).withOpacity(0.2),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            LineChartBarData(
                              spots: dinnerData,
                              isCurved: true,
                              color: const Color(0xff39ACFF),
                              barWidth: 4,
                              isStrokeCapRound: true,
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xff39ACFF).withOpacity(0.2),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            LineChartBarData(
                              spots: otherData,
                              isCurved: true,
                              color: const Color(0xff8439FF),
                              barWidth: 4,
                              isStrokeCapRound: true,
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xff8439FF).withOpacity(0.2),
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
                    padding:  EdgeInsets.only(top: screenHeight * 0.02),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CalorieDetail(
                              title: 'Breakfast',
                              kcal: 1572,
                              percentage: 14,
                              color: const Color(0xff9DD030),
                            ),
                            CalorieDetail(
                              title: 'Lunch',
                              kcal: 4987,
                              percentage: 48,
                              color: const Color(0xff19B888),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CalorieDetail(
                              title: 'Dinner',
                              kcal: 2091,
                              percentage: 20,
                              color: const Color(0xff39ACFF),
                            ),
                            CalorieDetail(
                              title: 'Other',
                              kcal: 1932,
                              percentage: 18,
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
                  ) ),
              ),
            ],
          ),
          Row(

            children: [
              Text(
                title,
                style:Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold
                )
              ),
              SizedBox(width: screenWidth * 0.09),
              Text(
                '$percentage%',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 18,
                  color: color
                )
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
