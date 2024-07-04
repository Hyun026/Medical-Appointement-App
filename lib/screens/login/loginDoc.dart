import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constants/colors/colors.dart';
import 'package:healthy/docHome.dart';
import 'package:healthy/firebasecontrol/authentication/authenticate.dart';
import 'package:healthy/screens/login/login.dart';
import 'package:healthy/screens/signup/doctor/dsignup.dart';
import 'package:healthy/screens/verification/email.dart';

class MyLogindoc extends StatefulWidget {
  const MyLogindoc({super.key});

  @override
  State<MyLogindoc> createState() => _MyLogindocState();
}

class _MyLogindocState extends State<MyLogindoc> {
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
          image: AssetImage("assets/background/back.jpeg"), 
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
                     
                      Row(
                        children: [
                           GestureDetector(
                        onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyLogin(),
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
                          Text(
                            'Log in',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22.sp),
                          ),
                        ],
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
                            _buildInputField(controller: emailController, hintText: "Entrer your email", obscureText: false),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text('Password',style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.sp),),
                            _buildInputField(controller: passwordController, hintText: "Enter your password", obscureText: false),
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
                              style: TextStyle(color: MyColors.primaryColor))),
                    loading ? CircularProgressIndicator() :  Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(300.w, 50.h),
                            backgroundColor: MyColors.primaryColor,
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
                                builder: (context) =>  MyHomeDoc(),
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
                                  builder: (context) => DoctorCreate(),
                                ),
                              );
                            },
                            child: const Text("Don't you have an account?",
                                style: TextStyle(color: MyColors.primaryColor))),
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

