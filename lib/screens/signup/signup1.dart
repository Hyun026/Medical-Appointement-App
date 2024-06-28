import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  bool loading= false;

  @override
   Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                      const SizedBox(height: 30,),
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
                            SizedBox(
                              width: 300,
                              height: size.height * 0.06,
                              child: TextFormField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: ' First name',
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
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Lastname',style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),),
                            SizedBox(
                              width: 300,
                              height: size.height * 0.06,
                              child: TextFormField(
                                controller: lastnameController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: ' Last name',
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
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Email',style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),),
                            SizedBox(
                              width: 300,
                              height: size.height * 0.06,
                              child: TextFormField(
                                controller: emailController,
                               
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: ' Enter your email',
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
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Password',style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),),
                            SizedBox(
                              width: 300,
                              height: size.height * 0.06,
                              child: TextFormField(
                                obscureText: true,
                                controller: passwordController,
                               
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: ' Enter your Password',
                                  //obscureText: true,
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
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Confirm password',style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),),
                            SizedBox(
                              width: 300,
                              height: size.height * 0.06,
                              child: TextFormField(
                                obscureText: true,
                                controller: confirmPasswordController,
                                
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: ' Confirm your Password',
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
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )),
                      ),
                      
                   loading? CircularProgressIndicator() :  Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(150, 50),
                            backgroundColor: const Color(0xff4cbbc5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async{
                            setState(() {
                              loading = true;
                            });
                            if(nameController.text == "" || lastnameController.text == ""||emailController.text == "" || passwordController.text == ""){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required'),backgroundColor: Colors.red,));
                            } else if(passwordController.text != confirmPasswordController.text){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords do not match'),backgroundColor: Colors.red,));

                            }else{
                            final prefs = await   SharedPreferences.getInstance();
                            prefs.setString("name", nameController.text);
                            prefs.setString("lastname", lastnameController.text);
                            User? result =  await AuthService().register(emailController.text, passwordController.text, context);
                            if(result != null){
                               Navigator.push(
                                
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  MySignup2(),
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children:[ 
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
                             child:   const Text("Log in",style: TextStyle(color: Color(0xff4cbbc5), fontWeight: FontWeight.bold , fontSize: 15.0),  ) ),
                              
                     ], ),),
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
