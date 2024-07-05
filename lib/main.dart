import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/connectivity/check.dart';
import 'package:healthy/constants/theme/theme.dart';
import 'package:healthy/docHome.dart';
import 'package:healthy/firebasecontrol/authentication/authenticate.dart';
import 'package:healthy/firebasecontrol/notifications/messaging.dart';
import 'package:healthy/home.dart';

import 'starting.dart';


Future<void> main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  
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
    return StreamBuilder(
      stream: AuthService().firebaseAuth.authStateChanges(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return const MyHomeDoc();
        }
        return const GetStarted();
      },
    );
  }
}