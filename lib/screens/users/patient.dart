import 'dart:typed_data';

import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/connectivity/refreshing.dart';
import 'package:healthy/constants/colors/colors.dart';

import 'package:healthy/firebasecontrol/firestore/retrieveData.dart';
import 'package:healthy/firebasecontrol/update/editProfile.dart';
import 'package:healthy/images/imageFire.dart';
import 'package:healthy/screens/medecins/Pathology.dart';
import 'package:healthy/screens/medecins/cardiology.dart';
import 'package:healthy/screens/medecins/dentist.dart';
import 'package:healthy/screens/medecins/dermatology.dart';
import 'package:healthy/screens/medecins/endocrinology.dart';
import 'package:healthy/screens/medecins/general.dart';
import 'package:healthy/screens/medecins/neurology.dart';
import 'package:healthy/screens/medecins/ophtalmology.dart';
import 'package:healthy/screens/medecins/orthopedy.dart';
import 'package:healthy/screens/medecins/pediatrics.dart';
import 'package:healthy/screens/medecins/pneumology.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPatient extends StatefulWidget {
  @override
  _MyPatientState createState() => _MyPatientState();
}

class _MyPatientState extends State<MyPatient> {
  Uint8List? image;
  String image1 = "";

  Future<void> selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        image = img;
      });
      await saveProfile();
    }
  }

  Future<void> saveProfile() async {
    if (image == null) {
      print('No image selected');
      return;
    }
    String resp = await StoreData().saveData(file: image!, fileName: '');
    if (resp == 'success') {
      print('Profile updated successfully');
      await _updateImageLink();
    } else {
      print('Failed to update profile: $resp');
    }
  }

  Future<void> _updateImageLink() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedImageLink = prefs.getString("imageLink");
    if (savedImageLink != null) {
      setState(() {
        image1 = savedImageLink;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateImageLink();
  }
  //image retrieve 
  Future<String> getCurrentUserImage() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (userDoc.exists) {
      return userDoc['imageLink'] ?? 'Unknown User'; 
    }
  }
  return 'Unknown User';
}

  final user = FirebaseAuth.instance.currentUser!;


 
  final Data firestoreService = Data();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: RefreshIndicator(
        onRefresh: () =>  Refreshing(context).refreshPageHomeDoc(),
        child: Scaffold(
          backgroundColor: MyColors.backgroundColor,
          body: SafeArea(
            bottom: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.3,
                    decoration: const BoxDecoration(color:MyColors.primaryColor),
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Row(
                        
                        
                        children: [
                          Stack(
                
                  children: [
                    FutureBuilder<String>(
                      future: getCurrentUserImage(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircleAvatar(
                            radius: 50,
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          String userImage = snapshot.data ?? '';
                
                          if (userImage.isEmpty) {
                            return const CircleAvatar(
                              radius: 50,
                              child: Icon(Icons.person, size: 50),
                            );
                          } else {
                            return CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(userImage),
                            );
                          }
                        }
                      },
                    ),
                   
                    GestureDetector(
                      onTap: selectImage,
                      child: const Icon(
                        Icons.add_a_photo, 
                        size: 30, 
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                                      FutureBuilder<String>(
                                                        future: Data().getMessage(),
                                                        builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text(
                                snapshot.data ?? 'No message retrieved',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold),
                              );
                            }
                                                        },
                                                      ),
                                                      SizedBox(width: 10.w,),
                                                      FutureBuilder<String>(
                                                        future: Data().getMessage2(),
                                                        builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text(
                                snapshot.data ?? 'No message retrieved',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold),
                              );
                            }
                                                        },
                                                      ),
                            
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: size.width*1,
                      child: Column(
                        children: [
                          const SegmentedTabControl(
                            tabs: [
                              SegmentTab(
                                  label: "Data", color: MyColors.primaryColor),
                              SegmentTab(
                                  label: "Files", color: MyColors.primaryColor),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Container(
                                  width: size.width,
                                  height: size.height * 0.5,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        
                                                    Text(
                                                      'CIN:',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 22.sp,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.sp),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: FutureBuilder<String>(
                                                        future: Data().getMessageCin(),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.hasError) {
                                                            return Text('Error: ${snapshot.error}');
                                                          } else {
                                                            return Container(
                                                              height: size.height * 0.07,
                                                              width: size.width * 0.8,
                                                              decoration: const BoxDecoration(
                                                                color: MyColors.Container,
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  snapshot.data ?? 'No message retrieved',
                                                                  style: TextStyle(
                                                                    color: MyColors.hintTextColor,
                                                                    fontSize: 22.sp,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    
                                                    Text(
                                                      'Gender:',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 22.sp,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.sp),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: FutureBuilder<String>(
                                                        future: Data().getMessageGender(),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.hasError) {
                                                            return Text('Error: ${snapshot.error}');
                                                          } else {
                                                            return Container(
                                                              height: size.height * 0.07,
                                                              width: size.width * 0.8,
                                                              decoration: const BoxDecoration(
                                                                color: MyColors.Container,
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  snapshot.data ?? 'No message retrieved',
                                                                  style: TextStyle(
                                                                    color: MyColors.hintTextColor,
                                                                    fontSize: 22.sp,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                     
                                                    Text(
                                                      'Birthday:',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 22.sp,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.sp),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: FutureBuilder<String>(
                                                        future: Data().getMessagebirth(),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.hasError) {
                                                            return Text('Error: ${snapshot.error}');
                                                          } else {
                                                            return Container(
                                                              height: size.height * 0.07,
                                                              width: size.width * 0.8,
                                                              decoration: const BoxDecoration(
                                                                color: MyColors.Container,
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  snapshot.data ?? 'No message retrieved',
                                                                  style: TextStyle(
                                                                    color: MyColors.hintTextColor,
                                                                    fontSize: 22.sp,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                     
                                                    Text(
                                                      'Phone Number:',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 22.sp,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.sp),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: FutureBuilder<String>(
                                                        future: Data().getMessagePhone(),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.hasError) {
                                                            return Text('Error: ${snapshot.error}');
                                                          } else {
                                                            return Container(
                                                              height: size.height * 0.07,
                                                              width: size.width * 0.8,
                                                              decoration: const BoxDecoration(
                                                                color: MyColors.Container,
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  snapshot.data ?? 'No message retrieved',
                                                                  style: TextStyle(
                                                                    color: MyColors.hintTextColor,
                                                                    fontSize: 22.sp,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                     
                                                    Text(
                                                      'Address:',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 22.sp,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.sp),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: FutureBuilder<String>(
                                                        future: Data().getMessageAddress(),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.hasError) {
                                                            return Text('Error: ${snapshot.error}');
                                                          } else {
                                                            return Container(
                                                              height: size.height * 0.07,
                                                              width: size.width * 0.8,
                                                              decoration: const BoxDecoration(
                                                                color: MyColors.Container,
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  snapshot.data ?? 'No message retrieved',
                                                                  style: TextStyle(
                                                                    color: MyColors.hintTextColor,
                                                                    fontSize: 22.sp,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                      Text(
                                                      'City :',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 22.sp,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.sp),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: FutureBuilder<String>(
                                                        future: Data().getMessageCity(),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.hasError) {
                                                            return Text('Error: ${snapshot.error}');
                                                          } else {
                                                            return Container(
                                                              height: size.height * 0.07,
                                                              width: size.width * 0.8,
                                                              decoration: const BoxDecoration(
                                                                color: MyColors.Container,
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  snapshot.data ?? 'No message retrieved',
                                                                  style: TextStyle(
                                                                    color: MyColors.hintTextColor,
                                                                    fontSize: 22.sp,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                     
                                                   
                                                    Text(
                                                      'Region:',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 22.sp,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.sp),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: FutureBuilder<String>(
                                                        future: Data().getMessageRegion(),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.hasError) {
                                                            return Text('Error: ${snapshot.error}');
                                                          } else {
                                                            return Container(
                                                              height: size.height * 0.07,
                                                              width: size.width * 0.8,
                                                              decoration: const BoxDecoration(
                                                                color: MyColors.Container,
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  snapshot.data ?? 'No message retrieved',
                                                                  style: TextStyle(
                                                                    color: MyColors.hintTextColor,
                                                                    fontSize: 22.sp,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    
                                                    Text(
                                                      'Insurance :',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 22.sp,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.sp),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: FutureBuilder<String>(
                                                        future: Data().getMessageAssur(),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.hasError) {
                                                            return Text('Error: ${snapshot.error}');
                                                          } else {
                                                            return Container(
                                                              height: size.height * 0.07,
                                                              width: size.width * 0.8,
                                                              decoration: const BoxDecoration(
                                                                color: MyColors.Container,
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  snapshot.data ?? 'No message retrieved',
                                                                  style: TextStyle(
                                                                    color: MyColors.hintTextColor,
                                                                    fontSize: 22.sp,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                     ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => EditUserForm(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100.w, 50.h),
                      backgroundColor: MyColors.button1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Edit', style: TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.bold)),
                          SizedBox(width: size.width * 0.01),
                          const Icon(Icons.edit, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                                      ],),
                                    ),
                                  )
                                ),
                                Container(
                                  width: size.width,
                                  height: size.height * 0.5,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30.0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            //row1
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  height: size.height * 0.1,
                                                  width: size.width * 0.45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    color: MyColors.Container
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MyGeneral(),
                                                        ),
                                                      );
                                                    },
                                                    child: Center(
                                                        child: Text('generale',
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .primaryColor,
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ),
                                                ),
                                                Container(
                                                  height: size.height * 0.1,
                                                  width: size.width * 0.45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    color: MyColors.Container
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                       Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MyPediatricy(),
                                                        ),
                                                      );
                                                    },
                                                    child: Center(
                                                        child: Text('Pediatrics',
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .primaryColor,
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20.sp,),
                                            //row 2
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  height: size.height * 0.1,
                                                  width: size.width * 0.45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    color: MyColors.Container
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                       Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MyCardiology(),
                                                        ),
                                                      );
                                                    },
                                                    child: Center(
                                                        child: Text('Cardiology',
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .primaryColor,
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ),
                                                ),
                                                Container(
                                                  height: size.height * 0.1,
                                                  width: size.width * 0.45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                   color: MyColors.Container
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                       Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Dentist(),
                                                        ),
                                                      );
                                                    },
                                                    child: Center(
                                                        child: Text(
                                                            'Dentist',
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .primaryColor,
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          SizedBox(height: 20.sp,),
                                            //row 3
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  height: size.height * 0.1,
                                                  width: size.width * 0.45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    color: MyColors.Container
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                       Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MyNeurology(),
                                                        ),
                                                      );
                                                    },
                                                    child: Center(
                                                        child: Text('Nephrology',
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .primaryColor,
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ),
                                                ),
                                                Container(
                                                  height: size.height * 0.1,
                                                  width: size.width * 0.45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    color: MyColors.Container
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                       Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MyNeurology(),
                                                        ),
                                                      );
                                                    },
                                                    child: Center(
                                                        child: Text('Neurology',
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .primaryColor,
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20.sp,),
                                            //row 4
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  height: size.height * 0.1,
                                                  width: size.width * 0.45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    color: MyColors.Container
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                       Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MyDermatology(),
                                                        ),
                                                      );
                                                    },
                                                    child: Center(
                                                        child: Text(
                                                            'Dermatology',
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .primaryColor,
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ),
                                                ),
                                                Container(
                                                  height: size.height * 0.1,
                                                  width: size.width * 0.45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    color: MyColors.Container
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                       Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MyOphtal(),
                                                        ),
                                                      );
                                                    },
                                                    child: Center(
                                                        child: Text(
                                                            'Ophthalmology',
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .primaryColor,
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20.sp,),
                                            //row 5
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  height: size.height * 0.1,
                                                  width: size.width * 0.45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    color: MyColors.Container
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                       Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MyPneu(),
                                                        ),
                                                      );
                                                    },
                                                    child: Center(
                                                        child: Text('Pneumology',
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .primaryColor,
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ),
                                                ),
                                                Container(
                                                  height: size.height * 0.1,
                                                  width: size.width * 0.45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                   color: MyColors.Container
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                       Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MyOrthopedy(),
                                                        ),
                                                      );
                                                    },
                                                    child: Center(
                                                        child: Text('Orthopedy',
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .primaryColor,
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20.h,),
                                            //row 6 
                                             Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  height: size.height * 0.1,
                                                  width: size.width * 0.45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    color: MyColors.Container
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MyPathology(),
                                                        ),
                                                      );
                                                    },
                                                    child: Center(
                                                        child: Text('Pathalogy',
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .primaryColor,
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ),
                                                ),
                                                Container(
                                                  height: size.height * 0.1,
                                                  width: size.width * 0.45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    color: MyColors.Container
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                       Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MyEndocrinology(),
                                                        ),
                                                      );
                                                    },
                                                    child: Center(
                                                        child: Text('Endocrinology',
                                                            style: TextStyle(
                                                                color: MyColors
                                                                    .primaryColor,
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
        ),
      ),
    );
  }
}
