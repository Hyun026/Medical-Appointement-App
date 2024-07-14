import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy/search/resultPage.dart';

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
       if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.exists) {
          Map<String, dynamic> doctorData = snapshot.data!.data() as Map<String, dynamic>;
          String doctorAddress = doctorData['city'];
          String imageLink = doctorData['imageLink'];

          return FutureBuilder<DocumentSnapshot>(
            future: usersRef.doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (userSnapshot.hasError) {
                return Center(child: Text('Error: ${userSnapshot.error}'));
              } else if (userSnapshot.hasData && userSnapshot.data!.exists) {
                Map<String, dynamic> userData = userSnapshot.data!.data() as Map<String, dynamic>;
                String userAddress = userData['city'];

                if (doctorAddress == userAddress) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyResult(doctorDetails: doctorData),
                            ),
                          );
                        },
                        child: Container(
                          width: size.width * 0.9,
                        
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
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
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                       '${doctorData['name']}   ${doctorData['lastname']}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${doctorData['city']}   ${doctorData['field']}',
                                      style: const TextStyle(
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
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              } else {
                return const Center(child: Text('User document does not exist'));
              }
            },
          );
        } else {
          return const Center(child: Text('Doctor document does not exist'));
        }
      },
    );
  }
}