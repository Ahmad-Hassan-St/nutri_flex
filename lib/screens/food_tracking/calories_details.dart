
import 'package:flutter/material.dart';

class CalorieDetail extends StatelessWidget {
  final String unit;
  final String title;
  final int kcal;
  final int percentage;
  final Color color;

  CalorieDetail({
    required this.title,
    required this.kcal,
    required this.percentage,
    required this.color,
    required this.unit,
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
                  '$kcal $unit',
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
