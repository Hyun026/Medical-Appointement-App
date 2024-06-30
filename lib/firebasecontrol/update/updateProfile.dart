

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Update{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


Future<void> updateProfile(String docIDs, String newadress,String newregion, String newphone)async{

      User? user = _auth.currentUser;
      if(user != null){
         DocumentReference userDocRef = _firestore.collection('users').doc(user.uid);
        DocumentSnapshot userDocSnapshot = await userDocRef.get();

        if (userDocSnapshot.exists){
           await userDocRef.update({
            'phone':newphone ,
            'region':newregion,
            'adress': newadress,
          });
        }
      }
}
}