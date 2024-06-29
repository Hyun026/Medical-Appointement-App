import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Uint8List?> pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No images selected');
  return null;
}

class StoreData {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    try {
      Reference ref = _storage.ref().child(childName).child(DateTime.now().toString());
      UploadTask uploadTask = ref.putData(file);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<String> saveData({required Uint8List file}) async {
    String response = "Some Error Occurred";

    try {
      // Upload the image and get its URL
      String imageUrl = await uploadImageToStorage('ProfileImage', file);

      User? user = _auth.currentUser;

      if (user != null) {
        DocumentReference userDocRef = _firestore.collection('users').doc(user.uid);
        DocumentSnapshot userDocSnapshot = await userDocRef.get();

        if (userDocSnapshot.exists) {
          await userDocRef.update({
            'imageLink': imageUrl,
          });
          response = 'success';
          final prefs = await SharedPreferences.getInstance();
        await prefs.setString("imageLink", imageUrl);
        } else {
          response = 'No document found for current user.';
        }
      } else {
        response = 'User not authenticated.';
      }
    } catch (err) {
      print('Error: $err');
      response = 'Failed to save data: $err';
    }

    return response;
  }
}