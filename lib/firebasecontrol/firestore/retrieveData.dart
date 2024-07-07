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

//for users cin
  Future<String> getMessageCin() async {
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
       String message = snapshot.docs.first.data()['cin'] ?? 'No cin found';
        return '$message';
      } else {
        return 'Document does not exist';
      }
    } catch (e) {
      print('Error fetching message: $e');
      return 'Failed to fetch message';
    }
  }
// for users gender
  Future<String> getMessageGender() async {
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
       String message = snapshot.docs.first.data()['gender'] ?? 'No gender found';
        return '$message';
      } else {
        return 'Document does not exist';
      }
    } catch (e) {
      print('Error fetching message: $e');
      return 'Failed to fetch message';
    }
  }
//for users birthday
  Future<String> getMessagebirth() async {
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
       String message = snapshot.docs.first.data()['birthday'] ?? 'No birthday found';
        return '$message';
      } else {
        return 'Document does not exist';
      }
    } catch (e) {
      print('Error fetching message: $e');
      return 'Failed to fetch message';
    }
  }
// for users phone number 

  Future<String> getMessagePhone() async {
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
       String message = snapshot.docs.first.data()['phone'] ?? 'No phone found';
        return '$message';
      } else {
        return 'Document does not exist';
      }
    } catch (e) {
      print('Error fetching message: $e');
      return 'Failed to fetch message';
    }
  }

//for users address 
  Future<String> getMessageAddress() async {
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
       String message = snapshot.docs.first.data()['address'] ?? 'No address found';
        return '$message';
      } else {
        return 'Document does not exist';
      }
    } catch (e) {
      print('Error fetching message: $e');
      return 'Failed to fetch message';
    }
  }

// for users region 
  Future<String> getMessageRegion() async {
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
       String message = snapshot.docs.first.data()['region'] ?? 'No region found';
        return '$message';
      } else {
        return 'Document does not exist';
      }
    } catch (e) {
      print('Error fetching message: $e');
      return 'Failed to fetch message';
    }
  }

// for users assurance 
  Future<String> getMessageAssur() async {
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
       String message = snapshot.docs.first.data()['assurance'] ?? 'No assurance found';
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
       String message = snapshot.docs.first.data()['field'] ?? 'No field found';
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
       String message = snapshot.docs.first.data()['address'] ?? 'No address found';
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
       String message = snapshot.docs.first.data()['phone'] ?? 'No phone found';
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