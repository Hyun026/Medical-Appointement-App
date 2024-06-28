import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/connectivity/check.dart';
import 'package:healthy/firebasecontrol/authentication/authenticate.dart';
import 'package:healthy/home.dart';

import 'starting.dart';

Future<void> main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
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
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
            textTheme: GoogleFonts.manropeTextTheme(),
          ),
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
          return const MyHome();
        }
        return const GetStarted();
      },
    );
  }
}