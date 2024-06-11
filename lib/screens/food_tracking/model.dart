import 'package:flutter/material.dart';

import 'food_tracking.dart';

class Checking extends StatefulWidget {
  const Checking({super.key});

  @override
  State<Checking> createState() => _CheckingState();
}

class _CheckingState extends State<Checking> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: 
        ElevatedButton(onPressed: ()async{
        //   Map<String, List<String>> meals = {
        //     'breakfast': ['eggs', 'toast'],
        //     'lunch': ['salad', 'chicken'],
        //     'dinner': ['pasta', 'vegetables'],
        //     'other': ['snack1', 'snack2']
        //   };
        //
        //  await FirestoreService().addUser("12ew3");
        //  await FirestoreService().addDiet("userId", "day", meals);
        //
         FirestoreService().exampleUsage();
       final data=  await FirestoreService().getDiet("12345", "day_1");
       // print(data);
         
      },    child: Text("data")),),
      
    );
  }
}
