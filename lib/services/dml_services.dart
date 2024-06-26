import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifefit/models/body_composition.dart';
import 'package:lifefit/models/user_setup_model.dart';

import '../utils/flutter_toast_message.dart';

class DmlServices {
  static final _fireStore = FirebaseFirestore.instance;

  static insertUserData({
    required UserSetup userSetup,
  }) async {
    try {
      DocumentReference documentReference =
          _fireStore.collection('userDetails').doc();
      await documentReference.set({
        'email': userSetup.email,
        "userName": userSetup.userName,
        "goal": userSetup.goal,
        "weight": userSetup.weight,
        "height": userSetup.height,
        "gender": userSetup.gender,
        "targetWeight": userSetup.targetWeight,
        "dateOfBirth": userSetup.dateOfBirth,
        "age": userSetup.age ?? " years",
        "BMI": userSetup.BMI,
        "bicepSize": userSetup.bicepSize,

      });
      return;
    } on FirebaseException catch (e) {
      print("Error ${e.toString()}");
    }
  }  static insertUserBodyCompositionData({
    required BodyComposition bodyComposition,
    required UserSetup userSetup,
    required int dietPlan,

  }) async {
    try {
      DocumentReference documentReference =
      _fireStore.collection('bodyComposition').doc();
      await documentReference.set({
        'email': userSetup.email,
        "muscleMass": bodyComposition.muscleMass,
        "leanMass": bodyComposition.leanMass,
        "fatMass": bodyComposition.fatMass,
        "fatMass%": bodyComposition.bodyFatPercentage,
        "water%": bodyComposition.bodyWaterPercentage,
        "calories": bodyComposition.calories,
        "questionnaireScore": bodyComposition.questionnaireScore,
        "dietPlan": 1,
      });
      return;
    } on FirebaseException catch (e) {
      print("Error ${e.toString()}");
    }
  }




  Future<void> updateUserImageByEmail(
      {required String email, required String imageUrl}) async {
    CollectionReference usersCollection = _fireStore.collection('users');

    try {
      QuerySnapshot querySnapshot =
          await usersCollection.where("email", isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference userDocument = querySnapshot.docs.first.reference;

        await userDocument.update({"image": imageUrl});
      } else {
        print("User with email $email not found.");
      }
    } catch (e) {
      print("Error updating user image: $e");
    }
  }


  Future<List<Map<String, dynamic>>> fetchDataUserBodyComposition(String? email) async {
    CollectionReference ridesCollection = _fireStore.collection('bodyComposition');
    try {
      QuerySnapshot querySnapshot =
      await ridesCollection.where("email", isEqualTo: email).get();

      List<Map<String, dynamic>> dataList = [];

      querySnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> documentData =
        document.data() as Map<String, dynamic>;
        documentData['documentId'] =
            document.id; // Add the document ID to the map
        dataList.add(documentData);
      });

      return dataList;
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }
  Future<List<Map<String, dynamic>>> fetchDataUserDetails(String? email) async {
    CollectionReference ridesCollection = _fireStore.collection('userDetails');
    try {
      QuerySnapshot querySnapshot =
          await ridesCollection.where("email", isEqualTo: email).get();

      List<Map<String, dynamic>> dataList = [];

      querySnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> documentData =
            document.data() as Map<String, dynamic>;
        documentData['documentId'] =
            document.id; // Add the document ID to the map
        dataList.add(documentData);
      });

      return dataList;
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }

  Future<void> updateUsersData({
    required UserSetup userSetup,
  }) async {
    CollectionReference usersCollection = _fireStore.collection('userDetails');

    try {
      QuerySnapshot querySnapshot =
          await usersCollection.where("email", isEqualTo: userSetup.email).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference userDocument = querySnapshot.docs.first.reference;

        await userDocument.update({
          "userName": userSetup.userName,
          "goal": userSetup.goal,
          "weight": userSetup.weight,
          "height": userSetup.height,
          "gender": userSetup.gender,
          "targetWeight": userSetup.targetWeight,
          "dateOfBirth": userSetup.dateOfBirth,
          "age": userSetup.age ?? " years",
          "BMI": userSetup.BMI,
          "bicepSize": userSetup.bicepSize,

        });
      } else {
        print("User with email ${userSetup.email} not found.");
      }
    } catch (e) {
      print("Error updating user image: $e");
    }
  }


  Future<void> updateUserBodyComposition({
    required UserSetup userSetup,
    required BodyComposition bodyComposition,
    required int dietPlan,
  }) async {
    CollectionReference usersCollection = _fireStore.collection('bodyComposition');

    try {
      QuerySnapshot querySnapshot =
      await usersCollection.where("email", isEqualTo: userSetup.email).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference userDocument = querySnapshot.docs.first.reference;

        await userDocument.update({
          'email': userSetup.email,
          "muscleMass": bodyComposition.muscleMass,
          "leanMass": bodyComposition.leanMass,
          "fatMass": bodyComposition.fatMass,
          "fatMass%": bodyComposition.bodyFatPercentage,
          "water%": bodyComposition.bodyWaterPercentage,
          "calories": bodyComposition.calories,
          "questionnaireScore": bodyComposition.questionnaireScore,
          "dietPlan": 1,

        });
      } else {
        print("User with email ${userSetup.email} not found.");
      }
    } catch (e) {
      print("Error updating user image: $e");
    }
  }


  Future<List<Map<String, dynamic>>> fetchTrainsData() async {
    QuerySnapshot querySnapshot = await _fireStore.collection('trains').get();

    List<Map<String, dynamic>> dataList = [];

    querySnapshot.docs.forEach((DocumentSnapshot document) {
      Map<String, dynamic> documentData =
          document.data() as Map<String, dynamic>;
      documentData['documentId'] =
          document.id; // Add the document ID to the map
      dataList.add(documentData);
    });

    return dataList;
  }

  Future<void> cancelBooking(String documentId) async {
    try {
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('bookedTrains');

      await usersCollection.doc(documentId).delete();
      ShowToastMsg("Booking Cancel Successfully");
    } on FirebaseAuthException catch (e) {
      ShowToastMsg("Error in Deleting ${e.code}");
    }
  }

  void addTrainsData() async {
    DocumentReference documentReference = _fireStore.collection('trains').doc();
    await documentReference.set({
      'Train Name': "Coastal Voyage",
      "Start Location": "Salmiya",
      "Destination": "Fahaheel",
      "Fare": "4",
      "Departure": " 09:45",
      "Arrival": "10:30",
    });
  }
}
