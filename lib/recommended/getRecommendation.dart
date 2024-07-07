import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRecomendation extends StatelessWidget {
  final String documentId;

  const MyRecomendation({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference doctorsRef = FirebaseFirestore.instance.collection('doctors');
    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

    Size size = MediaQuery.of(context).size;

    return FutureBuilder<DocumentSnapshot>(
      future: doctorsRef.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> doctorData = snapshot.data!.data() as Map<String, dynamic>;
            String doctorAddress = doctorData['address'];
            String imageLink = doctorData['imageLink'];

            // Fetch current user's address
            return FutureBuilder<DocumentSnapshot>(
              future: usersRef.doc(FirebaseAuth.instance.currentUser!.uid).get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.done) {
                  if (userSnapshot.hasData && userSnapshot.data!.exists) {
                    Map<String, dynamic> userData = userSnapshot.data!.data() as Map<String, dynamic>;
                    String userAddress = userData['address'];

                    // Check if doctor's address matches user's address
                    if (doctorAddress == userAddress) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(imageLink),
                                    radius: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doctorData['name'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        doctorData['address'] + ' ' + doctorData['field'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Text('No Recommendation');
                    }
                  } else {
                    return Text('User document does not exist');
                  }
                } else {
                  return Text('Loading user data...');
                }
              },
            );
          } else {
            return Text('Doctor document does not exist');
          }
        } else {
          return Text('Loading doctor data...');
        }
      },
    );
  }
}
