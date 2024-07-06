import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constants/colors/colors.dart';



class EditDocForm extends StatefulWidget {
  @override
  State<EditDocForm> createState() => _EditDocFormState();
}

class _EditDocFormState extends State<EditDocForm> {
  @override
  Widget build(BuildContext context) {
  


    final _formKey = GlobalKey<FormState>();
    TextEditingController addressController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();



  @override
  void dispose() {
   phoneNumberController.dispose();
    addressController.dispose();
   
    super.dispose();
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
       User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('doctors').doc(user!.uid).update({

        'phone': phoneNumberController.text,
        'address': addressController.text,
       

      });

      Navigator.pop(context);  
    }
  }
    return AlertDialog(
      title: Text('Edit Your Data'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text('address:'),
              SizedBox(height: 10.sp,),
             _buildInputField(controller: addressController, hintText: 'Address',),
              SizedBox(height: 20.sp,),
              Text('Phone Number'),
              SizedBox(height: 10.sp,),
              _buildInputField(controller: phoneNumberController, hintText: 'Phone Number'),
              
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); 
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed:_updateUser,
          child: Text('Save'),
        ),
      ],
    );
  }
}

Widget _buildInputField({
  required TextEditingController controller,
  required String hintText,

}) {
  
  return SizedBox(
    width: 300.w,
    height: 50.h,
    child: TextFormField(
      controller: controller,
      
      decoration: InputDecoration(
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
