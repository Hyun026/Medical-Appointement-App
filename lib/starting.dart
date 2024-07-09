import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constants/colors/colors.dart';
import 'package:healthy/screens/login/login.dart';
import 'package:healthy/screens/signup/signup1.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background/light.jpeg"), 
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
                        backgroundColor:  MyColors.button1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  const MySignup1(),
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
                          side: const BorderSide(color: MyColors.button1),
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
