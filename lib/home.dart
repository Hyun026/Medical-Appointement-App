
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy/screens/login/login.dart';
import 'package:healthy/screens/users/patient.dart';
import 'package:healthy/search/searchList.dart';





class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         
      ),
     body:Center(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
     //searchbar shape
     GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MySearchBar()),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8.0),
            Text(
              'Search',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    ),
         
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