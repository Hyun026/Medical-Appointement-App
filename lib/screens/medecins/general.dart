import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:healthy/constants/buttons/mainB.dart';
import 'package:healthy/constants/buttons/mathPrep.dart';
import 'package:healthy/constants/colors/colors.dart';
import 'package:healthy/firebasecontrol/history/fullImage.dart';
import 'package:healthy/firebasecontrol/history/upload.dart';

class MyGeneral extends StatefulWidget {
  const MyGeneral({super.key});

  @override
  State<MyGeneral> createState() => _MyGeneralState();
}

class _MyGeneralState extends State<MyGeneral> {
  List<Reference> uploadedFiles = [];

  @override
  void initState() {
    super.initState();
    getUploadedFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                bool success = await uploadFile(selectedImage1);
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
                bool success = await uploadFile(selectedImage);
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
    return ListView.builder(
        itemCount: uploadedFiles.length,
        itemBuilder: (context, index) {
          Reference ref = uploadedFiles[index];
          return FutureBuilder(
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
                    ),
                  );
                }
                return Container(
                  child: Text('Something is wrong'),
                );
              });
        });
  }

  void getUploadedFiles() async {
    List<Reference>? result = await getUsersUploadedFiles();
    if (result != null) {
      setState(() {
        uploadedFiles = result;
      });
    }
  }
}
