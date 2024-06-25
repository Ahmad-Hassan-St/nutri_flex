import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget leading;
  final Widget ? trailing;
  final String title;
  final String subtitle;
  final double containerHeight;
  final double? padding;
  Color? Containercolor;
  VoidCallback? onTap;

  CustomListTile({
    Key? key,
    required this.containerHeight,
    required this.leading,
    this.trailing,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.padding = 25.0,
    this.Containercolor=const Color(0xffebf6d6),
    // Default padding value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      decoration: BoxDecoration(
        color: Containercolor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: padding!),
        child: ListTile(
          leading: leading,
          title: Text(
            title,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.bold
            ),
          ),
          subtitle: Text(
            subtitle,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          trailing: trailing,
          onTap: onTap,

        ),
      ),
    );
  }
}
