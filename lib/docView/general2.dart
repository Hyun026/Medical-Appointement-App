import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:healthy/images/pdf/pdf.dart';
import 'package:healthy/images/pdf/pdf2.dart';
import 'package:photo_view/photo_view.dart';

class PatientFilesScreen extends StatelessWidget {
  final String patientId;

  PatientFilesScreen({required this.patientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Files'),
      ),
      body: FutureBuilder<List<Reference>>(
        future: listPatientFiles(patientId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No files found.'));
          } else {
            final files = snapshot.data!;
            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                return FutureBuilder<String>(
                  future: file.getDownloadURL(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        title: Text(file.name),
                        subtitle: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return ListTile(
                        title: Text(file.name),
                        subtitle: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      final url = snapshot.data!;
                      bool isPdf = url.toLowerCase().endsWith('.pdf');

                      return ListTile(
                        leading: _getFileIcon(url, isPdf: isPdf),
                        title: Text(file.name),
                        onTap: () {
                          if (isPdf) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfViewerPage(url: url),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageViewerPage(fileUrl: url, fileName: file.name),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _getFileIcon(String url, {required bool isPdf}) {
    if (isPdf) {
      return Icon(Icons.picture_as_pdf, size: 50);
    } else {
      return CachedNetworkImage(
        imageUrl: url,
        width: 50,
        height: 50,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    }
  }

  Future<List<Reference>> listPatientFiles(String userId) async {
    final storageRef = FirebaseStorage.instance.ref().child("$userId/medFiles/general");
    final listResult = await storageRef.listAll();
    return listResult.items;
  }
}

class ImageViewerPage extends StatelessWidget {
  final String fileUrl;
  final String fileName;

  ImageViewerPage({required this.fileUrl, required this.fileName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fileName),
      ),
      body: PhotoView(
        imageProvider: NetworkImage(fileUrl),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2.0,
        enableRotation: true,
        backgroundDecoration: BoxDecoration(
          color: Colors.white,
        ),
        loadingBuilder: (context, event) => Center(
          child: CircularProgressIndicator(
            value: event == null ? 0 : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
          ),
        ),
        errorBuilder: (context, error, stackTrace) => Center(child: Text('Error loading image')),
      ),
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final String url;

  PdfViewerPage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDF().cachedFromUrl(
        url,
        placeholder: (progress) => Center(child: CircularProgressIndicator(value: progress)),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
