

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message)async{
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('Payload: ${message.data}');

}


class FirebaseApi1{
    final _firebaseMessaging = FirebaseMessaging.instance;
    Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
   final _fcmToken = await _firebaseMessaging.getToken();

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
  
  void handleMessage(RemoteMessage? message){
    if(message == null) return;
    //navigate to new screen when clicked on notification
  }
 
}