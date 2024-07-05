import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy/screens/login/login.dart';
import 'package:healthy/screens/users/doctor.dart';
import 'package:healthy/screens/users/patient.dart';

class SettingsPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Account'),
              onTap:  () async {
            // Get current user
            User? user = _auth.currentUser;

            if (user != null) {
             
              DocumentSnapshot userDoc =
                  await _firestore.collection('users').doc(user.uid).get();
               DocumentSnapshot userDocT =
                  await _firestore.collection('doctors').doc(user.uid).get();

              if (userDoc.exists) {
              
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPatient()),
                );
              } else if(userDocT.exists) {
                
              
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyDocProfile()),
                );
              }
            }
          },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                // Navigate to notification settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Privacy'),
              onTap: () {
                // Navigate to privacy settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Support'),
              onTap: () {
                // Navigate to help & support
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                // Navigate to about page
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                 FirebaseAuth.instance.signOut();
                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyLogin(),
                                ),
                              );
              },
            ),
          ],
        ),
      ),
    );
  }
}
