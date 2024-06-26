import 'package:flutter/material.dart';

class AppInformationWidget extends StatelessWidget {
  VoidCallback onTap;
  String text;
  IconData icon;
   AppInformationWidget({
    super.key,
    required this.text,
    required this.onTap,required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: screenSize.height * 0.016,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child:  ListTile(
        leading: Icon(icon),
        title:  Text(text),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.primary,
        ),
        onTap: onTap,
      ),
    );
  }
}
