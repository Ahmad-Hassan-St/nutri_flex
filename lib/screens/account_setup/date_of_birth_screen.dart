import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifefit/components/onBoardcontainer.dart';
import 'package:lifefit/screens/account_setup/gender_screen.dart';
import 'package:lifefit/screens/auth_screens/signup_screen.dart';

import '../../components/setup_account_Textfield.dart';
import '../goal_screen.dart'; // Import the intl package

class DateBirthScreen extends StatefulWidget {
  const DateBirthScreen({Key? key});

  @override
  State<DateBirthScreen> createState() => _DateBirthScreenState();
}

class _DateBirthScreenState extends State<DateBirthScreen> {
  late TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.03,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenSize.width * 0.02),
                child: Row(
                  children: [
                    Container(
                      height: screenSize.height * 0.09,
                      width: screenSize.height * 0.09,
                      child: FittedBox(
                        child: FloatingActionButton(
                          heroTag: null,
                          elevation: 0,
                          backgroundColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenSize.height * 0.06),
                          ),
                          onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GenderScreen()));},
                          child: Padding(
                            padding: EdgeInsets.only(left: screenSize.width * 0.025),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Theme.of(context).colorScheme.background,
                              size: screenSize.height * 0.025,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "4",
                    style: TextStyle(
                      fontFamily: "Zen Kaku Gothic Antique",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "/8",
                    style: TextStyle(
                      fontFamily: "Zen Kaku Gothic Antique",
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    "Date of birth?",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.007),
              Text(
                "We will use this data to give you\n a better diet type for you",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: screenHeight * 0.15),
              SetupAccount_TextfieldWidget(
                textAlign: TextAlign.center,
                containerColor: Color((0xffebf6d6)),
                contentPadding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.045,
                  horizontal: screenWidth * 0.05,
                ),
                text: "Name",
              ),
              SizedBox(height: screenHeight * 0.02),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    style: Theme.of(context).textTheme.displayMedium,
                    controller: _dateController,
                    decoration: InputDecoration(
                      hintText: 'February/09/2023',
                      suffixIcon: Icon(
                        Icons.date_range_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.1),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.only(
                        left: screenWidth * 0.09,
                        top: screenHeight * 0.022,
                        bottom: screenHeight * 0.022,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.16),
              FloatingActionButtonProgressWidget(
                progress: 1,
                onpressed: () {},
                icon: Icons.arrow_forward_ios,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('MMMM/dd/yyyy').format(picked);
      });
    }
  }
}
