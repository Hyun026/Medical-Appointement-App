import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Notification {

  Future<String> getCurrentUserName() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('doctors').doc(user.uid).get();
    if (userDoc.exists) {
      return userDoc['name'] ?? 'Unknown User'; 
    }
  }
  return 'Unknown User';
}

Future<String> getCurrentUserLastName() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('doctors').doc(user.uid).get();
    if (userDoc.exists) {
      return userDoc['lastname'] ?? 'Unknown User'; 
    }
  }
  return 'Unknown User';
}

Future<String> getCurrentUserImage() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('doctors').doc(user.uid).get();
    if (userDoc.exists) {
      return userDoc['imageLink'] ?? 'Unknown User'; 
    }
  }
  return 'Unknown User';
}

Future<String> getCurrentPatienID() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('appointments').doc(user.uid).get();
    if (userDoc.exists) {
      return userDoc['user'] ?? 'Unknown User'; 
    }
  }
  return 'Unknown User';
}
  
  //trigger update notification
  triggerNotification()async{
 String docName = await getCurrentUserName();
  String docLastName = await getCurrentUserLastName();
  String docImage = await getCurrentUserImage();
  String userID = await getCurrentPatienID();

  // Prepare data to save
  Map<String, dynamic> dataToSave2 = {
    'nameD': docName,
    'lastNameD': docLastName,
    'ImageD': docImage,
    'userID': userID,
    'created_at': FieldValue.serverTimestamp(),
    'message': 'Has accepted Your Appointment Booking'
  };

  // Save to Firestore
  await FirebaseFirestore.instance.collection("notificationsforUser").add(dataToSave2);

  // Trigger the notification
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'Healthy', 
      title: 'Appointment Accepted',
      body: 'Dr. $docName $docLastName has Updated your appointment booking.',
      bigPicture: docImage,
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}
  
}