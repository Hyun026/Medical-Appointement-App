import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthy/connectivity/notConnected.dart';
import 'package:healthy/main.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/*
enum InternetStatus { connected, disconnected }

class ConnectivityChecker extends StatefulWidget {
  final Widget Function(bool isConnected) builder;

  const ConnectivityChecker({Key? key, required this.builder}) : super(key: key);

  @override
  _ConnectivityCheckerState createState() => _ConnectivityCheckerState();
}

class _ConnectivityCheckerState extends State<ConnectivityChecker> {
  bool _isConnected = false;
  late StreamSubscription<InternetStatus> _internetConnectionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
      setState(() {
        _isConnected = event == InternetStatus.connected;
      });
    });
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_isConnected);
  }
}

class InternetConnection {
  Stream<InternetStatus> get onStatusChange => Stream.periodic(
        Duration(seconds: 5), // Adjust interval as needed
        (count) => count % 2 == 0 ? InternetStatus.connected : InternetStatus.disconnected,
      );
}
*/


class connectCheck extends StatefulWidget {
  const connectCheck({super.key});

  @override
  State<connectCheck> createState() => _connectCheckState();
}

class _connectCheckState extends State<connectCheck> {
  bool isConnected= false;

  StreamSubscription? _internetConnectionStreamSubscription;

  @override
  void initState() {
    super.initState();
   _internetConnectionStreamSubscription =  
    InternetConnection().onStatusChange.listen((event) {
      print(event);
      switch (event) {
        case InternetStatus.connected:
           setState(() {
          isConnected = true;
        });
        _navigateToNextPage();
          break;
        case InternetStatus.disconnected:
           setState(() {
          isConnected = false;
        });
        _navigateToNextPage();
          break;
        default:
        setState(() {
          isConnected = false;
        });
        _navigateToNextPage();
        break;
      }
    });
  }

   void _navigateToNextPage() {
    if (isConnected) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyMain()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Notconnected()),
      );
    }
  }



  @override
  void dispose() {
   _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
