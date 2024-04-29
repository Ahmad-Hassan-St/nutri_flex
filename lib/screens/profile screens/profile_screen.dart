import 'package:flutter/material.dart';
import '../../components/ListTileContainer.dart';
import '../account_setup/account_setup_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 28.0, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: screenSize.height * 0.07,
                    width: screenSize.height * 0.07,
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UserNameScreen()));
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
                  SizedBox(
                    width: screenSize.width*0.2,
                  ),
                  Text(
                    "Profile",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              CustomListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                  child: Image.asset("assets/images/profile.png"),
                ),
                trailing: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: ('Samantha Ruth'),
                subtitle: "samantha@123gmail.com",
                containerHeight: screenSize.height*0.14,
              ),
              SizedBox(
                height: screenSize.height*0.023,
              ),
              Row(
                children: [
                  Text(
                    "Quick Login",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height*0.023,
              ),
              CustomListTile(
                Containercolor: Colors.grey[200],
                padding: 15,
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: Image.asset("assets/images/bmi.png"),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: ('Bmi'),
                subtitle: "20",
                containerHeight: screenSize.height*0.116,
              ),
              SizedBox(
                height: screenSize.height*0.023,
              ),
              Row(
                children: [
                  Text(
                    "Your Information",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height*0.023,
              ),
              CustomListTile(
                Containercolor: Colors.grey[200],
                padding: 15,
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  child: Image.asset("assets/images/calender.png"),
                ),
                trailing: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: ('Age'),
                subtitle: "23",
                containerHeight: screenSize.height*0.116,
              ),
              SizedBox(
                height: screenSize.height*0.0144,
              ),
              CustomListTile(
                Containercolor: Colors.grey[200],
                padding: 15,
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  child: Image.asset("assets/images/weight.png"),
                ),
                trailing: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: ('Weight'),
                subtitle: "20 kg",
                containerHeight: screenSize.height*0.116,
              ),
              SizedBox(
                height: screenSize.height*0.0144,
              ),
              CustomListTile(
                Containercolor: Colors.grey[200],
                padding: 15,
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  child: Image.asset("assets/images/height.png"),
                ),
                trailing: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: ('Height'),
                subtitle: "120 cm",
                containerHeight: screenSize.height*0.116,
              ),
              SizedBox(
                height: screenSize.height*0.0144,
              ),
              CustomListTile(
                Containercolor: Colors.grey[200],
                padding: 15,
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  child: Image.asset("assets/images/gender.png"),
                ),
                trailing: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: ('Gender'),
                subtitle: "Female",
                containerHeight: screenSize.height*0.116,
              ),
              SizedBox(
                height: screenSize.height*0.023,
              )
            ],
          ),
        ),
      ),
    );
  }
}
