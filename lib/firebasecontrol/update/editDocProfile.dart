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
  
  String ? valueChoose4;
  List<String> listItem4 =[
    "Tanger","Tetouan","Casablanca","Rabat","Hoceima","Oujda","Agadir","Fes","Marrakech"
  ];

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



    final _formKey = GlobalKey<FormState>();
    TextEditingController addressController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController regionController = TextEditingController();



  @override
  void dispose() {
   phoneNumberController.dispose();
    addressController.dispose();
    cityController.dispose();
    regionController.dispose();
   
    super.dispose();
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
       User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('doctors').doc(user!.uid).update({

        'phone': phoneNumberController.text,
        'address': addressController.text,
        'city':cityController.text,
        'region':regionController.text,
       

      });

      Navigator.pop(context);  
    }
  }
    return AlertDialog(
      title: const Text('Edit Your Data :', style: TextStyle(fontWeight: FontWeight.w600),),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const Text('Address :', style: TextStyle(fontSize: 18),),
                SizedBox(height: 10.sp,),
               _buildInputField(controller: addressController, hintText: 'Address',),
                SizedBox(height: 20.sp,),
                const Text('Phone Number :',  style: TextStyle(fontSize: 18),),
                SizedBox(height: 10.sp,),
                _buildInputField(controller: phoneNumberController, hintText: 'Phone Number'),
                SizedBox(height: 20.sp,),
                const Text('City :',  style: TextStyle(fontSize: 18),),
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
                   value: valueChoose4,
                   onChanged:(newValue) {
                           setState(() {
                             valueChoose4 = newValue!;
                             cityController.text = newValue;
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


                SizedBox(height: 20.sp,),
                const Text('Region :',  style: TextStyle(fontSize: 18),),
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
                             regionController.text = newValue;
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
                
                
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); 
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed:_updateUser,
          child: const Text('Save'),
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
