import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Function to insert user
  Future<void> insertUser(
      String name, String lastname, String cin, String address) async {
    try {
      await firestore.collection('user').add({
        "name": name,
        "lastname": lastname,
        "address": address,
        "CIN": cin,
        "date": DateTime.now(),
      });
    } catch (e) {
     
      print("Error inserting user: $e");
      throw Exception("Failed to insert user: $e");
    }
  }
}
  