import 'package:flutter/material.dart';
import 'package:healthy/constants/buttons/mainB.dart';
import 'package:healthy/constants/buttons/mathPrep.dart';
import 'package:healthy/constants/colors/colors.dart';

class MyGeneral extends StatefulWidget {
  const MyGeneral({super.key});

  @override
  State<MyGeneral> createState() => _MyGeneralState();
}

class _MyGeneralState extends State<MyGeneral> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

      ),
    floatingActionButton: QuickActionMenu(onTap: () {}, icon: Icons.menu, backgroundColor: MyColors.primaryColor, child:Container(), 
    actions:  [
          QuickAction(
            icon: Icons.camera,
            onTap: () {
              print('Search tapped');
            },
          ),
          QuickAction(
            icon: Icons.collections,
            onTap: () {
              print('Settings tapped');
            },
          ),
          QuickAction(
            icon: Icons.description,
            onTap: () {
              print('Info tapped');
            },
          ),
        ], 
     ),
    );
  }
}