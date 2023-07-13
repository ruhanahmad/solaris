
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NotificationController extends GetxController {


var playerId;
void sendNotification(String playerId) async {
    //  var deviceState = await OneSignal.shared.getDeviceState();

    // if (deviceState == null || deviceState.userId == null)
    //     return;

    // var playerId = deviceState.userId!;
    //  print("playeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer" +playerId);
    var notification = OSCreateNotification(
      playerIds: [playerId], // Specify the player IDs or segments to target, leave empty for all users
      content: 'Notification Body',
      heading: 'Notification Title',
    );

    var response = await OneSignal.shared.postNotification(notification);
    print('Notification sent: ${response}');
  }
Future updateToken()async {
  final usersRef = await FirebaseFirestore.instance.collection('users');
 await usersRef.doc(auths.useri).update({'token': playerId});
}

  Future getPlayerId() async {
    try {
 var deviceState = await OneSignal.shared.getDeviceState();

    if (deviceState == null || deviceState.userId == null)
        return;

    notificationController.playerId = deviceState.userId!;
     print("playeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer" + notificationController.playerId);
   await  updateToken();
    }
    catch(e){
     Get.snackbar("title", "not getting PlayerID  ${e}");
    }
    



  }

}