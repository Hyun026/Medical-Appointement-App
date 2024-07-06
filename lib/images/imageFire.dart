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

 Future<String> uploadImageToStorage(String userId, String fileName, Uint8List file) async {
  try {
    final String timestamp = DateTime.now().toString();
    final Reference ref = _storage.ref().child("$userId/ProfilePicture/$timestamp-$fileName");
    final UploadTask uploadTask = ref.putData(file);

    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    throw Exception('Failed to upload image: $e');
  }
}


 Future<String> saveData({required Uint8List file, required String fileName}) async {
  String response = "Some Error Occurred";

  try {
    User? user = _auth.currentUser;

    if (user != null) {
    
      String imageUrl = await uploadImageToStorage(user.uid, fileName, file);
      print('Image uploaded. URL: $imageUrl');

      DocumentReference userDocRef = _firestore.collection('users').doc(user.uid);
      DocumentSnapshot userDocSnapshot = await userDocRef.get();

      if (userDocSnapshot.exists) {
    
        await userDocRef.update({
          'imageLink': imageUrl,
        });

        
        QuerySnapshot appointmentsSnapshot = await _firestore
            .collection('appointments')
            .where('user', isEqualTo: user.uid)
            .get();

        
        for (var doc in appointmentsSnapshot.docs) {
          await doc.reference.update({
            'userImage': imageUrl,
          });
        }

        response = 'success';
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("imageLink", imageUrl);
        print('SharedPreferences updated.');
      } else {
        response = 'No document found for current user.';
        print(response);
      }
    } else {
      response = 'User not authenticated.';
      print(response);
    }
  } catch (err) {
    print('Error: $err');
    response = 'Failed to save data: $err';
  }

  return response;
}



  Future<String> saveData2({required Uint8List file, required String fileName}) async {
  String response = "Some Error Occurred";

  try {
    User? user = _auth.currentUser;

    if (user != null) {
      // Upload the image and get its URL
      String imageUrl = await uploadImageToStorage(user.uid, fileName, file);

      DocumentReference userDocRef = _firestore.collection('doctors').doc(user.uid);
      DocumentSnapshot userDocSnapshot = await userDocRef.get();

      if (userDocSnapshot.exists) {
       
        await userDocRef.update({
          'imageLink': imageUrl,
        });

        
        QuerySnapshot appointmentsSnapshot = await _firestore
            .collection('appointments')
            .where('Doctor', isEqualTo: user.uid)
            .get();

        
        for (var doc in appointmentsSnapshot.docs) {
          await doc.reference.update({
            'imageLink': imageUrl,
          });
        }

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