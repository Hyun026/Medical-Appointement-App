// for user

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:healthy/home.dart';

class Refreshing {
  final BuildContext context;

  Refreshing(this.context);

  Future<void> refreshPageHomeDoc() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No internet connection'),
        ),
      );
      return;
    }

    await Future.delayed(Duration(seconds: 1));

 
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyHome()),
    );
  }
}

