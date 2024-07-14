import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:healthy/images/pdf/pdf.dart';
import 'package:photo_view/photo_view.dart';



import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PatientFilesScreen extends StatefulWidget {
  final String patientId;

  PatientFilesScreen({required this.patientId});

  @override
  _PatientFilesScreenState createState() => _PatientFilesScreenState();
}

class _PatientFilesScreenState extends State<PatientFilesScreen> {
  List<Reference> uploadedFiles = [];

  @override
  void initState() {
    super.initState();
    getUploadedFiles();
  }

  Future<void> getUploadedFiles() async {
    final files = await listPatientFiles(widget.patientId);
    setState(() {
      uploadedFiles = files;
    });
  }

  Future<List<Reference>> listPatientFiles(String userId) async {
    final storageRef = FirebaseStorage.instance.ref().child("$userId/medFiles/general");
    final listResult = await storageRef.listAll();
    return listResult.items;
  }

  Future<bool> uploadFileCar(File file) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child("${widget.patientId}/medFiles/general/${file.path.split('/').last}");
      await storageRef.putFile(file);
      return true;
    } catch (e) {
      print('Failed to upload file: $e');
      return false;
    }
  }

  Future<File?> getImageFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<File?> getImageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<File?> getPdfFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    return result != null ? File(result.files.single.path!) : null;
  }

  void _showDeleteDialog(BuildContext context, Reference ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete File'),
        content: const Text('Are you sure you want to delete this file?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await ref.delete();
              await getUploadedFiles();
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
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
                  child: FutureBuilder<String>(
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
                                  builder: (context) => PdfViewerPage(url: downloadUrl),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  FullScreenImage(imageUrl: downloadUrl, fileName: ref.name),
                                ),
                              );
                            }
                          },
                          child: ListTile(
                            leading: isPdf
                                ? const Icon(Icons.picture_as_pdf, size: 50, color: Colors.red)
                                : Image.network(downloadUrl, width: 50, height: 50, fit: BoxFit.cover),
                            title: Text(ref.name),
                           
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Medical File"),
      ),
      body: _buildUI(),
      
    );
  }
}





class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String fileName;

  FullScreenImage({required this.imageUrl, required this.fileName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fileName),
      ),
      body: PhotoView(
        imageProvider: NetworkImage(imageUrl),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2.0,
        enableRotation: true,
        backgroundDecoration: const BoxDecoration(
          color: Colors.white,
        ),
        loadingBuilder: (context, event) => Center(
          child: CircularProgressIndicator(
            value: event == null ? 0 : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
          ),
        ),
        errorBuilder: (context, error, stackTrace) => const Center(child: Text('Error loading image')),
      ),
    );
  }
}
