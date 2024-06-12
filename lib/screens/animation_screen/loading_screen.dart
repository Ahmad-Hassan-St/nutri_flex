import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 5.0,
              percent: 1.0,
              animation: true,
              animationDuration: 4000, // Animation duration in milliseconds
              center: Icon(
                Icons.restaurant_menu,
                size: 50.0,
                color: Colors.green,
              ),
              backgroundColor: Colors.grey[200]!,
              progressColor: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              "Preparing your plan",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Setting up your nutrition plan and analyzing your goals...",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
