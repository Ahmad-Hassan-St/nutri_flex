
import 'package:flutter/material.dart';

import 'nutrition_details.dart';

class NutritionItem extends StatelessWidget {
  final String title;
  final int calories;
  final int weight;
  final int protein;
  final int carbs;
  final int fat;

  NutritionItem({
    required this.title,
    required this.calories,
    required this.weight,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Card(
      color: const Color(0xffebf6d6),
      margin: EdgeInsets.all(width * 0.03),
      child: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: width * 0.09),
              child: const CircleAvatar(
                child: Icon(Icons.food_bank_outlined),
                radius: 25,
              ),
            ),
            SizedBox(width: width * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: width * 0.05,
                    ),
                  ),
                  SizedBox(height: width * 0.01),
                  Text(
                    "$calories kcal • $weight G",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.grey[700],
                      fontSize: width * 0.04,
                    ),
                  ),
                  SizedBox(height: width * 0.03),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NutritionDetail(
                            label: "Protein",
                            value: protein,
                            color: Colors.green),
                        NutritionDetail(
                            label: "Carbs", value: carbs, color: Colors.orange),
                        NutritionDetail(
                            label: "Fat", value: fat, color: Colors.purple),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}