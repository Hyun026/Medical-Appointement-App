import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy/screens/login/login.dart';
import 'package:healthy/screens/users/doctor.dart';


//table list
class MyHomeDoc extends StatefulWidget {
  const MyHomeDoc({super.key});

  @override
  State<MyHomeDoc> createState() => _MyHomeDocState();
}

class _MyHomeDocState extends State<MyHomeDoc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {
                      Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyDocProfile(),
                                    ),
                                  );
              },
               child: Text('doc')),
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