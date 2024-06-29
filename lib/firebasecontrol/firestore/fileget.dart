import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constants/colors/colors.dart';


class GetUser extends StatelessWidget {
  final String documentId;
  
  const GetUser({required this.documentId});

  @override
  Widget build(BuildContext context) {

   
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(height: 20.h,),
                 Text('CIN' , style: TextStyle(color: MyColors.hintTextColor,fontSize: 15.sp),),
                 
                   _costumField( text : '${data['cin']}'),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(height: 20.h,),
                  Text('Gender' , style: TextStyle(color: MyColors.hintTextColor,fontSize: 15.sp),),
                    _costumField( text : '${data['gender']}'),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(height: 20.h,),
                  Text('Birthday' , style: TextStyle(color: MyColors.hintTextColor,fontSize: 15.sp),),
                    _costumField( text : '${data['birthday']}'),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(height: 20.h,),
                  Text('Phone Number' , style: TextStyle(color: MyColors.hintTextColor,fontSize: 15.sp),),
                    _costumField( text : '${data['phone']}'),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(height: 20.h,),
                  Text('Adress' , style: TextStyle(color: MyColors.hintTextColor,fontSize: 15.sp),),
                   _costumField( text : '${data['adress']}'),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(height: 20.h,),
                  Text('Region' , style: TextStyle(color: MyColors.hintTextColor,fontSize: 15.sp),),
                   _costumField( text : '${data['region']}'),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(height: 20.h,),
                  Text('Assurance' , style: TextStyle(color: MyColors.hintTextColor,fontSize: 15.sp),),
                    _costumField( text : '${data['assurance']}'),
                Container(
                    //line
                    height: 1.0.h,
                     width: size.width*1,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(height: 20.h,),
                   
                   ElevatedButton(onPressed: () {},
                   style: ElevatedButton.styleFrom(
                        minimumSize: Size(300.w, 50.h),
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
                    ) ),
                      
              ],
                          ),
            );
           }else {
            return Text('Document does not exist');
           }
        }
        return Text('loading..');
  }
      
    );
  }
}

Widget _costumField({required String text}) {
    return Text(text);
  }

