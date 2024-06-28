import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy/screens/users/user.dart';

class userService extends GetxController{
  static userService get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  createUser(UserModel user)async{
    
   await _db.collection("Users").add(user.toJson()).whenComplete(() => Get.snackbar("Success", "Your account has been created",backgroundColor: Colors.red))
    .catchError((error , StackTrace){
      Get.snackbar("Error", "Something went wrong ", backgroundColor: Colors.red);
      print(error.toString());
    });
  }
}