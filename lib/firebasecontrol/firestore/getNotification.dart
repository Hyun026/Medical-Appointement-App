import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// for the doctor 
class Getnotification extends StatelessWidget {
   final String documentId;
  const Getnotification({required this.documentId});

 @override
  Widget build(BuildContext context) {
   CollectionReference appoint = FirebaseFirestore.instance.collection('notifications');
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
      future: appoint.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.exists) {
           
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
             String imageLink = data['imageLink'];
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
                          data['date'] + ' ' + data['time'], 
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
                    
            ],
                        );
           }else {
            return const Text('Document does not exist');
           }
        }
        return const Text('loading..');
  }
      
    );
  }
}
