import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        "age": userSetup.age??" years",
        "BMI": userSetup.BMI,

      });
      return;
    } on FirebaseException catch (e) {
      print("Error ${e.toString()}");
    }
  }

  static insertBookedTrainData({
    required String destination,
    required String source,
    required String trainName,
    required String fare,
    required String arrival,
    required String email,

    required String departure,
    required String numberOfSeats,
    required String totalPrice
    ,
    required String numberOfAdults,
   required String numberOfChildren,
   required String numberOfInfants,

  }) async {
    try {
      DocumentReference documentReference = _fireStore.collection(
          'bookedTrains').doc();
      await documentReference.set({
        'Train Name': trainName,
        "Start Location": source,
        "Destination": destination,
        "Fare": fare,
        "Departure": departure,
        "Arrival": arrival,
        "Email": email,
        "Number Of Seats": numberOfSeats,
        "Total Price": totalPrice,
        "Adults": numberOfAdults,
        "Children": numberOfChildren,
        "Infants": numberOfInfants,
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
      QuerySnapshot querySnapshot = await usersCollection
          .where("email", isEqualTo: email)
          .get();

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


  Future<List<Map<String, dynamic>>> fetchDataByEmail(String? email) async {
    CollectionReference ridesCollection = _fireStore.collection('users');
    try {
      QuerySnapshot querySnapshot = await ridesCollection
          .where("email", isEqualTo: email)
          .get();

      List<Map<String, dynamic>> dataList = [];

      querySnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> documentData = document.data() as Map<
            String,
            dynamic>;
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

  Future<List<Map<String, dynamic>>> fetchDataByEmailBookedTrains(
      String? email) async {
    CollectionReference ridesCollection = _fireStore.collection('bookedTrains');
    try {
      QuerySnapshot querySnapshot = await ridesCollection
          .where("Email", isEqualTo: email)
          .get();

      List<Map<String, dynamic>> dataList = [];

      querySnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> documentData = document.data() as Map<
            String,
            dynamic>;
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
    required String email,
    required String userName,
    required String firstName,
    required String lastName,
    required String cnic,


  }) async {
    CollectionReference usersCollection = _fireStore.collection('users');

    try {
      QuerySnapshot querySnapshot =
      await usersCollection.where("email", isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference userDocument = querySnapshot.docs.first.reference;

        await userDocument.update({
          'firstName': firstName,
          'lastName': lastName,
          'userName': userName,
          'cnic': cnic,
        });
      } else {
        print("User with email $email not found.");
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
