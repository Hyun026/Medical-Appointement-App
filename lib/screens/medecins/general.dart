import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:healthy/constants/buttons/mainB.dart';
import 'package:healthy/constants/buttons/mathPrep.dart';
import 'package:healthy/constants/colors/colors.dart';
import 'package:healthy/firebasecontrol/history/fullImage.dart';
import 'package:healthy/firebasecontrol/history/upload.dart';
import 'package:healthy/images/pdf/pdf.dart';


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
    File? pickedFile = await getPdfFile();
    if (pickedFile != null) {
      bool uploadSuccess = await uploadFile(pickedFile);
      if (uploadSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File uploaded successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload file.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected.')),
      );
    }
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
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FutureBuilder(
                      future: ref.getDownloadURL(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final downloadUrl = snapshot.data!;
                          final isPdf = ref.name.toLowerCase().endsWith('.pdf');
                          return GestureDetector(
                            onTap: () {
                              if (isPdf) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PdfViewerPage(url: downloadUrl, pdfPath: null),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenImage(imageUrl: downloadUrl),
                                  ),
                                );
                              }
                            },
                            child: ListTile(
                              leading: isPdf
                                  ? Icon(Icons.picture_as_pdf, size: 50, color: Colors.red)
                                  : Image.network(downloadUrl, width: 50, height: 50, fit: BoxFit.cover),
                              title: Text(ref.name),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Container(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
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
    List<Reference>? result = await getUsersUploadedFiles();
    if (result != null) {
      setState(() {
        uploadedFiles = result;
      });
    }
  }
}
