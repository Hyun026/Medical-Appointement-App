import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:healthy/constants/buttons/mainB.dart';
import 'package:healthy/constants/buttons/mathPrep.dart';
import 'package:healthy/constants/colors/colors.dart';
import 'package:healthy/firebasecontrol/history/fullImage.dart';
import 'package:healthy/firebasecontrol/history/upload.dart';
import 'package:healthy/images/pdf/pdf.dart';

class MyDermatology extends StatefulWidget {
  const MyDermatology({super.key});

  @override
  State<MyDermatology> createState() => _MyDermatologyState();
}

class _MyDermatologyState extends State<MyDermatology> {
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
        title: const Text("Your Medical File"),
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
                bool success = await uploadFileDer(selectedImage1);
                if (success) {
                  await getUploadedFiles();
                }
              }
            },
          ),
          QuickAction(
            icon: Icons.collections,
            onTap: () async {
              File? selectedImage = await getImageFromGallery(context);
              if (selectedImage != null) {
                bool success = await uploadFileDer(selectedImage);
                if (success) {
                  await getUploadedFiles();
                }
              }
            },
          ),
          QuickAction(
            icon: Icons.description,
            onTap: () async {
              File? pickedFile = await getPdfFile();
              if (pickedFile != null) {
                bool uploadSuccess = await uploadFileDer(pickedFile);
                if (uploadSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('File uploaded successfully!')),
                  );
                  await getUploadedFiles();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to upload file.')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No file selected.')),
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
        child: Text('No Files Uploaded'),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(20),
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Container(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
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
                                ? const Icon(Icons.picture_as_pdf, size: 50, color: Colors.red)
                                : Image.network(downloadUrl, width: 50, height: 50, fit: BoxFit.cover),
                            title: Text(ref.name),
                            trailing: GestureDetector(
                              onTap: () {
                                _showDeleteDialog(context, ref);
                              },
                              child: const Icon(Icons.delete, color: MyColors.primaryColor),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Uploaded on: ${fileDateTime.toLocal()}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  Future<void> getUploadedFiles() async {
    List<Reference>? result = await getUsersUploadedFilesDer();
    if (result != null) {
      setState(() {
        uploadedFiles = result;
      });
    }
  }
  
 void _showDeleteDialog(BuildContext context, Reference ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this file?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                await _deleteFile(context, ref, uploadedFiles, () {
                  setState(() {});
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
 Future<void> _deleteFile(BuildContext context, Reference ref, List<Reference> uploadedFiles, Function updateUI) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not authenticated or user ID not available.');
      }

      if (!ref.fullPath.contains(userId)) {
        throw Exception('File does not belong to the current user.');
      }

      await ref.delete();

      uploadedFiles.remove(ref);

      updateUI();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File deleted successfully'),
        ),
      );
    } catch (e) {
      print('Error deleting file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete file: $e'),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: () {
              _deleteFile(context, ref, uploadedFiles, updateUI);
            },
          ),
        ),
      );
    }
  }


