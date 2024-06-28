import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/firebasecontrol/authentication/authenticate.dart';
import 'package:healthy/home.dart';
import 'package:healthy/screens/signup/signup1.dart';

import '../verification/email.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff4cbbc5),
      body: SingleChildScrollView(
        child: Container(
             decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background/c4dd94d01c88c6d1275a8d878bb51b30.jpg"), 
          fit: BoxFit.cover,
        ),
      ),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.5,
              ),
              Container(
                width: size.width * 1,
                height: size.height * 0.50,
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
                      Text(
                        'Log in',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp),
                      ),
                      SizedBox(height: 30.h,),
                      Center(
                        child: Form(
                            child: Column(
                             
                              crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.sp),
                            ),
                            SizedBox(
                              width: 300.w,
                              height: size.height * 0.06,
                              child: TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: ' Enter you email',
                                  hintStyle: TextStyle(
                                    color: Color(0xffafafaf),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: Color(0xffCAEBF3),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: Color(0xffCAEBF3),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text('Password',style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.sp),),
                            SizedBox(
                              width: 300.w,
                              height: size.height * 0.06,
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: ' Enter your Password',
                                  hintStyle: TextStyle(
                                    color: Color(0xffafafaf),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: Color(0xffCAEBF3),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: Color(0xffCAEBF3),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(fontSize: 16.sp),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyEmail(),
                              ),
                            );
                          },
                          child: const Text('Forgot your password?',
                              style: TextStyle(color: Color(0xff4cbbc5)))),
                    loading ? CircularProgressIndicator() :  Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(300.w, 50.h),
                            backgroundColor: const Color(0xff4cbbc5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async{
                            setState(() {
                              loading= true;
                            });
                             if(emailController.text == "" || passwordController.text == ""){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required'),backgroundColor: Colors.red,));
                            } else{
                            User? result =  await AuthService().login(emailController.text, passwordController.text, context);
                            if(result != null){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  MyHome(),
                              ),
                            );
                            }
                            }
                            setState(() {
                              loading = false;
                            });
                          },
                          child: Text(
                            'log in',
                            style: TextStyle(color: Colors.white, fontSize: 20.sp),
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(fontSize: 16.sp),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MySignup1(),
                                ),
                              );
                            },
                            child: const Text("Don't you have an account?",
                                style: TextStyle(color: Color(0xff4cbbc5)))),
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
