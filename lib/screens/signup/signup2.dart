import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/home.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySignup2 extends StatefulWidget {
  const MySignup2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MySignup2State();
}

class _MySignup2State extends State<MySignup2> {
  TextEditingController cinController = TextEditingController();
  TextEditingController adressController = TextEditingController();

  TextEditingController birthDateController = TextEditingController();
  TextEditingController assurance = TextEditingController();
  TextEditingController gender = TextEditingController();

  String? valueChoose;
  List<String> listItem = ["CNSS", "AMO", "CNOPS"];

  String? valueChoose2;
  List<String> listItem2 = ["Female", "Male"];

  String name = "";
  String lastname = "";
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name")!;
      lastname = prefs.getString("lastname")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.sp),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Center(
                        child: Form(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CIN',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp),
                            ),
                            SizedBox(
                              width: 300.w,
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              width: 350.w,
                              height: size.height * 0.06,
                              child: TextFormField(
                                controller: cinController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.card_membership_rounded,
                                    color: Colors.black,
                                    size: 25.0,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: ' CIN',
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
                            Text(
                              'Address',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp),
                            ),
                            SizedBox(
                              width: 300.w,
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              width: 350.w,
                              height: size.height * 0.06,
                              child: TextFormField(
                                controller: adressController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.home_outlined,
                                    color: Colors.black,
                                    size: 25.0,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Enter your local adress',
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
                            Text(
                              'Birthday',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp),
                            ),
                            SizedBox(
                              width: 300.w,
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              width: 350.w,
                              height: size.height * 0.06,
                              child: TextFormField(
                                controller: birthDateController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.calendar_month_outlined,
                                    color: Colors.black,
                                    size: 25.0,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: ' Enter your birthday',
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
                                onTap: () async {
                                  DateTime date = DateTime(1900);
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  date = (await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100)))!;

                                  String dateFormatter = date.toIso8601String();

                                  DateTime dt = DateTime.parse(dateFormatter);
                                  var formatter = DateFormat('dd-mm-yyyy');

                                  birthDateController.text =
                                      formatter.format(dt);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Assurance',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp),
                            ),
                            SizedBox(
                              width: 300.w,
                              height: size.height * 0.01,
                            ),
                            Container(
                              width: 350.w,
                              height: size.height * 0.06,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffCAEBF3)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.shield,
                                    color: Color(0xff4cbbc5),
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  hint: const Text(
                                    'Assurance',
                                    style: TextStyle(
                                      color: Color(0xffafafaf),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xff35CBCC),
                                  ),
                                  value: valueChoose,
                                  onChanged: (newValue) {
                                    setState(() {
                                      valueChoose = newValue;
                                      assurance.text = newValue!;
                                    });
                                  },
                                  items: listItem.map((valueItem) {
                                    return DropdownMenuItem<String>(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Gender',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp),
                            ),
                            SizedBox(
                              width: 300.w,
                              height: size.height * 0.06,
                            ),
                            Container(
                              width: 350.w,
                              height: size.height * 0.06,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffCAEBF3)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.shield,
                                    color: Color(0xff4cbbc5),
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  hint: const Text(
                                    'Gender',
                                    style: TextStyle(
                                      color: Color(0xffafafaf),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xff35CBCC),
                                  ),
                                  value: valueChoose2,
                                  onChanged: (newValue) {
                                    setState(() {
                                      valueChoose2 = newValue;
                                      gender.text = newValue!;
                                    });
                                  },
                                  items: listItem2.map((valueItem) {
                                    return DropdownMenuItem<String>(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        )),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(150.w, 50.h),
                              backgroundColor: const Color(0xff4cbbc5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              if (adressController.text == "" ||
                                  cinController.text == "" || assurance.text == "" || birthDateController.text == "" || gender.text == "") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('All fields are required'),
                                  backgroundColor: Colors.red,
                                ));
                              } else {
                                Map<String, dynamic> dataToSave = {
                                  'name': name,
                                  'lastname': lastname,
                                  "adress": adressController.text,
                                  'cin': cinController.text,
                                  'birthday': birthDateController.text,
                                  'assurance': assurance.text,
                                  'gender': gender.text,
                                };

                                FirebaseFirestore.instance
                                    .collection("users")
                                    .add(dataToSave);

                                //await FirestoreService().insertUser(name,lastname,adressController.text, cinController.text);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHome(),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22.sp),
                            ),
                          ),
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
