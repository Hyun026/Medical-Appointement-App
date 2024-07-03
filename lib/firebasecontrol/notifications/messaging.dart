import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> handleBackgroundMessage(RemoteMessage message)async{
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('Payload: ${message.data}');

}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  String? _fcmToken;

  static final FirebaseApi _instance = FirebaseApi._internal();

  FirebaseApi._internal();

  factory FirebaseApi() {
    return _instance;
  }

  // Method to initialize notifications and retrieve FCM token
  Future<void> initNotifications() async {

    await _firebaseMessaging.requestPermission();
    _fcmToken = await _firebaseMessaging.getToken();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<String?> getFCMToken() async {
    if (_fcmToken == null) {
      _fcmToken = await _firebaseMessaging.getToken();
    }
    return _fcmToken;
  }
}
