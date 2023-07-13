import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:solaris/main.dart';
class FirebaseMessagingService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

   Future<String?> getToken() async {
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    print("token is {$token}");
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotifications();
    return token;
  }

void handleMessage(RemoteMessage? message){
if (message == null) return;
// navigatorKey.pushNamed(NotificationScreen.route,arguments:message);
}


final _androidChannel =  AndroidNotificationChannel(
  'high important channel',
  'High Important Notifications',
  description: 'this channel is use for important notification',
  importance: Importance.defaultImportance
);

final _localNotification = FlutterLocalNotificationsPlugin();
Future initPushNotifications() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound:true
  );
  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
   FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
   FirebaseMessaging.onMessage.listen((event) { 
    final notification = event.notification;
    if(notification ==  null) return;

    _localNotification.show(notification.hashCode, notification.title, notification.body, NotificationDetails(
    android: AndroidNotificationDetails(_androidChannel.id, _androidChannel.name,
    channelDescription: _androidChannel.description,icon: "@drawable/ic_launcher",)

    ),
    payload: jsonEncode(event.toMap())
    );
   });

}

Future initLocalNotification()async{
// const IOS = InitializationSettings();
const Android = AndroidInitializationSettings("@drawable/ic_launcher");
const settings = InitializationSettings(android: Android);

await _localNotification.initialize(settings,onDidReceiveBackgroundNotificationResponse: (details) {
  // final message = RemoteMessage.fromMap(jsonDecode(payload!));

},);

}
Future<void> handleBackgroundMessage(RemoteMessage message)async {
  print("title ${message.notification?.title}");
   print("title ${message.notification?.body}");
    print("title ${message..data}");

}
  static void configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground messages
      print("Foreground Message received: ${message.notification?.body}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle when app is in the background and user taps on the notification
      print("Notification clicked: ${message.notification?.body}");
    });
  }
}
