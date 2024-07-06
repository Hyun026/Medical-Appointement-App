import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Data {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
//get users name
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

//get users last name
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



  //retrieve data for doctors
  
  //get doctors last name
   Future<String> getMessage3() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return 'User not authenticated';
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection('doctors')
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

//get doctors name
  Future<String> getMessage4() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return 'User not authenticated';
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection('doctors')
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

//get doctors field
  Future<String> getMessage5() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return 'User not authenticated';
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection('doctors')
          .where('user', isEqualTo: user.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
       String message = snapshot.docs.first.data()['field'] ?? 'No name found';
        return '$message';
      } else {
        return 'Document does not exist';
      }
    } catch (e) {
      print('Error fetching message: $e');
      return 'Failed to fetch message';
    }
  }

//get doctors adress
  Future<String> getMessage6() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return 'User not authenticated';
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection('doctors')
          .where('user', isEqualTo: user.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
       String message = snapshot.docs.first.data()['address'] ?? 'No name found';
        return '$message';
      } else {
        return 'Document does not exist';
      }
    } catch (e) {
      print('Error fetching message: $e');
      return 'Failed to fetch message';
    }
  }

//get doctors phone

Future<String> getMessage7() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return 'User not authenticated';
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection('doctors')
          .where('user', isEqualTo: user.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
       String message = snapshot.docs.first.data()['phone'] ?? 'No name found';
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