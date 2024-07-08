import 'dart:io';

import 'package:file_picker/file_picker.dart';
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

//select a pdf file 
Future<File?> getPdfFile() async {
  try {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  } catch (e) {
    print('Error picking PDF file: $e');
    return null;
  }
}

// general


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
    return null; 
  }
}


//cardiology

// upload to firestorage
Future<bool> uploadFileCar(File file) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final fileName = file.path.split("/").last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final uploadRef = storageRef.child("$userId/medFiles/cardiology/$timestamp-$fileName");
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
Future<List<Reference>?> getUsersUploadedFilesCar() async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final uploadsRefs = storageRef.child("$userId/medFiles/cardiology/");
    final uploads = await uploadsRefs.listAll();

    return uploads.items;
  } catch (e) {
    print('Error fetching uploaded files: $e');
    return null; 
  }
}



//dentist  not yet 

// upload to firestorage
Future<bool> uploadFileDe(File file) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final fileName = file.path.split("/").last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final uploadRef = storageRef.child("$userId/medFiles/dentist/$timestamp-$fileName");
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
Future<List<Reference>?> getUsersUploadedFilesDe() async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final uploadsRefs = storageRef.child("$userId/medFiles/dentist/");
    final uploads = await uploadsRefs.listAll();

    return uploads.items;
  } catch (e) {
    print('Error fetching uploaded files: $e');
    return null; 
  }
}




//dermatology 

// upload to firestorage
Future<bool> uploadFileDer(File file) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final fileName = file.path.split("/").last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final uploadRef = storageRef.child("$userId/medFiles/dermatology/$timestamp-$fileName");
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
Future<List<Reference>?> getUsersUploadedFilesDer() async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final uploadsRefs = storageRef.child("$userId/medFiles/dermatology/");
    final uploads = await uploadsRefs.listAll();

    return uploads.items;
  } catch (e) {
    print('Error fetching uploaded files: $e');
    return null; 
  }
}


//endocrinology

// upload to firestorage
Future<bool> uploadFileEndoc(File file) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final fileName = file.path.split("/").last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final uploadRef = storageRef.child("$userId/medFiles/endocrinology/$timestamp-$fileName");
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
Future<List<Reference>?> getUsersUploadedFilesEndoc() async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final uploadsRefs = storageRef.child("$userId/medFiles/endocrinology/");
    final uploads = await uploadsRefs.listAll();

    return uploads.items;
  } catch (e) {
    print('Error fetching uploaded files: $e');
    return null; 
  }
}

//nephrology

// upload to firestorage
Future<bool> uploadFileNeph(File file) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final fileName = file.path.split("/").last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final uploadRef = storageRef.child("$userId/medFiles/nephrology/$timestamp-$fileName");
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
Future<List<Reference>?> getUsersUploadedFilesNeph() async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final uploadsRefs = storageRef.child("$userId/medFiles/nephrology/");
    final uploads = await uploadsRefs.listAll();

    return uploads.items;
  } catch (e) {
    print('Error fetching uploaded files: $e');
    return null; 
  }
}

//neurology

// upload to firestorage
Future<bool> uploadFileNeu(File file) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final fileName = file.path.split("/").last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final uploadRef = storageRef.child("$userId/medFiles/neurology/$timestamp-$fileName");
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
Future<List<Reference>?> getUsersUploadedFilesNeu() async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final uploadsRefs = storageRef.child("$userId/medFiles/neurology/");
    final uploads = await uploadsRefs.listAll();

    return uploads.items;
  } catch (e) {
    print('Error fetching uploaded files: $e');
    return null; 
  }
}

//ophtalmology

// upload to firestorage
Future<bool> uploadFileOph(File file) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final fileName = file.path.split("/").last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final uploadRef = storageRef.child("$userId/medFiles/ophtalmology/$timestamp-$fileName");
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
Future<List<Reference>?> getUsersUploadedFilesOph() async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final uploadsRefs = storageRef.child("$userId/medFiles/ophtalmology/");
    final uploads = await uploadsRefs.listAll();

    return uploads.items;
  } catch (e) {
    print('Error fetching uploaded files: $e');
    return null; 
  }
}

//orthopedy

// upload to firestorage
Future<bool> uploadFileOrth(File file) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final fileName = file.path.split("/").last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final uploadRef = storageRef.child("$userId/medFiles/orthopedy/$timestamp-$fileName");
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
Future<List<Reference>?> getUsersUploadedFilesOrth() async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final uploadsRefs = storageRef.child("$userId/medFiles/orthopedy/");
    final uploads = await uploadsRefs.listAll();

    return uploads.items;
  } catch (e) {
    print('Error fetching uploaded files: $e');
    return null; 
  }
}

//pathology

// upload to firestorage
Future<bool> uploadFilePath(File file) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final fileName = file.path.split("/").last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final uploadRef = storageRef.child("$userId/medFiles/pathology/$timestamp-$fileName");
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
Future<List<Reference>?> getUsersUploadedFilesPath() async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final uploadsRefs = storageRef.child("$userId/medFiles/pathology/");
    final uploads = await uploadsRefs.listAll();

    return uploads.items;
  } catch (e) {
    print('Error fetching uploaded files: $e');
    return null; 
  }
}

//pediatricts

// upload to firestorage
Future<bool> uploadFilePedia(File file) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final fileName = file.path.split("/").last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final uploadRef = storageRef.child("$userId/medFiles/pediatricts/$timestamp-$fileName");
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
Future<List<Reference>?> getUsersUploadedFilesPedia() async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final uploadsRefs = storageRef.child("$userId/medFiles/pediatricts/");
    final uploads = await uploadsRefs.listAll();

    return uploads.items;
  } catch (e) {
    print('Error fetching uploaded files: $e');
    return null; 
  }
}

//pneumology

// upload to firestorage
Future<bool> uploadFilePneu(File file) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final fileName = file.path.split("/").last;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final uploadRef = storageRef.child("$userId/medFiles/pneumology/$timestamp-$fileName");
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
Future<List<Reference>?> getUsersUploadedFilesPneu() async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated or user ID not available.');
    }

    final storageRef = FirebaseStorage.instance.ref();
    final uploadsRefs = storageRef.child("$userId/medFiles/pneumology/");
    final uploads = await uploadsRefs.listAll();

    return uploads.items;
  } catch (e) {
    print('Error fetching uploaded files: $e');
    return null; 
  }
}

