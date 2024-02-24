import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  late String text;
  final IconData icon;
  TextfieldWidget({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.grey[200], // Set your desired grey color
      ),
      child: TextField(
        style: const TextStyle(
          fontFamily: "Zen Kaku Gothic Antique",
        ),
        cursorColor: const Color(0xFF19b888),
        decoration: InputDecoration(
          hintText: (text),
          hintStyle: const TextStyle(
              fontFamily: "Zen Kaku Gothic Antique",
              color: Colors.grey,
              fontSize: 13),
          suffixIcon:  Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Icon(
              icon,
              color: const Color(0xFF19b888),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(30.0),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 26.0, vertical: 23.0),
        ),
      ),
    );
  }
}
