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
}