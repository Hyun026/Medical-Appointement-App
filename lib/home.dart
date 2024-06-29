
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy/screens/login/login.dart';
import 'package:healthy/screens/users/patient.dart';
import 'package:healthy/screens/users/read.dart';




class MyHome extends StatelessWidget {
  const MyHome({super.key});
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
     body:Center(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           ElevatedButton(onPressed: () {
                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyFile(),
                                ),
                              );
          }, child: Text('file')),
          ElevatedButton(onPressed: () {
                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyPatient(),
                                ),
                              );
          }, child: Text('Profile')),
          ElevatedButton(onPressed: () {
            FirebaseAuth.instance.signOut();
                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyLogin(),
                                ),
                              );
          }, child: Text('log out'))
        ],
       ),
     ),
    );
  }
}