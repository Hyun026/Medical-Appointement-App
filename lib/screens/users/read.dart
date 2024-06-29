import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy/firebasecontrol/firestore/fileget.dart';

class MyFile extends StatefulWidget {
  const MyFile({super.key});

  @override
  State<MyFile> createState() => _MyFileState();
}

class _MyFileState extends State<MyFile> {
  final user = FirebaseAuth.instance.currentUser!;
//list of document
  List<String> docIDs = [];
//get
   Future getDocId()async {
    await FirebaseFirestore.instance.collection('users').get().then((snapshot) => snapshot.docs.forEach((document) {
      print(document.reference); 
      docIDs.add(document.reference.id);
    }),);
  }
  //it adds double
 @override
  void initState() {
    getDocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:  Center(
      child: Container(
        width: size.width,
        height: size.height * 0.70,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(75.0),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                      future: getDocId(),
                      builder:(context, snapshot) {
                        return ListView.builder(
                          itemCount: docIDs.length,
                          itemBuilder:(context,index){
                         return ListTile(
                           title: GetUser(documentId: docIDs[index]),
                         );
                       } ,
                          
                        );
        
                        
                      },),
            ),
          ],
        ),
      ),
      ),
    );
  }
}