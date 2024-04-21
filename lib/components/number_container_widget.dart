import 'package:flutter/material.dart';

import '../constants/colors.dart';

class NumberContainerWidget extends StatelessWidget {
  double? height;
  double? width;
  double dynamicPadding;
  Size screenSize;
  int text;
  Color? color;
  TextStyle? style;

  NumberContainerWidget({
    super.key,
    required this.screenSize,
    required this.text,
    required this.dynamicPadding,
    this.height = 140,
    this.width = 110,
    this.color = softGrey,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(screenSize.height * 0.04),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: dynamicPadding,
        ),
        child: Center(
          child: Text(
            text.toString(),
            style: style,
          ),
        ),
      ),
    );
  }
}