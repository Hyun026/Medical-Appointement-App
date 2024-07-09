import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/connectivity/check.dart';
import 'package:healthy/constants/theme/theme.dart';
import 'package:healthy/docHome.dart';
import 'package:healthy/home.dart';

import 'starting.dart';


Future<void> main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelKey: 'Healthy',
          channelName: 'Lol',
          channelDescription: 'hello'),
    ],
    debug: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.system,
          home: const connectCheck(),
        );
      },
    );
  }
}

class MyMain extends StatelessWidget {
  const MyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          User? user = snapshot.data;

          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('doctors')
                .doc(user!.uid)
                .get(),
            builder: (context, doctorSnapshot) {
              if (doctorSnapshot.hasData &&
                  doctorSnapshot.data != null &&
                  doctorSnapshot.data!.exists) {
                return MyHomeDoc();
              } else {
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.hasData &&
                        userSnapshot.data != null &&
                        userSnapshot.data!.exists) {
                      return MyHome();
                    } else {
                      return  MyHome();
                    }
                  },
                );
              }
            },
          );
        } else {
          return const GetStarted();
        }
      },
    );
  }
}
