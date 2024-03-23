import 'package:flutter/material.dart';

class TopRow extends StatelessWidget {
  late String text;
  final VoidCallback onpressed;
  Color? textcolor;
  Color? backgroundcolor;

  TopRow(
      {super.key,
      required this.text,
      required this.onpressed,
      this.backgroundcolor,
      this.textcolor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset("assets/images/Logo2.png"),
        ElevatedButton(
          onPressed: onpressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundcolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(27.0),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 22.0, bottom: 22, left: 13, right: 13),
            child: Text(
              text,
              style: TextStyle(
                fontFamily: "Zen Kaku Gothic Antique",
                fontSize: 10,
                color: textcolor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
