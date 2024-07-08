import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/connectivity/refresh.dart';
import 'package:healthy/constants/colors/colors.dart';
import 'package:healthy/firebasecontrol/firestore/retrieveData.dart';
import 'package:healthy/firebasecontrol/notifications/notification.dart';
import 'package:healthy/firebasecontrol/update/editDocProfile.dart';

import 'package:healthy/images/imageFire.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDocProfile extends StatefulWidget {
  const MyDocProfile({super.key});

  @override
  State<MyDocProfile> createState() => _MyDocProfileState();
}

class _MyDocProfileState extends State<MyDocProfile> {
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
    String resp = await StoreData().saveData2(file: image!, fileName: '');
    if (resp == 'success') {
      print('Profile updated successfully');
      await _updateImageLink();
    } else {
      print('Failed to update profile: $resp');
    }
  }
 // get doct's image 
 //1
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
//2.
Future<String> getCurrentUserImage() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('doctors').doc(user.uid).get();
    if (userDoc.exists) {
      return userDoc['imageLink'] ?? 'Unknown User'; 
    }
  }
  return 'Unknown User';
}
  final user = FirebaseAuth.instance.currentUser!;
//list of document
  List<String> docIDs = [];
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('doctors')
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
    return RefreshIndicator(
      onRefresh: () => Refresh(context).refreshPageHomeDoc(),
      child: Scaffold(
           backgroundColor: MyColors.backgroundColor,
           appBar: AppBar( actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                 showDialog(
        context: context,
        builder: (BuildContext context) => const MyNotifications(),
      );
              },
            ),
          ],),
           body: Stack(
             children: [
              Align(
        alignment: Alignment.bottomCenter,
        child: Container(
      height: size.height * 0.74,
      width: size.width * 1,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.15),
              Text(
                'Name:',
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
                  future: Data().getMessage4(),
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
              SizedBox(height: 20.sp),
              Text(
                'Last Name:',
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
                  future: Data().getMessage3(),
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
              SizedBox(height: 20.sp),
              Text(
                'Field:',
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
                  future: Data().getMessage5(),
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
              SizedBox(height: 20.sp),
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
                  future: Data().getMessage6(),
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
               SizedBox(height: 20.sp),
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
                  future: Data().getMessage8(),
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
              SizedBox(height: 20.sp),
               Text(
                'Region :',
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
                  future: Data().getMessage9(),
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
              SizedBox(height: 20.sp),
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
                  future: Data().getMessage7(),
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
              SizedBox(height: 20.sp),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditDocForm(),
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
                      Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: size.width * 0.01),
                      const Icon(Icons.edit, color: Colors.white),
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
      
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: [
                    Stack(
                      
                      children: [
                        Container(
                          height: 150.h,
                          width: 150.h,
                          child: FutureBuilder<String>(
                            future: getCurrentUserImage(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircleAvatar(
                                  radius: 60,
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                String userImage = snapshot.data ?? '';
                                              
                                if (userImage.isEmpty) {
                                  return const CircleAvatar(
                                    radius: 80,
                                    child: Icon(Icons.person, size: 50),
                                  );
                                } else {
                                  return CircleAvatar(
                                    radius: 80,
                                    backgroundImage: NetworkImage(userImage),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                       
                        GestureDetector(
                          onTap: selectImage,
                          child: Container(
                            height: 30.h,
                            width: 30.h,
                            decoration: BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0)),
                            child: const Icon(
                              Icons.add_a_photo,
                              color: Color.fromARGB(255, 71, 170, 179), 
                              size: 30, 
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
             ],
           ),
      ),
    );
  }
}

 