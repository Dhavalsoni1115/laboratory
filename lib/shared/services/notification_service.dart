import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  FirebaseMessaging messege = FirebaseMessaging.instance;

  void requestNotificationPermission() async {
    NotificationSettings settings = await messege.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted Permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User Provisnol Permission');
    } else {
      print('User denide Permission');
    }
  }

  Future<String> getDeviceToken() async {
    String? fcmToken = await messege.getToken();
    print(fcmToken);
    return fcmToken;
  }
}
