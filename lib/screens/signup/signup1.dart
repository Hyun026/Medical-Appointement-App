
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constants/colors/colors.dart';
import 'package:healthy/screens/signup/doctor/dsignup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/widgets.dart';
import 'package:healthy/firebasecontrol/authentication/authenticate.dart';

import 'package:healthy/screens/login/login.dart';

import 'signup2.dart';

class MySignup1 extends StatefulWidget {
  const MySignup1({super.key});

  @override
  State<MySignup1> createState() => _MySignup1State();
}

class _MySignup1State extends State<MySignup1> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
   TextEditingController confirmPasswordController = TextEditingController();

  bool loading = false;
  

  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/background/back.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.5,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoctorCreate(),
                                    ),
                                  );
                        },
                       child:  Container(
                        height: 50.sp,
                        width: 50.sp,
                         decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                         ),
                         child: Icon(Icons.person),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: const Text(
                          'Sign in Patient',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Form(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Name',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            _buildInputField(
                                controller: nameController,
                                hintText: "First name",
                                obscureText: false),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Lastname',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            _buildInputField(
                                controller: lastnameController,
                                hintText: "Last name",
                                obscureText: false),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            _buildInputField(
                                controller: emailController,
                                hintText: "Enter your email",
                                obscureText: false),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            _buildInputField(
                                controller: passwordController,
                                hintText: "Enter your password",
                                obscureText: true),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Confirm password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            _buildInputField(
                                controller: confirmPasswordController,
                                hintText: "Confirm your password",
                                obscureText: true),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )),
                      ),
                      if (loading)
                        CircularProgressIndicator()
                      else
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(150, 50),
                              backgroundColor: MyColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              if (nameController.text == "" ||
                                  lastnameController.text == "" ||
                                  emailController.text == "" ||
                                  passwordController.text == "") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('All fields are required'),
                                  backgroundColor: Colors.red,
                                ));
                              } else if (passwordController.text !=
                                  confirmPasswordController.text) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('Passwords do not match'),
                                  backgroundColor: Colors.red,
                                ));
                              } else {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString("name", nameController.text);
                                prefs.setString(
                                    "lastname", lastnameController.text);
                                User? result = await AuthService().register(
                                    emailController.text,
                                    passwordController.text,
                                    context);
                                if (result != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MySignup2(),
                                    ),
                                  );
                                }
                              }
                              setState(() {
                                loading = false;
                              });
                            },
                            child: const Text(
                              'Next',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Do you have an account?",
                                style: TextStyle(color: Colors.black)),
                            TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MyLogin(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Log in",
                                  style: TextStyle(
                                      color: MyColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Widget _buildInputField({
  required TextEditingController controller,
  required String hintText,
  required bool obscureText,
}) {
  
  return SizedBox(
    width: 300.w,
    height: 50.h,
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(
          color: MyColors.hintTextColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5.w,
            color: MyColors.borderSideColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5.w,
            color: MyColors.borderSideColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}

