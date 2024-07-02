import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constants/colors/colors.dart';
import 'package:healthy/docHome.dart';
import 'package:healthy/screens/signup/signup2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorCreate extends StatefulWidget {
  const DoctorCreate({super.key});

  @override
  State<DoctorCreate> createState() => _DoctorCreateState();
}

class _DoctorCreateState extends State<DoctorCreate> {
   TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController fieldController = TextEditingController();
  TextEditingController cabinetController = TextEditingController();

  String? valueChoose;
  List<String> listItem = ["General", "Pediatrician", "Cardiologist", "Endocrinologist", "Nephrologist","Neurologist","Dermatologist","Ophthalmologist","Pneumologie", "Orthipedy"];
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/back.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.5),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'Create Your Profile',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Name',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              _buildInputField(
                                controller: nameController,
                                hintText: "First name",
                                obscureText: false,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Lastname',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              _buildInputField(
                                controller: lastnameController,
                                hintText: "Last name",
                                obscureText: false,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Field',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                               Container(
                decoration: BoxDecoration(
                  color: Colors.white,
              border: Border.all(color: MyColors.borderSideColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
                 child: DropdownButton<String>(
                   hint: const Padding(
                     padding: EdgeInsets.all(8.0),
                     child: Align(
                       alignment: Alignment.centerLeft,
                       child: Text(
                         'Field',
                         style: TextStyle(
                           color: MyColors.hintTextColor,
                           fontSize: 14,
                           fontWeight: FontWeight.w600,
                         ),
                       ),
                     ),
                   ),
                   isExpanded: true,
                   underline: SizedBox(),
                   
                   icon: const Icon(
                     Icons.arrow_drop_down,
                     color: MyColors.primaryColor,
                   ),
                   value: valueChoose,
                   onChanged:(newValue) {
                           setState(() {
                             valueChoose = newValue!;
                             fieldController.text = newValue;
                           });
                         },
                       
                   items: listItem.map((valueItem) {
                     return DropdownMenuItem<String>(
                       value: valueItem,
                       child: Text(valueItem),
                     );
                   }).toList(),
                 ),
               ),
                              const SizedBox(height: 20),
                              const Text(
                                'Cabinet Address',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              _buildInputField(
                                controller: cabinetController,
                                hintText: "Enter address",
                                obscureText: false,
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 50),
                            backgroundColor: MyColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (nameController.text.isEmpty ||
                                lastnameController.text.isEmpty ||
                                fieldController.text.isEmpty ||
                                cabinetController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('All fields are required'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              String downloadUrl = await uploadImage('assets/images/user/user-svgrepo-com.svg');
                              Map<String, dynamic> dataToSave = {
                                'user': user!.uid,
                                'name': nameController.text,
                                'lastname': lastnameController.text,
                                'address': cabinetController.text,
                                'field': fieldController.text,
                                'imageLink': downloadUrl,
                              };

                              await FirebaseFirestore.instance.collection("doctors").doc(user!.uid).set(dataToSave);

                              final prefs = await SharedPreferences.getInstance();
                              prefs.setString("imageLink", downloadUrl);

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyHomeDoc()),
                              );
                            }
                          },
                          child: const Text(
                            'Add',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(height: 50.h,)
                    ],
                  ),
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
Widget _buildInputField({
  required TextEditingController controller,
  required String hintText,
  required bool obscureText,
}) {
  
  return SizedBox(
    width: 350.w,
    height: 50.h,
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
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
