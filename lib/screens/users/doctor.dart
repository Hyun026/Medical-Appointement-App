import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constants/colors/colors.dart';
import 'package:healthy/firebasecontrol/firestore/retrieveData.dart';
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
    String resp = await StoreData().saveData2(file: image!);
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
    return Scaffold(
         backgroundColor: MyColors.backgroundColor,
         body: Stack(
           children: [
             Align(
              alignment: Alignment.bottomCenter,
               child: Container(
                height:size.height*0.8,
                width: size.width*1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
  topLeft: Radius.circular(50.0),
  topRight: Radius.circular(50.0),
),
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Dr.',style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.bold),),
                                          SizedBox(width: 10.sp,),
                            FutureBuilder<String>(
                                future: Data().getMessage4(),
                                builder: (context, snapshot) {
                                 
                                   if (snapshot.hasError) {
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
                            SizedBox(width: 10.sp,),
                              FutureBuilder<String>(
                                future: Data().getMessage3(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
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
                      ),
                      FutureBuilder<String>(
                                future: Data().getMessage5(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      snapshot.data ?? 'No message retrieved',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22.sp,
                                          ),
                                    );
                                  }
                                },
                              ),
                              FutureBuilder<String>(
                                future: Data().getMessage6(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      snapshot.data ?? 'No message retrieved',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.sp,),
                                    );
                                  }
                                },
                              ),
                                                SizedBox(height: 20.h,),
                   
                /*   ElevatedButton(onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => EditDocForm(userData: data, documentId: documentId),
                      );
                   },
                   style: ElevatedButton.styleFrom(
                        minimumSize: Size(100.w, 50.h),
                        backgroundColor:  MyColors.button1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    child: Center(
                      child: Row(
                       mainAxisAlignment: MainAxisAlignment.center, 
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Edit', style: TextStyle(color: Colors.white, fontSize: 17.sp,fontWeight: FontWeight.bold),),
                          SizedBox(width: size.width*0.01,),
                          Icon(Icons.edit, color: Colors.white,),
                        ],
                      ),
                    ) ),*/
                    ],
                  ),
                ),
               ),
             ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 130,vertical: 110),
                child: GestureDetector(
                            onTap: selectImage,
                            child: Container(
                              width: 200.w,
                              height: 150.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
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
              ),
           ],
         ),
    );
  }
}