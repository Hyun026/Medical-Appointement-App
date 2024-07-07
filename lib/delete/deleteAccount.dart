import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:healthy/starting.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Account'),
      content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(); 
          },
        ),
        TextButton(
          child: const Text('Delete'),
          onPressed: () async {
           
             await deleteAccount(context);
            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const GetStarted(),
                                ),
                              );
          },
        ),
      ],
    );
  }

 Future<void> deleteAccount(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;

      // Delete user from Firebase Auth
      await user.delete();

      // Check if user exists in 'users' collection and delete
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      }

      // Check if user exists in 'doctors' collection and delete
      DocumentSnapshot doctorDoc = await FirebaseFirestore.instance.collection('doctors').doc(userId).get();
      if (doctorDoc.exists) {
        await FirebaseFirestore.instance.collection('doctors').doc(userId).delete();
      }

      // Delete user data from Firebase Storage
      final storage = FirebaseStorage.instance;
      final storageRef = storage.ref().child('user_data').child(userId);

      try {
        await storageRef.delete();
      } catch (e) {
     
        print('Error deleting user data from Storage: $e');
      }

    
    }
  }
}
