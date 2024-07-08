import 'dart:io';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';


class PdfViewerPage extends StatelessWidget {
  final String? pdfPath;
  final String url;


 PdfViewerPage({this.pdfPath, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: FutureBuilder<PDFDocument>(
        future: _loadPdf(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load PDF: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return PDFViewer(
              document: snapshot.data!,
              zoomSteps: 1,
            );
          } else {
            return Center(child: Text('Unknown error occurred'));
          }
        },
      ),
    );
  }

  Future<PDFDocument> _loadPdf() async {
  try {
    if (pdfPath != null) {
      final file = File(pdfPath!);
      return await PDFDocument.fromFile(file);
    } else {
      final document = await PDFDocument.fromURL(url);
      return document;
    }
  } catch (e) {
    throw Exception('Failed to load PDF: $e');
  }
}

}
