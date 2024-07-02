import 'dart:typed_data';

import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constants/colors/colors.dart';
import 'package:healthy/firebasecontrol/firestore/fileget.dart';
import 'package:healthy/firebasecontrol/firestore/retrieveData.dart';
import 'package:healthy/images/imageFire.dart';
import 'package:healthy/screens/medecins/general.dart';
import 'package:healthy/screens/signup/doctor/dsignup.dart';
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
    String resp = await StoreData().saveData(file: image!);
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

  final user = FirebaseAuth.instance.currentUser!;
//list of document
  List<String> docIDs = [];
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('user', isEqualTo: user.uid)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }
 
  final Data firestoreService = Data();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
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
                        GestureDetector(
                          onTap: selectImage,
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              image: image != null
                                  ? DecorationImage(
                                      image: MemoryImage(image!),
                                      fit: BoxFit.cover,
                                    )
                                  : image1.isNotEmpty
                                      ? DecorationImage(
                                          image: NetworkImage(image1),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 2), 
                            ),
                            child: image == null && image1.isEmpty
                                ? const Center(child: Icon(Icons.person, size: 50))
                                : null,
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
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
                                      color: Colors.black,
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
                                      color: Colors.black,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                            },
                          ),
                              
                                ],
                              ),
                               ElevatedButton(onPressed: () {
                                 Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorCreate(),
                                ),
                              );
                               }, child: Text("Are you a Doctor?")),
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
                                    topLeft: Radius.circular(75.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: FutureBuilder(
                                        future: getDocId(),
                                        builder: (context, snapshot) {
                                          return ListView.builder(
                                            itemCount: docIDs.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: GetUser(
                                                    documentId: docIDs[index]),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: size.width,
                                height: size.height * 0.5,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(75.0),
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
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
                                                    BorderRadius.circular(50),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    MyColors.gradient
                                                  ],
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.topLeft,
                                                ),
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
                                                    BorderRadius.circular(50),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    MyColors.gradient
                                                  ],
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.topLeft,
                                                ),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Center(
                                                    child: Text('Pediatricians',
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
                                                    BorderRadius.circular(50),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    MyColors.gradient
                                                  ],
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.topLeft,
                                                ),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Center(
                                                    child: Text('Cardiologists',
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
                                                    BorderRadius.circular(50),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    MyColors.gradient
                                                  ],
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.topLeft,
                                                ),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Center(
                                                    child: Text(
                                                        'Endocrinologists',
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
                                                    BorderRadius.circular(50),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    MyColors.gradient
                                                  ],
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.topLeft,
                                                ),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Center(
                                                    child: Text('Nephrologists',
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
                                                    BorderRadius.circular(50),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    MyColors.gradient
                                                  ],
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.topLeft,
                                                ),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Center(
                                                    child: Text('Neurologists',
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
                                                    BorderRadius.circular(50),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    MyColors.gradient
                                                  ],
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.topLeft,
                                                ),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Center(
                                                    child: Text(
                                                        'Dermatologists',
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
                                                    BorderRadius.circular(50),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    MyColors.gradient
                                                  ],
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.topLeft,
                                                ),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Center(
                                                    child: Text(
                                                        'Ophthalmologists',
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
                                                    BorderRadius.circular(50),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    MyColors.gradient
                                                  ],
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.topLeft,
                                                ),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Center(
                                                    child: Text('Pneumologie',
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
                                                    BorderRadius.circular(50),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    MyColors.gradient
                                                  ],
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.topLeft,
                                                ),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Center(
                                                    child: Text('Orthipedy',
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
    );
  }
}
