// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy/delete/deleteAccount.dart';
import 'package:healthy/screens/login/login.dart';
import 'package:healthy/screens/users/doctor.dart';
import 'package:healthy/screens/users/patient.dart';
import 'package:healthy/screens/verification/email.dart';
import 'package:healthy/settings/helpSupport.dart';
import 'package:healthy/settings/info.dart';
import 'package:healthy/settings/privacy.dart';

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
              leading: const Icon(Icons.password),
              title: const Text('Password Change'),
              onTap: () {
                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyEmail(),
                                ),
                              );
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Privacy'),
              onTap: () {
               Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  PrivacyPage(),
                                ),
                              );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Support'),
              onTap: () {
                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  const HelpPage(),
                                ),
                              );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  const AboutPage(),
                                ),
                              );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Delete Account'),
               onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const DeleteAccountDialog();
          },
        );
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
