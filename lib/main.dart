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
import 'controllerRef.dart';
// import 'chats_screen.dart';
// import 'status_screen.dart';
// import 'calls_screen.dart';



final navigatorKey = GlobalKey<NavigatorState>;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
await FirebaseMessagingService().getToken();
   OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

OneSignal.shared.setAppId("cfc491ba-dd50-4822-90a3-814ca06bc214");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
});


 
  // final usersRef = FirebaseFirestore.instance.collection('users');
  // usersRef.doc(token).set({'token': token});

  runApp(MyApp());
  
 

  
}

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
      NotificationOpenedHandler(),
      // AuthPage(),
      // LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}


