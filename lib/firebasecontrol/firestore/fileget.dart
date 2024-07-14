import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:healthy/constants/colors/colors.dart';



class GetUser extends StatelessWidget {
  final String documentId;

  const GetUser({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text('CIN', style: TextStyle(color: Colors.black, fontSize: 15.sp)),
                  SizedBox(height: 12.h),
                  _costumField(text: '${data['cin']}'),
                  
                  SizedBox(height: 20.h),
                  Text('Gender', style: TextStyle(color: MyColors.hintTextColor, fontSize: 15.sp)),
                  SizedBox(height: 12.h),
                  _costumField(text: '${data['gender']}'),
                  
                  SizedBox(height: 20.h),
                  Text('Birthday', style: TextStyle(color: Colors.black, fontSize: 15.sp)),
                  SizedBox(height: 12.h),
                  _costumField(text: '${data['birthday']}'),
                  
                  SizedBox(height: 20.h),
                  Text('Phone Number', style: TextStyle(color: Colors.black, fontSize: 15.sp)),
                  SizedBox(height: 12.h),
                  _costumField(text: '${data['phone']}'),
                  
                  SizedBox(height: 20.h),
                  Text('Address', style: TextStyle(color: Colors.black, fontSize: 15.sp)),
                  SizedBox(height: 12.h),
                  _costumField(text: '${data['address']}'),
                  
                  SizedBox(height: 20.h),
                  Text('Region', style: TextStyle(color: Colors.black, fontSize: 15.sp)),
                  SizedBox(height: 12.h),
                  _costumField(text: '${data['region']}'),
                  
                  SizedBox(height: 20.h),
                  Text('Assurance', style: TextStyle(color: Colors.black, fontSize: 15.sp)),
                  SizedBox(height: 12.h),
                  _costumField(text: '${data['assurance']}'),
                  
                  SizedBox(height: 20.h),
               
                ],
              ),
            );
          } else {
            return Text('Document does not exist');
          }
        }
        return Text('Loading..');
      },
    );
  }
}

Widget _costumField({required String text}) {
  return Container(
    width: 300.w,
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    decoration: BoxDecoration(
      color: MyColors.Container,
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 22.sp,
        color: MyColors.hintTextColor,
      ),
    ),
  );
}