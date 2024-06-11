import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifefit/components/onBoardcontainer.dart';
import 'package:lifefit/screens/account_setup/gender_screen.dart';
import 'package:lifefit/utils/flutter_toast_message.dart';
import '../../components/setup_account_Textfield.dart';
import '../../models/user_setup_model.dart';
import 'height_screen.dart';

class DateBirthScreen extends StatefulWidget {
  final UserSetup userSetup;

  DateBirthScreen({Key? key, required this.userSetup}) : super(key: key);

  @override
  State<DateBirthScreen> createState() => _DateBirthScreenState();
}

class _DateBirthScreenState extends State<DateBirthScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  int? _age;

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
                            borderRadius:
                            BorderRadius.circular(screenSize.height * 0.06),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding:
                            EdgeInsets.only(left: screenSize.width * 0.025),
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
              SizedBox(
                height: 30,
              ),
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
                    "/9",
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
                readOnly: true,
                controller: _ageController,
                textAlign: TextAlign.center,
                containerColor: Color(0xffebf6d6),
                contentPadding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.045,
                  horizontal: screenWidth * 0.05,
                ),
                text: "Age",
                age: _age,
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
                      hintStyle: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.grey),
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
                progress: 0.44,
                onPressed: () {
                  print(_age);
                  if( _age == null){
                    ShowToastMsg("Please enter your Date of Birth");
                  }
                  else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HeightScreen(
                              userSetup: widget.userSetup,
                            ),
                      ),
                    );
                  }
                },
                icon: Icons.arrow_forward_ios,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return _DatePickerDialog();
      },
    );

    if (picked != null) {
      final selectedDate = picked;
      final currentDate = DateTime.now();
      final difference = currentDate.difference(selectedDate);
      final age = (difference.inDays / 365).floor();

      setState(() {
        _dateController.text = DateFormat('MMMM/dd/yyyy').format(selectedDate);
        _age = age;
        _ageController.text = age.toString();
        widget.userSetup.dateOfBirth = picked;
        widget.userSetup.age = age.toString();
      });
    }
  }
}

class _DatePickerDialog extends StatefulWidget {
  @override
  __DatePickerDialogState createState() => __DatePickerDialogState();
}

class __DatePickerDialogState extends State<_DatePickerDialog> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xffebf6d6),
      title: Text("Select Date"),
      content: Container(
        // Use a constrained container to ensure proper layout
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CalendarDatePicker(
                initialDate: _selectedDate,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                onDateChanged: (DateTime date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: Text(
            "Cancel",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedDate);
          },
          child: Text(
            "OK",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ],
    );
  }
}
