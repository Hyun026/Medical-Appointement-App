
import 'package:flutter/material.dart';
import 'package:healthy/screens/login/login.dart';



class MyHome extends StatelessWidget {
  const MyHome({super.key});
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
     body:Column(
      children: [
        ElevatedButton(onPressed: () {
                Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyLogin(),
                              ),
                            );
        }, child: Text('log out'))
      ],
     ),
    );
  }
}