import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add a user document
  Future<void> addUser(String userId) async {
    await _db.collection('users').doc(userId).set({});
  }

  // Add a diet document for a specific user and day
  Future<void> addDiet(String userId, String day, Map<String, List<String>> meals) async {
    await _db.collection('users')
        .doc(userId)
        .collection('diet')
        .doc(day)
        .set(meals);
  }

  // Retrieve diet for a specific user and day
  Future<QuerySnapshot<Object?>> getDiet(String userId, String day) async {
    // final data =  await _db.collection('users')
    //     .doc(userId)
    //     .collection('diet')
    //     .doc(day)
    //     .get();
    final data = await FirestoreService().getAllDiet("12345");
    data.docs.forEach((doc) {
      print('Diet data for ${doc.id}: ${doc.data()}');
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
    await addDiet(userId, day, meals);
  }
}
