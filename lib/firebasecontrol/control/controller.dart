import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextController extends GetxController{

  static TextController get instance => Get.find();
 
  TextEditingController cinController = TextEditingController();
  TextEditingController adressController = TextEditingController();

  
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
}