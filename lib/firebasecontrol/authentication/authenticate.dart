import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //function to register user
  Future<User?> register(String email,String password, BuildContext context) async {
    try{
   UserCredential userCredential =  //store this widget of signIn in UserCredential
    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password, );
    return userCredential.user;
    }on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.red,));
   return null;

    }catch (e){
      print(e);
      return null;
    }
  }
   //function to login user
  Future<User?> login(String email,String password, BuildContext context) async{
    try{
    UserCredential userCredential =
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
    } on FirebaseAuthException catch(e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.red,));
    return null;
    }catch(e){
    print(e);
    return null;
    }

  }
   Future<bool> isDoctor(User user) async {
    DocumentSnapshot doctorDoc = await FirebaseFirestore.instance.collection('doctors').doc(user.uid).get();
    return doctorDoc.exists;
  }

   Future<bool> isUser(User user) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    return userDoc.exists;
  }
}