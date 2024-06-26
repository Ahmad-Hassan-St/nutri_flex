import 'package:flutter/material.dart';
import 'package:lifefit/constants/colors.dart';
import 'package:lifefit/models/user_setup_model.dart';
import 'package:lifefit/screens/account_setup/goal_screenn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../chat_module/api/apis.dart';
import '../../components/ListTileContainer.dart';
import '../../services/auth_services.dart';
import '../../services/dml_services.dart';
import '../account_setup/account_setup_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userEmail = "";

  List<Map<String, dynamic>> bodyComposition = [];

  Future<List<Map<String, dynamic>>> fetchUserData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? email = sp.getString('email');
    userEmail = email ?? "";
    List<Map<String, dynamic>> fetchedData =
        await DmlServices().fetchDataUserDetails(userEmail);

    bodyComposition =
        await DmlServices().fetchDataUserBodyComposition(userEmail);
    print(bodyComposition);

    return fetchedData;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available.'));
          } else {
            List<Map<String, dynamic>> dataList = snapshot.data!;
            print(dataList[0]);
            UserSetup userSetup = UserSetup();
            userSetup.BMI=dataList[0]["BMI"];
            userSetup.height=dataList[0]["height"];
            userSetup.weight=dataList[0]["weight"];
            userSetup.age=dataList[0]["age"];
            userSetup.gender=dataList[0]["gender"];
            userSetup.email=dataList[0]["email"];
            userSetup.goal = dataList[0]["goal"];
            userSetup.bicepSize = dataList[0]["bicepSize"];
            userSetup.targetWeight=dataList[0]["targetWeight"];
            userSetup.userName = dataList[0]["userName"];
            userSetup.isUpdate=true;



            double bmi = double.parse( dataList[0]["BMI"]);
            String  bmiCategory ="";

            if (bmi < 18.5) {
              bmiCategory = "Underweight";
            } else if (bmi >= 18.5 && bmi < 25) {
              bmiCategory = "Normal Weight";
            } else if (bmi >= 25 && bmi < 30) {
              bmiCategory = "Overweight";
            } else if (bmi >= 30) {
              bmiCategory = "Obesity";
            }
            return Padding(
              padding: const EdgeInsets.only(top: 28.0, left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: screenSize.width * 0.35,
                        ),
                        Text(
                          "Profile",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(
                          width: screenSize.width * 0.2,
                        ),
                        Container(
                          height: screenSize.height * 0.07,
                          width: screenSize.height * 0.07,
                          child: FittedBox(
                            child: FloatingActionButton(
                              heroTag: null,
                              elevation: 0,
                              backgroundColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    screenSize.height * 0.06),
                              ),
                              onPressed: () {
                                _showLogoutDialog(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: screenSize.width * 0.025),
                                child: Icon(
                                  Icons.logout,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  size: screenSize.height * 0.025,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        // Set background color to transparent
                        child: ClipOval(
                          child: Image.network(
                            APIs.me.image.toString(),
                            fit: BoxFit.cover,
                            width: 60.0,
                            height: 60.0,
                          ),
                        ),
                      ),

                      title: ('${dataList[0]["userName"]}'),
                      subtitle: dataList[0]["email"],
                      containerHeight: screenSize.height * 0.14,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.023,
                    ),
                    Row(
                      children: [
                        Text(
                          "$bmiCategory",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.023,
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
                      subtitle: dataList[0]["BMI"],
                      containerHeight: screenSize.height * 0.116,
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>GoalScreen(userSetup: userSetup)
                          ),
                        );
                      },

                    ),
                    SizedBox(
                      height: screenSize.height * 0.023,
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
                      height: screenSize.height * 0.023,
                    ),
                    CustomListTile(
                      Containercolor: Colors.grey[200],
                      padding: 15,
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Image.asset("assets/images/calender.png"),
                      ),

                      title: ('Age'),
                      subtitle: dataList[0]["age"],
                      containerHeight: screenSize.height * 0.116,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.0144,
                    ),
                    CustomListTile(
                      Containercolor: Colors.grey[200],
                      padding: 15,
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Image.asset("assets/images/weight.png"),
                      ),

                      title: ('Weight'),
                      subtitle: "${dataList[0]["weight"]} kg",
                      containerHeight: screenSize.height * 0.116,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.0144,
                    ),
                    CustomListTile(
                      Containercolor: Colors.grey[200],
                      padding: 15,
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Image.asset("assets/images/height.png"),
                      ),
                       
                      title: ('Height'),
                      subtitle: "${dataList[0]["height"]} cm",
                      containerHeight: screenSize.height * 0.116,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.0144,
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
                      subtitle: dataList[0]["gender"],
                      containerHeight: screenSize.height * 0.116,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.023,
                    ),
                    Row(
                      children: [
                        Text(
                          "Body Information",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.023,
                    ),
                    CustomListTile(
                      Containercolor: Colors.grey[200],
                      padding: 15,
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Image.asset("assets/images/bicep.png"),
                      ),
                       
                      title: ('Bicep Circumference'),
                      subtitle: bodyComposition.isNotEmpty
                          ? "${dataList[0]["bicepSize"]} cm"
                          : 'N/A',
                      containerHeight: screenSize.height * 0.116,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.0144,
                    ),
                    CustomListTile(
                      Containercolor: Colors.grey[200],
                      padding: 15,
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Image.asset("assets/images/lean.png"),
                      ),

                      title: ('Lean Mass'),
                      subtitle: bodyComposition.isNotEmpty
                          ? "${bodyComposition[0]["leanMass"].toStringAsFixed(2)}"
                          : 'N/A',
                      containerHeight: screenSize.height * 0.116,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.0144,
                    ),
                    CustomListTile(
                      Containercolor: Colors.grey[200],
                      padding: 15,
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Image.asset("assets/images/fat.png"),
                      ),

                      title: ('Fat Mass'),
                      subtitle: bodyComposition.isNotEmpty
                          ? "${bodyComposition[0]["fatMass"].toStringAsFixed(2)}"
                          : 'N/A',
                      containerHeight: screenSize.height * 0.116,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.0144,
                    ),
                    CustomListTile(
                      Containercolor: Colors.grey[200],
                      padding: 15,
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Image.asset("assets/images/calories.png"),
                      ),

                      title: ('Calories'),
                      subtitle: bodyComposition.isNotEmpty
                          ? "${bodyComposition[0]["calories"].toStringAsFixed(2)} kcal"
                          : 'N/A',
                      containerHeight: screenSize.height * 0.116,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.0144,
                    ),
                    CustomListTile(
                      Containercolor: Colors.grey[200],
                      padding: 15,
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Image.asset("assets/images/bodyWater.png"),
                      ),

                      title: ('Body Water Percentage'),
                      subtitle: bodyComposition.isNotEmpty
                          ? "${bodyComposition[0]["water%"].toStringAsFixed(2)}%"
                          : 'N/A',
                      containerHeight: screenSize.height * 0.116,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.0144,
                    ),
                    CustomListTile(
                      Containercolor: Colors.grey[200],
                      padding: 15,
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Image.asset("assets/images/fatPercentage.png"),
                      ),

                      title: ('Body Fat Percentage'),
                      subtitle: bodyComposition.isNotEmpty
                          ? "${bodyComposition[0]["fatMass%"].toStringAsFixed(2)}%"
                          : 'N/A',
                      containerHeight: screenSize.height * 0.116,
                    ),
                    SizedBox(
                      height: screenSize.height * 0.0144,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffebf6d6),
          title: Text("Confirm Logout"),
          content: Text("Do you want to log out?"),
          actions: <Widget>[
            TextButton(
              child: Text(
                "No",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.normal),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Yes",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                AuthServices().handleLogout(context);
              },
            ),
          ],
        );
      },
    );
  }
}
