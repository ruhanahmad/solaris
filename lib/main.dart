import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solaris/Notification/notification.dart';
import 'package:solaris/controllers/userController.dart';
import 'package:solaris/loginScreen.dart';
import 'package:solaris/models/auth.dart';
import 'package:solaris/screens/test.dart';
import 'package:solaris/screens/tests.dart';
import 'controllerRef.dart';
import 'salesPerson/thermal.dart';
// import 'chats_screen.dart';
// import 'status_screen.dart';
// import 'calls_screen.dart';



final navigatorKey = GlobalKey<NavigatorState>;
void handleNotificationOpened(OSNotificationOpenedResult result) {
  // Handle opened notification here
  print('Notification opened: ${result.notification.jsonRepresentation()}');
  print('Additional data: ${result.notification.additionalData}');
}
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
// await FirebaseMessagingService().getToken();
   OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

OneSignal.shared.setAppId("cfc491ba-dd50-4822-90a3-814ca06bc214");
OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {

print(event.notification);

event.complete(event.notification);
});
// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
});
    OneSignal.shared.setNotificationOpenedHandler(handleNotificationOpened);

 
  // final usersRef = FirebaseFirestore.instance.collection('users');
  // usersRef.doc(token).set({'token': token});

  runApp(MyApp());
  
 

  
}
//  navigateToMarker(markerPosition.latitude, markerPosition.longitude);

//   void navigateToMarker(double latitude, double longitude) async {
//     final String googleMapsUrl = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
//     if (await canLaunch(googleMapsUrl)) {
//       await launch(googleMapsUrl);
//     } else {
//       throw 'Could not launch $googleMapsUrl';
//     }
//   }
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: 
      // NotificationPage(),
      // NotificationOpenedHandler(),
      AuthPage(),
      // haha(),
      // FirestoreDataWidget(),
      // ThermalPrinter(),
      // Record(),
      // LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}


