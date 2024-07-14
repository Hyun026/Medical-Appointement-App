import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy/connectivity/refreshing.dart';
import 'package:healthy/rendezVous/get.dart';

//here to read containers full of rendez vous
class MyRendezVous extends StatefulWidget {
  const MyRendezVous({super.key});

  @override
  State<MyRendezVous> createState() => _MyRendezVousState();
}

class _MyRendezVousState extends State<MyRendezVous> {
  final user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('appointments')
        .where('user', isEqualTo: user.uid)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh:   () => Refreshing(context).refreshPageHomeDoc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Rendez-vous'),
        ),
        body: Expanded(
          child: FutureBuilder(
            future: getDocId(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: docIDs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: GetMyAppoint(documentId: docIDs[index]),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
