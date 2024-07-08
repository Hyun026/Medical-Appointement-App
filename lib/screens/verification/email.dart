import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy/screens/verification/newpass.dart';

class MyEmail extends StatelessWidget {
  const MyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/background/c4dd94d01c88c6d1275a8d878bb51b30.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Container(
                width: size.width * 1,
                height: size.height * 0.9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text(
                            'Verify your Email',
                            style: TextStyle(
                                wordSpacing: 2,
                                color: Colors.black,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold),
                          ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        SizedBox(
                            height: 200.h,
                            width: 200.w,
                            child: SvgPicture.asset(
                                'assets/images/emailver/mail(1).svg')),
                                SizedBox(height: 60.h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Column(
                            children: [
                              Text(
                                'Please Enter The Four Number Code Sent To',
                                style: TextStyle(
                                  color: Colors.black,
                                  wordSpacing: 2,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                               Text(
                                'Your Email Inbox',
                                style: TextStyle(
                                  color: Colors.black,
                                  wordSpacing: 2,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Form(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 60.w,
                                  height: size.height * 0.06,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: '1',
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
                               SizedBox(width: 20.w,),
                                SizedBox(
                                  width: 60.w,
                                  height: size.height * 0.06,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: '3',
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
                                SizedBox(width: 20.w,),
                                SizedBox(
                                  width: 60.w,
                                  height: size.height * 0.06,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: '8',
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
                                SizedBox(width: 20.w,),
                                SizedBox(
                                  width: 60.w,
                                  height: size.height * 0.06,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: '4',
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
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                textStyle: TextStyle(fontSize: 16.sp),
                              ),
                              onPressed: () {},
                              child: const Text('Resend Code',
                                  style: TextStyle(color: Color(0xff4cbbc5)))),
                        ),
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
                                builder: (context) => const MyPass(),
                              ),
                            );
                          },
                          child: Text(
                            'Confirm',
                            style: TextStyle(color: Colors.white, fontSize: 20.sp),
                          ),
                        ),
                      ],
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
