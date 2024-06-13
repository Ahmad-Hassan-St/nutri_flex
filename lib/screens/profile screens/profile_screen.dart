import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/ListTileContainer.dart';
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
            return Padding(
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
                                borderRadius: BorderRadius.circular(
                                    screenSize.height * 0.06),
                              ),
                              onPressed: () {
                                
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: screenSize.width * 0.025),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color:
                                  Theme.of(context).colorScheme.background,
                                  size: screenSize.height * 0.025,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.2,
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
                          "Quick Login",
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
                      trailing: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
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
                      trailing: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
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
                      trailing: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
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
                      trailing: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: ('Bicep Circumference'),
                      subtitle: bodyComposition.isNotEmpty ? "${dataList[0]["bicepSize"]} cm" : 'N/A',
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
                      trailing: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: ('Lean Mass'),
                      subtitle: bodyComposition.isNotEmpty ? "${bodyComposition[0]["leanMass"].toStringAsFixed(2)} kg" : 'N/A',
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
                      trailing: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: ('Fat Mass'),
                      subtitle: bodyComposition.isNotEmpty ? "${bodyComposition[0]["fatMass"].toStringAsFixed(2)} kg" : 'N/A',
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
                      trailing: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: ('Calories'),
                      subtitle: bodyComposition.isNotEmpty ? "${bodyComposition[0]["calories"].toStringAsFixed(2)} kcal" : 'N/A',
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
                      trailing: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: ('Body Water Percentage'),
                      subtitle: bodyComposition.isNotEmpty ? "${bodyComposition[0]["water%"].toStringAsFixed(2)}%" : 'N/A',
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
                      trailing: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: ('Body Fat Percentage'),
                      subtitle: bodyComposition.isNotEmpty ? "${bodyComposition[0]["fatMass%"].toStringAsFixed(2)}%" : 'N/A',
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
}
