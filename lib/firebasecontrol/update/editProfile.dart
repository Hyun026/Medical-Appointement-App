import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constants/colors/colors.dart';

class EditUserForm extends StatefulWidget {
 
  @override
  _EditUserFormState createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {
  final _formKey = GlobalKey<FormState>();
  
   TextEditingController _phoneController = TextEditingController();
   TextEditingController _addressController = TextEditingController();
   TextEditingController _regionController = TextEditingController();
   TextEditingController _cityController = TextEditingController();


  

  @override
  void dispose() {
    _phoneController.dispose();
    _addressController.dispose();
    _regionController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
       User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({

        'phone': _phoneController.text,
        'address': _addressController.text,
        'region': _regionController.text,
        'city':_cityController.text,

      });

      Navigator.pop(context);  
    }
  }

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

  String ? valueChoose4;
  List<String> listItem4 =[
    "Tanger","Tetouan","Casablanca","Rabat","Hoceima","Oujda","Agadir","Fes","Marrakech"
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Personal Info'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Phone Number :'),
              SizedBox(height: 12.h,),
              _buildInputField(controller: _phoneController, hintText: 'Phone Number'),
              SizedBox(height: 12.h,),
              const Text('Address :'),
              SizedBox(height: 12.h,),
              _buildInputField(controller: _addressController, hintText: 'Address'),
              SizedBox(height: 12.h,),
              const Text('Region :'),
              SizedBox(height: 12.h,),
               Container(
                decoration: BoxDecoration(
                  color: Colors.white,
              border: Border.all(color: MyColors.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
                 child: DropdownButton<String>(
                   hint: const Padding(
                     padding: EdgeInsets.all(8.0),
                     child: Align(
                       alignment: Alignment.centerLeft,
                       child: Text(
                         'Region',
                         style: TextStyle(
                           color: MyColors.hintTextColor,
                           fontSize: 14,
                           fontWeight: FontWeight.w600,
                         ),
                       ),
                     ),
                   ),
                   isExpanded: true,
                   underline: const SizedBox(),
                   
                   icon: const Icon(
                     Icons.arrow_drop_down,
                     color: MyColors.primaryColor,
                   ),
                   value: valueChoose3,
                   onChanged:(newValue) {
                           setState(() {
                             valueChoose3 = newValue!;
                             _regionController.text = newValue;
                           });
                         },
                       
                   items: listItem3.map((valueItem) {
                     return DropdownMenuItem<String>(
                       value: valueItem,
                       child: Text(valueItem),
                     );
                   }).toList(),
                 ),
               ),
               SizedBox(height: 12.h,),
              const Text('City :'),
               SizedBox(height: 12.h,),
               Container(
                decoration: BoxDecoration(
                  color: Colors.white,
              border: Border.all(color: MyColors.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
                 child: DropdownButton<String>(
                   hint: const Padding(
                     padding: EdgeInsets.all(8.0),
                     child: Align(
                       alignment: Alignment.centerLeft,
                       child: Text(
                         'City',
                         style: TextStyle(
                           color: MyColors.hintTextColor,
                           fontSize: 14,
                           fontWeight: FontWeight.w600,
                         ),
                       ),
                     ),
                   ),
                   isExpanded: true,
                   underline: const SizedBox(),
                   
                   icon: const Icon(
                     Icons.arrow_drop_down,
                     color: MyColors.primaryColor,
                   ),
                   value: valueChoose4,
                   onChanged:(newValue) {
                           setState(() {
                             valueChoose4 = newValue!;
                             _cityController.text = newValue;
                           });
                         },
                       
                   items: listItem4.map((valueItem) {
                     return DropdownMenuItem<String>(
                       value: valueItem,
                       child: Text(valueItem),
                     );
                   }).toList(),
                 ),
               ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          style:ElevatedButton.styleFrom(
            backgroundColor: MyColors.button1
          ),
          onPressed: _updateUser,
          child: const Text('Save'),
        ),
        ElevatedButton(
          
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
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

