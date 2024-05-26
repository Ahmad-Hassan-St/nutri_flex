import 'package:flutter/material.dart';
import '../../components/nutrition_item.dart';
import '../../services/diet_plan_services.dart';

class ShowDietScreen extends StatefulWidget {
  @override
  _ShowDietScreenState createState() => _ShowDietScreenState();
}

class _ShowDietScreenState extends State<ShowDietScreen> {
  final List<String> dates = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  final List<String> mealTypes = ["Breakfast", "Lunch", "Dinner","Snack"];
  String selectedDate = "Tuesday";
  String selectedMealType = "Breakfast";

  Future<Map<String, dynamic>> fetchDietPlan() async {
    return await DietPlanService.suggestDietPlan("Gain weight");
  }

  List<Map<String, dynamic>> getMealItems(Map<String, dynamic> data) {
    String dayKey = "day_${dates.indexOf(selectedDate) + 1}".toLowerCase();
    String mealKey = selectedMealType.toLowerCase();

    if (data["meal_plan"].containsKey(dayKey) && data["meal_plan"][dayKey].containsKey(mealKey)) {
      return List<Map<String, dynamic>>.from(data["meal_plan"][dayKey][mealKey]['items']);
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchDietPlan(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            var data = snapshot.data!;
            var mealItems = getMealItems(data);

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 0.03, left: width * 0.05),
                  child: Row(
                    children: [
                      Text(
                        "Daily \nNutritions",
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: width * 0.1,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Container(
                  color: Colors.white,
                  height: height * 0.1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dates.length,
                    itemBuilder: (context, index) {
                      final date = dates[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                        child: Container(
                          height: height * 0.5,
                          width: width * 0.34,
                          margin: EdgeInsets.symmetric(horizontal: width * 0.012),
                          padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.05),
                          decoration: BoxDecoration(
                            color: selectedDate == date ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              style: TextStyle(
                                color: selectedDate == date ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.04,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(1, 1),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: mealTypes.map((type) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedMealType = type;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: height * 0.014, horizontal: width * 0.038),
                            decoration: BoxDecoration(
                              color: selectedMealType == type ? Theme.of(context).colorScheme.primary : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              type,
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: selectedMealType == type ? Colors.white : Theme.of(context).colorScheme.background,
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.042,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Expanded(
                  child: ListView.builder(
                    itemCount: mealItems.length,
                    itemBuilder: (context, index) {
                      var item = mealItems[index];

                      return NutritionItem(
                        title: item['name'],
                        calories: item['calories'],
                        weight: item['weight'],
                        protein: item['protein'],
                        carbs: item['carbs'],
                        fat: item['fat'],
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
