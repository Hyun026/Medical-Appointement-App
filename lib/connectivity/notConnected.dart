import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/connectivity/check.dart';

class Notconnected extends StatelessWidget {
  const Notconnected({super.key});

  @override
  Widget build(BuildContext context) {
     final Size size = MediaQuery.of(context).size;
    final double iconSize = size.width * 0.2;
    return Scaffold(
      body: Center(
      child:   Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.signal_wifi_connected_no_internet_4, size: iconSize,),
           SizedBox(height: 10.h,),
          Text('Connect to the internet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),),
          SizedBox(height: 10.h,),
          Text("You're offline. Check your connection.", style: TextStyle(fontSize: 17.sp),),
           SizedBox(height: 10.h,),
          GestureDetector(
            onTap: () {Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => connectCheck()),
            );},
            child: Icon(Icons.replay_outlined),
          ),
        ],
      ),
      ),
    );
  }
}