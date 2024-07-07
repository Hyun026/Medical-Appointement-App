import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:healthy/constants/buttons/mainB.dart';
import 'package:healthy/constants/buttons/mathPrep.dart';
import 'package:healthy/constants/colors/colors.dart';
import 'package:healthy/firebasecontrol/history/fullImage.dart';
import 'package:healthy/firebasecontrol/history/upload.dart';

class Dentist extends StatefulWidget {
  const Dentist({super.key});

  @override
  State<Dentist> createState() => _DentistState();
}

class _DentistState extends State<Dentist> {
 List<Reference> uploadedFiles = [];

  @override
  void initState() {
    super.initState();
    getUploadedFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Medical File"),
      ),
      body: _buildUI(),
      floatingActionButton: QuickActionMenu(
        onTap: () {},
        icon: Icons.menu,
        backgroundColor: MyColors.primaryColor,
        child: Container(),
        actions: [
          QuickAction(
            icon: Icons.camera,
            onTap: () async {
              File? selectedImage1 = await getImageFromCamera(context);
              if (selectedImage1 != null) {
                bool success = await uploadFileDe(selectedImage1);
                if (success) {
                  getUploadedFiles();
                }
              }
            },
          ),
          QuickAction(
            icon: Icons.collections,
            onTap: () async {
              File? selectedImage = await getImageFromGallery(context);
              if (selectedImage != null) {
                bool success = await uploadFileDe(selectedImage);
                if (success) {
                  getUploadedFiles();
                }
              }
            },
          ),
          QuickAction(
            icon: Icons.description,
            onTap: () async {
              print('Info tapped');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUI() {
    if (uploadedFiles.isEmpty) {
      return const Center(
        child: Text('no Files  Uploaded'),
      );
    }
     return Padding(
  padding: EdgeInsets.all(20),
  child: ListView.builder(
    itemCount: uploadedFiles.length,
    itemBuilder: (context, index) {
      Reference ref = uploadedFiles[index];
      DateTime fileDateTime = DateTime.now(); 
      return Column(
        children: [
          IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.Container,
                borderRadius: BorderRadius.circular(20),
              ),
              child: FutureBuilder(
                future: ref.getDownloadURL(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FullScreenImage(imageUrl: snapshot.data!),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Image.network(snapshot.data!),
                      title: Text(ref.name),
                      ),
                    );
                  }
                  return Container(
                    child: Text('Something is wrong'),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Uploaded on: ${fileDateTime.toLocal()}',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 20),
        ],
      );
    },
  ),
);

  }

  void getUploadedFiles() async {
    List<Reference>? result = await getUsersUploadedFilesDe();
    if (result != null) {
      setState(() {
        uploadedFiles = result;
      });
    }
  }
}
