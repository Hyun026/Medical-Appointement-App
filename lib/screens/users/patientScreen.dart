import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constants/colors/colors.dart';
import 'package:healthy/docView/cardiolog2.dart';
import 'package:healthy/docView/dentist2.dart';
import 'package:healthy/docView/dermatology2.dart';
import 'package:healthy/docView/general2.dart';
import 'package:healthy/docView/nephrology.dart';
import 'package:healthy/docView/neurology2.dart';
import 'package:healthy/docView/ophtal2.dart';
import 'package:healthy/docView/orthopedy2.dart';
import 'package:healthy/docView/pediatry2.dart';
import 'package:healthy/docView/pneumology2.dart';
import 'package:healthy/screens/medecins/Pathology.dart';
import 'package:healthy/screens/medecins/cardiology.dart';
import 'package:healthy/screens/medecins/dentist.dart';
import 'package:healthy/screens/medecins/dermatology.dart';
import 'package:healthy/screens/medecins/general.dart';
import 'package:healthy/screens/medecins/neurology.dart';
import 'package:healthy/screens/medecins/ophtalmology.dart';
import 'package:healthy/screens/medecins/orthopedy.dart';
import 'package:healthy/screens/medecins/pediatrics.dart';
import 'package:healthy/screens/medecins/pneumology.dart';

class PatientProfileScreen extends StatelessWidget {
  final String patientId;

  PatientProfileScreen({required this.patientId});

  @override
  Widget build(BuildContext context) {
    
    CollectionReference users = FirebaseFirestore.instance.collection('users');
 Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(patientId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

            return Scaffold(
              appBar: AppBar(
                title: Text('${data['name'] ?? 'Unknown'} ${data['lastname'] ?? ''}'),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(data['imageLink'] ?? 'https://via.placeholder.com/150'),
                        radius: 50,
                      ),
                    ),
                    SizedBox(height: 20.sp),
                    
                    buildProfileField('Name', '${data['name'] ?? 'Unknown'} ${data['lastname'] ?? ''}'),
                    SizedBox(height: 10.sp),
                   
                    buildProfileField('Address', data['address'] ?? 'No address provided'),
                    SizedBox(height: 10.sp),
                    buildProfileField('Assurance', data['assurance'] ?? 'No assurance provided'),
                    SizedBox(height: 10.sp),
                    buildProfileField('Birthday', data['birthday'] ?? 'No birthday provided'),
                    SizedBox(height: 10.sp),
                    buildProfileField('CIN', data['cin'] ?? 'No CIN provided'),
                    SizedBox(height: 10.sp),
                    buildProfileField('City', data['city'] ?? 'No city provided'),
                    SizedBox(height: 10.sp),
                    buildProfileField('Gender', data['gender'] ?? 'No gender provided'),
                    SizedBox(height: 10.sp),
                    buildProfileField('Phone', data['phone'] ?? 'No phone number provided'),
                    SizedBox(height: 10.sp),
                    buildProfileField('Region', data['region'] ?? 'No region provided'),
                 
                  SizedBox(height: 20.sp),

                  Text("Patient's Medicale File :",style:TextStyle(fontWeight: FontWeight.bold)),
                 //container
                    Container(
                                  width: size.width,
                                  height: size.height * 0.5,
                                  decoration: const BoxDecoration(
                                  
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
                                            SizedBox(height: 10.sp,),
                                            //row1
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  height: size.height * 0.1,
                                                  width: size.width * 0.40,
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
                                                              PatientFilesScreen(patientId: patientId),
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
                                                  width: size.width * 0.40,
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
                                                           PatientFilesScreenPe(patientId: patientId),
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
                                                  width: size.width * 0.40,
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
                                                             PatientFilesScreenCar(patientId: patientId),
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
                                                  width: size.width * 0.40,
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
                                                              PatientFilesScreenDe(patientId: patientId),
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
                                                  width: size.width * 0.40,
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
                                                            PatientFilesScreenNeph(patientId: patientId),
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
                                                  width: size.width * 0.40,
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
                                                           PatientFilesScreenNeu(patientId: patientId),
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
                                                  width: size.width * 0.40,
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
                                                               PatientFilesScreenDer(patientId: patientId),
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
                                                  width: size.width * 0.40,
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
                                                             PatientFilesScreenOpht(patientId: patientId),
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
                                                  width: size.width * 0.40,
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
                                                            PatientFilesScreenPneu(patientId: patientId),
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
                                                  width: size.width * 0.40,
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
                                                             PatientFilesScreenOrth(patientId: patientId),
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
                                                  width: size.width * 0.40,
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
                                                            PatientFilesScreenOrth(patientId: patientId),
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
                                                  width: size.width * 0.40,
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
                                                            PatientFilesScreenOpht(patientId: patientId),
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
                  //  ElevatedButton(onPressed: (), child: ),  
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: Text('Document does not exist')),
            );
          }
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildProfileField(String label, String value) {
     
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 20.0),
      child: Container(
        height: 60.h,
         width: 350.w,
        decoration: BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 3,
          ),
        ],
      ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
               
            children: [
              Text(
                '$label: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}