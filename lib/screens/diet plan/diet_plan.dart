import 'package:flutter/material.dart';

class BMIScreen extends StatelessWidget {
  String BMI;
   BMIScreen({super.key, required this.BMI});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text('BMI Calculator $BMI'),
      ),
    );
  }
}
