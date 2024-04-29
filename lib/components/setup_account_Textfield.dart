import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetupAccount_TextfieldWidget extends StatelessWidget {
  late String? text;
  final IconData? icon;
  late double? Fontsize;
  final Color? containerColor;
  late double? HFontsize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final EdgeInsets contentPadding;
  final TextEditingController? controller;
  final int? age;

  bool readOnly;
  // Added parameter for contentPadding

  SetupAccount_TextfieldWidget({
    super.key,
    this.text,
    this.icon,
    this.age,
    this.HFontsize=13,
    this.Fontsize,
    this.fontWeight,
    this.controller,
    this.textAlign,
    this.containerColor,
    this.readOnly=false,
    EdgeInsets? contentPadding,  // Nullable parameter for contentPadding
  }) : contentPadding = contentPadding ?? const EdgeInsets.symmetric(horizontal: 26.0, vertical: 23.0);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: containerColor ?? Colors.grey[200], // Set your desired grey color
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        textAlign: textAlign ?? TextAlign.start,
        style:  Theme.of(context).textTheme.displayLarge,
        cursorColor: const Color(0xFF19b888),
        decoration: InputDecoration(
          hintText: age != null ? " $age" : text,
          hintStyle: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.black),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Icon(
              icon,
              color: const Color(0xFF19b888),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(25.0),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          contentPadding: contentPadding, // Use the provided contentPadding
          isDense: true,
        ),
      ),
    );
  }
}
