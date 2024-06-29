import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Data {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getMessage() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return 'User not authenticated';
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection('users')
          .where('user', isEqualTo: user.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
       String message = snapshot.docs.first.data()['name'] ?? 'No name found';
        return '$message';
      } else {
        return 'Document does not exist';
      }
    } catch (e) {
      print('Error fetching message: $e');
      return 'Failed to fetch message';
    }
  }

   Future<String> getMessage2() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return 'User not authenticated';
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection('users')
          .where('user', isEqualTo: user.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
       String message = snapshot.docs.first.data()['lastname'] ?? 'No name found';
        return '$message';
      } else {
        return 'Document does not exist';
      }
    } catch (e) {
      print('Error fetching message: $e');
      return 'Failed to fetch message';
    }
  }
}