import 'package:cloud_firestore/cloud_firestore.dart';

class DietPlanTracking {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add a user document
  Future<void> addUser(String email) async {
    await _db.collection('users').doc(email).set({});
  }

  Future<void> addDiet(String email, String day, Map<String, Map<String, dynamic>> newMeals) async {
    final docRef = _db.collection('users').doc(email).collection('diet').doc(day);

    await _db.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(docRef);

      if (snapshot.exists) {
        Map<String, dynamic> existingMeals = snapshot.data() as Map<String, dynamic>;

        // Append new meals to existing ones
        newMeals.forEach((mealType, mealData) {
          if (existingMeals.containsKey(mealType)) {
            // Check if existingMeals[mealType] is a list
            if (existingMeals[mealType] is List) {
              // Append the new meal data as a new map to the list
              (existingMeals[mealType] as List).add(mealData);
            } else {
              // Convert to list and then append the new meal data
              existingMeals[mealType] = [existingMeals[mealType], mealData];
            }
          } else {
            // Create a new list with the new meal data
            existingMeals[mealType] = [mealData];
          }
        });

        transaction.update(docRef, existingMeals);
      } else {
        // If the document does not exist, create it
        Map<String, dynamic> initialMeals = {};
        newMeals.forEach((mealType, mealData) {
          initialMeals[mealType] = [mealData];
        });
        transaction.set(docRef, initialMeals);
      }
    });
  }


  // Retrieve diet for a specific user and day
  Future<QuerySnapshot<Object?>> getDiet(String userId, String day) async {

    final data = await DietPlanTracking().getAllDiet("ahmad@gmail.com");
    data.docs.forEach((doc) {
      // print('Diet data for ${doc.id}: ${doc.data()}');
    });

    return data;
  }

  Future<QuerySnapshot> getAllDiet(String userId) async {
    final data = await _db.collection('users')
        .doc(userId)
        .collection('diet')
        .get();
    return data;
  }

  // Example: Adding a diet for user with userId on day_1
  Future<void> exampleUsage() async {
    String userId = '12345';
    String day = 'day_4';
    Map<String, List<String>> meals = {
      'breakfast': ['eggs', 'toast'],
      'lunch': ['salad', 'chicken'],
      'dinner': ['pasta', 'vegetables'],
      'other': ['snack1', 'snack2']
    };

    await addUser(userId);
    // await addDiet(userId, day, meals);
  }
}
