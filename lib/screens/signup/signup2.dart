import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constants/colors/colors.dart';
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
  TextEditingController regionController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController assurance = TextEditingController();
  TextEditingController gender = TextEditingController();

  String? valueChoose;
  List<String> listItem = ["CNSS", "AMO", "CNOPS"];

  String? valueChoose2;
  List<String> listItem2 = ["Female", "Male"];

  String? valueChoose3;
  List<String> listItem3 = [
    "Tanger-Tétouan-Al Hoceïma",
    "L'Oriental",
    "Fès-Meknès",
    "Rabat-Salé-Kénitra",
    "Béni Mellal-Khénifra",
    "Casablanca-Settat",
    "Marrakech-Safi",
    "Drâa-Tafilalet",
    "Souss-Massa",
    "Guelmim-Oued Noun",
    "Laâyoune-Sakia El Hamra",
    "Dakhla-Oued Ed-Dahab"
  ];

  String name = "";
  String lastname = "";
  bool _isUnderage = false;
  bool _lights = false;
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
                            _buildInputField(
                                controller: cinController,
                                hintText: "CIN",
                                obscureText: false,
                                prefixIcon: Icons.card_membership_rounded,
                                enabled: !_isUnderage),
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
                            _buildInputField(
                                controller: adressController,
                                hintText: "Enter your adress",
                                obscureText: false,
                                prefixIcon: Icons.home_outlined,
                                enabled: !_isUnderage),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Region',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp),
                            ),
                            SizedBox(
                              width: 300.w,
                              height: size.height * 0.01,
                            ),
                            buildDropdownWidget(
                              "Region",
                              valueChoose3,
                              regionController,
                              listItem3,
                              (newValue) {
                                setState(() {
                                  valueChoose3 = newValue;
                                });
                              },
                              Icons.location_on,
                              !_isUnderage,
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
                                    color: MyColors.hintTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color:MyColors.borderSideColor,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: MyColors.borderSideColor,
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
                                    lastDate: DateTime(2100),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                            colorScheme:
                                                const ColorScheme.light()
                                                    .copyWith(
                                              primary: MyColors.primaryColor,
                                              onPrimary: Colors.white,
                                            ),
                                            canvasColor: Colors.white),
                                        child: child!,
                                      );
                                    },
                                  ))!;

                                  String dateFormatter = date.toIso8601String();
                                  DateTime dt = DateTime.parse(dateFormatter);
                                  var formatter = DateFormat('dd-MM-yyyy');
                                  birthDateController.text =
                                      formatter.format(dt);

                                  DateTime now = DateTime.now();
                                  int age = now.year - dt.year;
                                  if (now.month < dt.month ||
                                      (now.month == dt.month &&
                                          now.day < dt.day)) {
                                    age--;
                                  }

                                  if (age < 18) {
                                    setState(() {
                                      _isUnderage = true;
                                    });
                                  } else {
                                    setState(() {
                                      _isUnderage = false;
                                    });
                                  }
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
                            buildDropdownWidget(
                              "Assurance",
                              valueChoose,
                              assurance,
                              listItem,
                              (newValue) {
                                setState(() {
                                  valueChoose = newValue;
                                });
                              },
                              Icons.shield,
                              !_isUnderage,
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
                              height:20.h
                            ),
                           buildDropdownWidget(
                              "Gender",
                              valueChoose2,
                              regionController,
                              listItem2,
                              (newValue) {
                                setState(() {
                                  valueChoose2 = newValue;
                                });
                              },
                              Icons.male,
                              !_isUnderage,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            CupertinoSwitch(
                                activeColor: Colors.blue,
                                value: _lights,
                                onChanged: (bool value) {
                                  setState(() {
                                    _lights = value;
                                  });
                                }),
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
                                  cinController.text == "" ||
                                  assurance.text == "" ||
                                  birthDateController.text == "" ||
                                  gender.text == "") {
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

Widget _buildInputField({
  required TextEditingController controller,
  required String hintText,
  required bool obscureText,
  required IconData prefixIcon,
  required bool enabled,
}) {
  return SizedBox(
    width: 350.w,
    height: 50.h,
    child: TextFormField(
      enabled: enabled,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
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

Widget buildDropdownWidget(
  String hintText,
  String? valueChoose,
  TextEditingController controller,
  List<String> listItem,
  Function(String?) onChanged,
  IconData prefixIcon,
  bool enabled,
) {
  return Container(
    width: 350.w,
    height: 50.h,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: MyColors.borderSideColor),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: InputDecorator(
      decoration: InputDecoration(
        fillColor: Colors.white,
        prefixIcon: Icon(prefixIcon),
      ),
      child: DropdownButton<String>(
        hint: Text(
          hintText,
          style: TextStyle(
            color: MyColors.hintTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(
          Icons.arrow_drop_down,
          color: MyColors.primaryColor,
        ),
        value: valueChoose,
        onChanged: enabled ? onChanged : null,
        items: listItem.map((valueItem) {
          return DropdownMenuItem<String>(
            value: valueItem,
            child: Text(valueItem),
          );
        }).toList(),
      ),
    ),
  );
}
