import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/screens/login/login.dart';
import 'package:healthy/screens/signup/signup1.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

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
                height: size.height * 0.75,
              ),
              Container(
                width: size.width * 1,
                height: size.height * 0.25,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(300.w, 50.h),
                        backgroundColor: const Color(0xff4cbbc5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  MySignup1(),
                              ),
                            );
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white, fontSize: 20.sp),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    ElevatedButton(
                      onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyLogin(),
                              ),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(300.w, 50.h),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Color(0xff4cbbc5)),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.black, fontSize: 20.sp ,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
