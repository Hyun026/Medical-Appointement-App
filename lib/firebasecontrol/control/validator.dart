
import 'package:flutter/material.dart';

class SValidator {
//empty text
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

//email
  static String? validateEmail(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email is required'),
          backgroundColor: Colors.red,
        ),
      );
      return 'Email is required';
    }
  
    // Check if the email matches the regular expression
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid Email'),
          backgroundColor: Colors.red,
        ),
      );
      return 'Invalid Email';
    }
    
    // Return null if the email is valid
    return null;
  }

//password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password est necessaire';
    }
    //check password length
    if (value.length < 6) {
      return 'Password doit etre 6 caractéres';
    }
    //check for uppercase characters
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password doit contient en min un nombre';
    }
    //check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password doit contient en min un special character';
    }
    return null;
  }

  static String? validatePassConf(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password est necessaire';
    }
    if (value != validatePassword(value)) {
      return "n'est pas le meme";
    }
    return null;
  }

  //phone number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number est necessaire';
    }
    // Check if the value matches a phone number pattern
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid Phone Number';
    }
    return null;
  }
}
