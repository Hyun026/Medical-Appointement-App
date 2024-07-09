import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy/screens/login/login.dart';
import 'package:healthy/screens/verification/newpass.dart';

class MyEmail extends StatefulWidget {
  const MyEmail({super.key});

  @override
  State<MyEmail> createState() => _MyEmailState();
}

class _MyEmailState extends State<MyEmail> {
TextEditingController emailController = TextEditingController();

@override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
         try {
           await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
          showDialog(context: context, builder: (context){
            return AlertDialog(
              content: Text("Password reset link sent! Check"),
            );
          });
         } on FirebaseAuthException catch (e) {
          print(e);
          showDialog(context: context, builder: (context){
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
           
         }
  }

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
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Please Enter Your Email To Get The Password Change Link :',
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
                        ),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Form(
                            child: SizedBox(
                              width: 300.w,
                              height: size.height * 0.06,
                              child: TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Enter your email',
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
                          ),
                        ),
                         SizedBox(height: 20.h,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(300.w, 50.h),
                            backgroundColor: const Color(0xff4cbbc5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            passwordReset;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyLogin(),
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
