import 'package:flutter/material.dart';

class NutritionDetail extends StatelessWidget {
  final String label;
  final int value;
  final Color? color;

  NutritionDetail({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          "$value g",
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
            fontSize: width * 0.04,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: width * 0.03,
          ),
        ),
      ],
    );
  }
}
