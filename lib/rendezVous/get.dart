import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class GetMyAppoint extends StatefulWidget {
  final String documentId;
  const GetMyAppoint({required this.documentId});

  @override
  State<GetMyAppoint> createState() => _GetMyAppointState();
}

class _GetMyAppointState extends State<GetMyAppoint> {
   final user = FirebaseAuth.instance.currentUser!;

  Future<void> deleteAppointment(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('appointments').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: const Text('Appointment deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
      
      setState(() {}); 
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting appointment: $e'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error deleting document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference appoint = FirebaseFirestore.instance.collection('appointments');
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<DocumentSnapshot>(
      future: appoint.doc(widget.documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            String imageLink = data['imageLink'];

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.8,
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
                                data['Dname'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${data['date']} || ${data['time']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  deleteAppointment(widget.documentId);
                                  //add a snackbar 
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('Document does not exist');
          }
        }
        return const Text('loading...');
      },
    );
  }
}