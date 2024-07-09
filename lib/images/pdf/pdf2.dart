import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'dart:io';

class PdfViewerPage2 extends StatelessWidget {
  final String? pdfPath;
  final String url;

  PdfViewerPage2({this.pdfPath, required this.url});

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