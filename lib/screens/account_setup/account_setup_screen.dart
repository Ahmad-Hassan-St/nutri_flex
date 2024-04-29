import 'package:flutter/material.dart';
import 'package:lifefit/components/TextFieldWidget.dart';
import 'package:lifefit/components/onBoardcontainer.dart';
import 'package:lifefit/components/setup_account_Textfield.dart';
import 'package:lifefit/models/user_setup_model.dart';
import 'package:lifefit/screens/account_setup/goal_screenn.dart';
import 'package:lifefit/screens/auth_screens/signup_screen.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({super.key});

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  TextEditingController _controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 150.0, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "1",
                    style: TextStyle(
                        fontFamily: "Zen Kaku Gothic Antique",
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "/8",
                    style: TextStyle(
                        fontFamily: "Zen Kaku Gothic Antique",
                        color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "What is your",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "name?",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "We will use this data to give you\n a better diet type for you",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(
                height: 130,
              ),
              SetupAccount_TextfieldWidget(
                controller: _controllerName,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 45, horizontal: 50),
                text: "Name",
              ),
              const SizedBox(
                height: 200,
              ),
              FloatingActionButtonProgressWidget(
                  progress: 0.125,
                  onpressed: () {
                    UserSetup user=UserSetup();
                    user.userName= _controllerName.text;
                    print(user.userName);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoalScreen(userSetup:user,

                        ),
                      ),
                    );
                  },
                  icon: Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}
