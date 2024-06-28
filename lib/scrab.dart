import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Myscarb extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Myscarb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(onPressed: ()async{
            CollectionReference users = firestore.collection('users');
            await users.add({
              'name':'yusra'
                    
            });
            await users.doc("flutter123").set({
              'name':'Google flutter'
            });
          },
           child: Text('add')),
           ElevatedButton(onPressed: () async{
            CollectionReference users = firestore.collection('users');
            QuerySnapshot allResults = await users.get();
            //all documents
            allResults.docs.forEach((DocumentSnapshot result) {
              print(result.data());
             });

             //one document
             DocumentSnapshot result = await users.doc('flutter123').get();
             print(result.data());

             //use stream for real time change without having to debugg
             users.doc("flutter123").snapshots().listen((result) { 
              print(result.data());
             });

           }, child: Text('read data from fire store')),

           ElevatedButton(onPressed: ()async {
            await firestore.collection('users').doc('flutter123').update({
              'name':'Flutter Firebase'
            });

           }, child: Text('update data')),

           ElevatedButton(onPressed: ()async {
            await firestore.collection('users').doc("flutter123").delete();
           }, child: Text('delete database')),
        ],
      ),
    );
  }
}