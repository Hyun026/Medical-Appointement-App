import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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
            Navigator.of(context).pop(); // Close dialog
          },
        ),
        TextButton(
          child: const Text('Delete'),
          onPressed: () async {
            // Perform deletion
            await deleteAccount();
            Navigator.of(context).pop(); // Close dialog
          },
        ),
      ],
    );
  }

  Future<void> deleteAccount() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Delete user from Firebase Auth
      await user.delete();

      // Delete user document from Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();

      // Delete user data from Firebase Storage (if any)
      final storage = FirebaseStorage.instance;
      final storageRef = storage.ref().child('user_data').child(user.uid);

      try {
        await storageRef.delete();
      } catch (e) {
        // Handle errors, such as permission denied
        print('Error deleting user data from Storage: $e');
      }

      // Optionally: Any other cleanup or related tasks
    }
  }
}