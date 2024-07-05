import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primarylightColor = Color(0xff4cbbc5);
 const Color secondarylightColor = Color(0xff379fac);

 const Color primarydarkColor = Color(0xff095761);
 const Color secondarydarkColor = Color(0xff379fac);


class AppThemes {
  static final lightTheme = ThemeData(
     visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
            textTheme: GoogleFonts.manropeTextTheme(),
    primaryColor: primarylightColor,
    hintColor:secondarylightColor ,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      color: primarylightColor,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
   
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primarylightColor),
      ),
      prefixIconColor: primarylightColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: primarylightColor, // Text color
      ),
    ),
  );

  static final darkTheme = ThemeData(
     visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
            textTheme: GoogleFonts.manropeTextTheme(),
    primaryColor: primarydarkColor,
    hintColor:secondarydarkColor ,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      color: primarydarkColor,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primarydarkColor),
      ),
      prefixIconColor: primarydarkColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: primarydarkColor, // Text color
      ),
    ),
  );
}