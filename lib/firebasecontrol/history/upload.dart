import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:gallery_picker/models/media_file.dart';
import 'package:image_picker/image_picker.dart';

//select image from gallery
Future<File?> getImageFromGallery(BuildContext context) async {
  try {
    List<MediaFile>? singleMedia =
        await GalleryPicker.pickMedia(context: context, singleMedia: true);
    return singleMedia?.first.getFile();
  } catch (e) {
    print(e);
  }
}

//select image from camera
Future<File?> getImageFromCamera(BuildContext context) async {
  try {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

// upload to firestorage
Future<bool> uploadFile(File file) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final fileName = file.path.split("/").last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final uploadRef = storageRef.child("$userId/medFiles/general/$timestamp-$fileName");
    final metadata = SettableMetadata(
      customMetadata: {
        'uploadDate': DateTime.now().toIso8601String(),
      },
    );
     
   await uploadRef.putFile(file, metadata);
  
    return true;
  } catch (e) {
    print('Error uploading file: $e');
    return false;
  }
}


//retrieve from firestorage
Future<List<Reference>?> getUsersUploadedFiles() async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final uploadsRefs = storageRef.child("$userId/medFiles/general/");
    final uploads = await uploadsRefs.listAll();

    return uploads.items;
  } catch (e) {
    print('Error fetching uploaded files: $e');
    return null; // Handle error gracefully in your UI
  }
}
