import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constants/colors/colors.dart';

class EditDocForm extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String documentId;

  EditDocForm({required this.userData, required this.documentId});

  @override
  _EditDocFormState createState() => _EditDocFormState();
}

class _EditDocFormState extends State<EditDocForm> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _cabinetController;
  late TextEditingController _phoneController;



  @override
  void initState() {
    super.initState();

    _phoneController = TextEditingController(text: widget.userData['phone']);
    _cabinetController = TextEditingController(text: widget.userData['adress']);
   

  }

  @override
  void dispose() {
    _phoneController.dispose();
    _cabinetController.dispose();
   
    super.dispose();
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('doctors').doc(widget.documentId).update({

        'phone': _phoneController.text,
        'adress': _cabinetController.text,
       

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
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Personal Info'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Phone Number'),
              SizedBox(height: 12.h,),
              _buildInputField(controller: _phoneController, hintText: 'Phone Number'),
              SizedBox(height: 12.h,),
              Text('Cabinet'),
              SizedBox(height: 12.h,),
              _buildInputField(controller: _cabinetController, hintText: 'Address'),
              SizedBox(height: 12.h,),
              
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
          child: Text('Save'),
        ),
        ElevatedButton(
          
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
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

