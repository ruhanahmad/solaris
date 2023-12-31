import 'dart:io' as io;
import 'dart:io';

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/controllers/audioController.dart';
import 'package:solaris/main.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_blue/flutter_blue.dart' as blue;
class UserController extends GetxController {


AudioController audioController = Get.put(AudioController());
var referalName = "";
var referalPhoneNumber = "";
var address;
var referalCity = "";
var referalDescription = "";
var customerIdss = "";
var referalEmail = "";
var googleLocation = "";
var email = "";
var token;
var complaintName;
var complaint;
var reviews;




var referalNameCustomer = "";
var referalPhoneNumberCustomer = "";
var referalCityCustomer = "";

var selectedValueForReview= "";

 blue.FlutterBlue flutterBlue = blue.FlutterBlue.instance;
  List<blue.BluetoothDevice> devicesList = [];
Future updateToken()async {
  final usersRef = await FirebaseFirestore.instance.collection('users');
 await usersRef.doc().update({'token': ""});
}
//notification=======================





Future requestPermission() async{
FirebaseMessaging messaging = FirebaseMessaging.instance;

NotificationSettings settings = await messaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
);

if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  print("user permission");
}
else if(settings.authorizationStatus == AuthorizationStatus.provisional) {
    print("user permission Provisional");
}
else {
  print("no permission");
}

print('User granted permission: ${settings.authorizationStatus}');

}

Future storeFCMToken()async {

 token = await FirebaseMessaging.instance.getToken();
}


Future updateWorkAssign(String id,String name)async {
  EasyLoading.show();
  final usersRef = await FirebaseFirestore.instance.collection('complaint');
 await  usersRef.doc(id).update({'assignedTo': name});
 EasyLoading.dismiss();
}

Future giveReviews(String id,double reviews)async {
  EasyLoading.show();
  final usersRef = await FirebaseFirestore.instance.collection('complaint');
 await  usersRef.doc(id).update({'customerReviews':reviews });
 EasyLoading.dismiss();
}



void handleSendNotification() async {
    var deviceState = await OneSignal.shared.getDeviceState();

    if (deviceState == null || deviceState.userId == null)
        return;

    var playerId = deviceState.userId!;
     print(playerId);
    var imgUrlString =
        "http://cdn1-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-2.jpg";

    var notification = OSCreateNotification(
        playerIds: [playerId],
        content: "this is a test from OneSignal's Flutter SDK",
        heading: "Test Notification",
        iosAttachments: {"id1": imgUrlString},
        bigPicture: imgUrlString,
        buttons: [
          OSActionButton(text: "test1", id: "id1"),
          OSActionButton(text: "test2", id: "id2")
        ]);

    var response = await OneSignal.shared.postNotification(notification);
print(response);
   
  }


Future<void> sendNotificationToUser() async {
  final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=AAAALn5Z4gg:APA91bHBHnvi4zwko95_54v5Xp5hoqmd1mGXAHkGlMJ1FMcH2n1eSYD8iOP2Be6HaVG9Rrqc6YgNDT2R718QhHM-49P66w_Fl56BZQv7eIlm7RQCOW5_WCM3Dbevf6yK-68C8GwL3_3E',
  };

  final bodyData = {
    'to': "f708BSKnRd-nGydxcIUFNz:APA91bHty0Q_e0RKqQ6jprUxhIpB9tzUaFaZCQn37kReORRpsocGXCy9VSuaHx8uZVd9wzmgAfgGxU8zsgDxZhxtSvJ8DEKTkAnM7H_N7u7CPfkM2s9E7cGWUi89o61wSc2iz5NVf04P",
    'notification': {
      'title': "hi this is frm api",
      'body': "this is from body",
    },
  };

  final response = await http.post(url, headers: headers, body: jsonEncode(bodyData));
  print(response);
  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification. Error: ${response.body}');
  }
}
  List<DocumentSnapshot> documents = [];
    List news = [];
    String? role;
    String? userName;
    String? customerId;
  Future<dynamic> prepaid(String email) async {
    news.clear();
    documents.clear();
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo:email )
        .get();
    documents = result.docs;
    update();
    print(documents.length);
    if (documents.length > 0) {
      news.add(result.docs);
      print(news);
      print(documents.first["role"]);

      if (documents.first["role"] == "customer") {
        // accountsList[0].accountB = "";
        var ids = documents.first.id;
        role = documents.first["role"];
        userName = documents.first["name"];
        customerId = documents.first["customerId"];

       update();
     
        
        
      }
       else if (documents.first["role"] == "siteEngineer") {
        role = documents.first["role"];
        userName = documents.first["name"];
       update();
     
    
      }
       else if (documents.first["role"] == "salesPerson") {
        role = documents.first["role"];
        userName = documents.first["name"];
        
       update();
     
    
      }
       else if (documents.first["role"] == "netMeteringAdmin") {
        role = documents.first["role"];
        userName = documents.first["name"];
        
       update();
     
    
      }
       else if (documents.first["role"] == "electrician") {
        role = documents.first["role"];
        userName = documents.first["name"];
        
       update();
     
    
      }
       else if (documents.first["role"] == "netMeteringAdmin") {
        role = documents.first["role"];
        userName = documents.first["name"];
        
       update();
     
    
      }
        else if (documents.first["role"] == "netMeteringOfficer") {
        role = documents.first["role"];
        userName = documents.first["name"];
        
       update();
     
    
      }
       else if (documents.first["role"] == "finance") {
        role = documents.first["role"];
        userName = documents.first["name"];
        
       update();
     
    
      }
          else if (documents.first["role"] == "salesperson") {
        role = documents.first["role"];
        userName = documents.first["name"];
        
       update();
     
    
      }
   
    } else {
      Get.snackbar(
        "Error",
        "user not Exsist ! Sign up First",
      );

      role = "nothing";
  
      update();
EasyLoading.dismiss();
    }
  }


 String passwordNumberGenerated(){
  var rndnumber="";
  var rnd= new Random();
  for (var i = 0; i < 4; i++) {
  rndnumber = rndnumber + rnd.nextInt(9).toString() +"abt";
  }
  print(rndnumber);
  return rndnumber;
}






 String emailNumberGenerated(){
  var rndnumber="";
  var rnd= new Random();
  for (var i = 0; i < 4; i++) {
  rndnumber = rndnumber + rnd.nextInt(9).toString();
  }
  print(rndnumber);
  return rndnumber;
}





 String tenNumberGenerated(){
  var rndnumber="";
  var rnd= new Random();
  for (var i = 0; i < 10; i++) {
  rndnumber = rndnumber + rnd.nextInt(9).toString();
  }
  print(rndnumber);
  return rndnumber;
}
     FirebaseFirestore firebaseRef =  FirebaseFirestore.instance;


      String selectedUserId = "";
 String? selectedName;
 String? selectedCustomerId;


   
   
   






     Future<UploadTask?> uploadFilesPassport(XFile? files,context,String recordFilePath)async {
   String strVal = "";

      final FirebaseStorage storage = FirebaseStorage.instance;
    final Reference firebaseStorageRef = storage
        .ref()
        .child(
           'profilepics/audio${DateTime.now().millisecondsSinceEpoch.toString()}');


   UploadTask task = firebaseStorageRef.putFile(File(recordFilePath));
    // task.onComplete.then((value) async {
      print('##############done#########');
        final TaskSnapshot taskSnapshot = await task;
      var audioURL = await taskSnapshot.ref.getDownloadURL();
  
     strVal = audioURL.toString();  
    update();   
     //  await sendAudioMsg(strVal);
    
    // })
    // .catchError((e) {
    //   print(e);
    // });
  
    
     String rand = await tenNumberGenerated();
 var uniqueKeys = firebaseRef.collection("users");
    var uniqueKey = firebaseRef.collection("users");
    if (files == null) {
      EasyLoading.show();
      FirebaseFirestore.instance.collection("complaint").add({
             "userid":role == "customer" ?auths.useri : selectedUserId,
        'customerName':role == "customer" ? userName: selectedName,
        'complaint': audioController.selectedValue == "Others" ? complaint:  audioController.selectedValue,
               
                "complaintImage":"",
                "role":role,
                "dateTime":DateTime.now(),
                "complaintBy": userName,
                "status":"pending",
                "assignedTo":"",
                "ticketId":rand,
                "dateTimeCompleted":"",
                "customerReviews":0,
                "customerId":role == "customer" ?customerId:selectedCustomerId,
                "audio":strVal

                
               

           });
           EasyLoading.dismiss();
           Get.snackbar("Complaint Register", "Complained  registered successfully");
           return null;
           
    }

    UploadTask uploadTask;

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('ComplaintImage') 
        .child('${rand}.jpg');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': files.path},
    );
    EasyLoading.show();

    if (kIsWeb) {
      uploadTask = ref.putData(await files.readAsBytes(), metadata);
    } else {
      
      uploadTask = ref.putFile(io.File(files.path), metadata);

    await  uploadTask.whenComplete(() async {
        var uploadpaths = await uploadTask.snapshot.ref.getDownloadURL();
           FirebaseFirestore.instance.collection("complaint").add({
             "userid":role == "customer" ?auths.useri : selectedUserId,
        'customerName':role == "customer" ? userName: selectedName,
        'complaint': complaint,
               
                "complaintImage":uploadpaths,
                "role":role,
                "dateTime":DateTime.now(),
                "complaintBy": userName,
                "status":"pending",
                "assignedTo":"",
                "ticketId":rand,
                "dateTimeCompleted":"",
                "customerReviews":0,

                
               

           });
              //  await SendMailss();
           Get.snackbar("Uploaded", "Upload successfully");
          //  Get.to(HomePage());
          // await   sendEmail();
          EasyLoading.dismiss();
        // Get.to(HomePage());
        
      });


    }
    
    // await ref.getDownloadURL().then((value) => updataIdCard(value));

    return Future.value(uploadTask);
  }


var userEmailUid;
final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
   Future createUserWithEmailAndPassword(
    String email,
    String name,
    String customerId,
    String city,
    String phoneNumber,
    String description,
    String googleLocation,
    String selectedOption,
    String address,

 
    
    BuildContext buildContext,
  ) async {
  
    EasyLoading.show();

     var passwords = await userController.passwordNumberGenerated();
     update();
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email ,
      password: passwords,
    );
    final auth.User user = _firebaseAuth.currentUser!;
     userEmailUid = credential.user!.uid;
     update();
    users.doc(user.uid).set({
      'email':email  ,
      'id': userEmailUid,
      'name': name,
      "city":city,
      "phone":phoneNumber,
      "description":description,
      "location":googleLocation,
      "meteringRequired":selectedOption,
      "role":"customer",
      "token":"",
      "customerId":customerId,
      "password":passwords,
      "netMetering":false,
      "FirstStepDateTime":DateTime.now(),
      "Step":0,
      "inProcess":"notStarted",
      "address":address,
      "nonPaymentCounter":0,
      "paymentCounter":0

     
      // role == "customer" ?"netMetering":false :null

    });
    user.updateDisplayName(name);

    user.reload();
    // user.sendEmailVerification();
EasyLoading.dismiss();
    //  Get.to(()=>MyNavigationBar());
    return true;
  }







  List<DocumentSnapshot> checkingCustomerDocuments = [];
    List cus = [];
    
  Future<bool?> checkIfCustomerExsist() async {
    cus.clear();
    checkingCustomerDocuments.clear();
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('complaint')
        .where('customerName', isEqualTo:selectedName ).where('customerId', isEqualTo:selectedCustomerId ).where("status",isEqualTo: "pending")
        .get();
    checkingCustomerDocuments = result.docs;
    update();
    print(checkingCustomerDocuments.length);
    if (checkingCustomerDocuments.length > 0) {
      cus.add(result.docs);
      print(cus);

        return true;
        
  

  }

else {


  
  return false;



}
}



List<DocumentSnapshot> checkingCustomerDocumentsExsists = [];
    List cusExsists = [];

 Future<bool?> checkIfCustomerExsistFromCustomerPanel() async {
    cusExsists.clear();
    checkingCustomerDocumentsExsists.clear();
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('complaint')
        .where('customerName', isEqualTo:userName).where('customerId', isEqualTo:customerId).where("status",isEqualTo: "pending")
        .get();
    print(userName);
    print(customerId);
    checkingCustomerDocumentsExsists = result.docs;
    update();
    print(checkingCustomerDocumentsExsists.length);
    if (checkingCustomerDocumentsExsists.length > 0) {
      cusExsists.add(result.docs);
      print(cusExsists);

        return true;
        
  

  }

else {


  
  return false;



}
}






















}



// import 'dart:io' as io;

// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart' as auth;
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';


// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:solaris/controllerRef.dart';
// import 'package:solaris/main.dart';
// import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_blue/flutter_blue.dart' as blue;
// class UserController extends GetxController {
// var referalName = "";
// var referalPhoneNumber = "";
// var referalCity = "";
// var referalDescription = "";
// var customerIdss = "";
// var referalEmail = "";
// var googleLocation = "";
// var email = "";
// var token;
// var complaintName;
// var complaint;
// var reviews;




// var referalNameCustomer = "";
// var referalPhoneNumberCustomer = "";
// var referalCityCustomer = "";

// var selectedValueForReview= "";

//  blue.FlutterBlue flutterBlue = blue.FlutterBlue.instance;
//   List<blue.BluetoothDevice> devicesList = [];
// Future updateToken()async {
//   final usersRef = await FirebaseFirestore.instance.collection('users');
//  await usersRef.doc().update({'token': ""});
// }
// //notification=======================





// Future requestPermission() async{
// FirebaseMessaging messaging = FirebaseMessaging.instance;

// NotificationSettings settings = await messaging.requestPermission(
//   alert: true,
//   announcement: false,
//   badge: true,
//   carPlay: false,
//   criticalAlert: false,
//   provisional: false,
//   sound: true,
// );

// if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//   print("user permission");
// }
// else if(settings.authorizationStatus == AuthorizationStatus.provisional) {
//     print("user permission Provisional");
// }
// else {
//   print("no permission");
// }

// print('User granted permission: ${settings.authorizationStatus}');

// }

// Future storeFCMToken()async {

//  token = await FirebaseMessaging.instance.getToken();
// }


// Future updateWorkAssign(String id,String name)async {
//   EasyLoading.show();
//   final usersRef = await FirebaseFirestore.instance.collection('complaint');
//  await  usersRef.doc(id).update({'assignedTo': name});
//  EasyLoading.dismiss();
// }

// Future giveReviews(String id,double reviews)async {
//   EasyLoading.show();
//   final usersRef = await FirebaseFirestore.instance.collection('complaint');
//  await  usersRef.doc(id).update({'customerReviews':reviews });
//  EasyLoading.dismiss();
// }



// void handleSendNotification() async {
//     var deviceState = await OneSignal.shared.getDeviceState();

//     if (deviceState == null || deviceState.userId == null)
//         return;

//     var playerId = deviceState.userId!;
//      print(playerId);
//     var imgUrlString =
//         "http://cdn1-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-2.jpg";

//     var notification = OSCreateNotification(
//         playerIds: [playerId],
//         content: "this is a test from OneSignal's Flutter SDK",
//         heading: "Test Notification",
//         iosAttachments: {"id1": imgUrlString},
//         bigPicture: imgUrlString,
//         buttons: [
//           OSActionButton(text: "test1", id: "id1"),
//           OSActionButton(text: "test2", id: "id2")
//         ]);

//     var response = await OneSignal.shared.postNotification(notification);
// print(response);
   
//   }


// Future<void> sendNotificationToUser() async {
//   final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
//   final headers = {
//     'Content-Type': 'application/json',
//     'Authorization': 'key=AAAALn5Z4gg:APA91bHBHnvi4zwko95_54v5Xp5hoqmd1mGXAHkGlMJ1FMcH2n1eSYD8iOP2Be6HaVG9Rrqc6YgNDT2R718QhHM-49P66w_Fl56BZQv7eIlm7RQCOW5_WCM3Dbevf6yK-68C8GwL3_3E',
//   };

//   final bodyData = {
//     'to': "f708BSKnRd-nGydxcIUFNz:APA91bHty0Q_e0RKqQ6jprUxhIpB9tzUaFaZCQn37kReORRpsocGXCy9VSuaHx8uZVd9wzmgAfgGxU8zsgDxZhxtSvJ8DEKTkAnM7H_N7u7CPfkM2s9E7cGWUi89o61wSc2iz5NVf04P",
//     'notification': {
//       'title': "hi this is frm api",
//       'body': "this is from body",
//     },
//   };

//   final response = await http.post(url, headers: headers, body: jsonEncode(bodyData));
//   print(response);
//   if (response.statusCode == 200) {
//     print('Notification sent successfully');
//   } else {
//     print('Failed to send notification. Error: ${response.body}');
//   }
// }
//   List<DocumentSnapshot> documents = [];
//     List news = [];
//     String? role;
//     String? userName;
//     String? customerId;
//   Future<dynamic> prepaid(String email) async {
//     news.clear();
//     documents.clear();
//     final QuerySnapshot result = await FirebaseFirestore.instance
//         .collection('users')
//         .where('email', isEqualTo:email )
//         .get();
//     documents = result.docs;
//     update();
//     print(documents.length);
//     if (documents.length > 0) {
//       news.add(result.docs);
//       print(news);
//       print(documents.first["role"]);

//       if (documents.first["role"] == "customer") {
//         // accountsList[0].accountB = "";
//         var ids = documents.first.id;
//         role = documents.first["role"];
//         userName = documents.first["name"];
//         customerId = documents.first["customerId"];

//        update();
     
        
        
//       }
//        else if (documents.first["role"] == "siteEngineer") {
//         role = documents.first["role"];
//         userName = documents.first["name"];
//        update();
     
    
//       }
//        else if (documents.first["role"] == "salesPerson") {
//         role = documents.first["role"];
//         userName = documents.first["name"];
        
//        update();
     
    
//       }
//        else if (documents.first["role"] == "netMeteringAdmin") {
//         role = documents.first["role"];
//         userName = documents.first["name"];
        
//        update();
     
    
//       }
//        else if (documents.first["role"] == "electrician") {
//         role = documents.first["role"];
//         userName = documents.first["name"];
        
//        update();
     
    
//       }
//        else if (documents.first["role"] == "netMeteringAdmin") {
//         role = documents.first["role"];
//         userName = documents.first["name"];
        
//        update();
     
    
//       }
//         else if (documents.first["role"] == "netMeteringOfficer") {
//         role = documents.first["role"];
//         userName = documents.first["name"];
        
//        update();
     
    
//       }
//        else if (documents.first["role"] == "finance") {
//         role = documents.first["role"];
//         userName = documents.first["name"];
        
//        update();
     
    
//       }
//           else if (documents.first["role"] == "salesperson") {
//         role = documents.first["role"];
//         userName = documents.first["name"];
        
//        update();
     
    
//       }
   
//     } else {
//       Get.snackbar(
//         "Error",
//         "user not Exsist ! Sign up First",
//       );

//       role = "nothing";
  
//       update();
// EasyLoading.dismiss();
//     }
//   }


//  String passwordNumberGenerated(){
//   var rndnumber="";
//   var rnd= new Random();
//   for (var i = 0; i < 4; i++) {
//   rndnumber = rndnumber + rnd.nextInt(9).toString() +"abt";
//   }
//   print(rndnumber);
//   return rndnumber;
// }






//  String emailNumberGenerated(){
//   var rndnumber="";
//   var rnd= new Random();
//   for (var i = 0; i < 4; i++) {
//   rndnumber = rndnumber + rnd.nextInt(9).toString();
//   }
//   print(rndnumber);
//   return rndnumber;
// }





//  String tenNumberGenerated(){
//   var rndnumber="";
//   var rnd= new Random();
//   for (var i = 0; i < 10; i++) {
//   rndnumber = rndnumber + rnd.nextInt(9).toString();
//   }
//   print(rndnumber);
//   return rndnumber;
// }
//      FirebaseFirestore firebaseRef =  FirebaseFirestore.instance;


//       String selectedUserId = "";
//  String? selectedName;
//  String? selectedCustomerId;
//      Future<UploadTask?> uploadFilesPassport(XFile? files,context) async {
  
    
//      String rand = await tenNumberGenerated();
//  var uniqueKeys = firebaseRef.collection("users");
//     var uniqueKey = firebaseRef.collection("users");
//     if (files == null) {
//       EasyLoading.show();
//       FirebaseFirestore.instance.collection("complaint").add({
//              "userid":role == "customer" ?auths.useri : selectedUserId,
//         'customerName':role == "customer" ? userName: selectedName,
//         'complaint': complaint,
               
//                 "complaintImage":"",
//                 "role":role,
//                 "dateTime":DateTime.now(),
//                 "complaintBy": userName,
//                 "status":"pending",
//                 "assignedTo":"",
//                 "ticketId":rand,
//                 "dateTimeCompleted":"",
//                 "customerReviews":0,
//                 "customerId":role == "customer" ?customerId:selectedCustomerId

                
               

//            });
//            EasyLoading.dismiss();
//            Get.snackbar("Complaint Register", "Complained  registered successfully");
//            return null;
           
//     }

//     UploadTask uploadTask;

//     // Create a Reference to the file
//     Reference ref = FirebaseStorage.instance
//         .ref()
//         .child('ComplaintImage') 
//         .child('${rand}.jpg');

//     final metadata = SettableMetadata(
//       contentType: 'image/jpeg',
//       customMetadata: {'picked-file-path': files.path},
//     );
//     EasyLoading.show();

//     if (kIsWeb) {
//       uploadTask = ref.putData(await files.readAsBytes(), metadata);
//     } else {
      
//       uploadTask = ref.putFile(io.File(files.path), metadata);

//     await  uploadTask.whenComplete(() async {
//         var uploadpaths = await uploadTask.snapshot.ref.getDownloadURL();
//            FirebaseFirestore.instance.collection("complaint").add({
//              "userid":role == "customer" ?auths.useri : selectedUserId,
//         'customerName':role == "customer" ? userName: selectedName,
//         'complaint': complaint,
               
//                 "complaintImage":uploadpaths,
//                 "role":role,
//                 "dateTime":DateTime.now(),
//                 "complaintBy": userName,
//                 "status":"pending",
//                 "assignedTo":"",
//                 "ticketId":rand,
//                 "dateTimeCompleted":"",
//                 "customerReviews":0,

                
               

//            });
//               //  await SendMailss();
//            Get.snackbar("Uploaded", "Upload successfully");
//           //  Get.to(HomePage());
//           // await   sendEmail();
//           EasyLoading.dismiss();
//         // Get.to(HomePage());
        
//       });


//     }
    
//     // await ref.getDownloadURL().then((value) => updataIdCard(value));

//     return Future.value(uploadTask);
//   }


// var userEmailUid;
// final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//    Future createUserWithEmailAndPassword(
//     String email,
//     String name,
//     String customerId,
//     String city,
//     String phoneNumber,
//     String description,
//     String googleLocation,
//     String selectedOption,

 
    
//     BuildContext buildContext,
//   ) async {
  
//     EasyLoading.show();

//      var passwords = await userController.passwordNumberGenerated();
//      update();
//     final credential = await _firebaseAuth.createUserWithEmailAndPassword(
//       email: email ,
//       password: passwords,
//     );
//     final auth.User user = _firebaseAuth.currentUser!;
//      userEmailUid = credential.user!.uid;
//      update();
//     users.doc(user.uid).set({
//       'email':email  ,
//       'id': userEmailUid,
//       'name': name,
//       "city":city,
//       "phoneNumer":phoneNumber,
//       "description":description,
//       "location":googleLocation,
//       "meteringRequired":selectedOption,
//       "role":"customer",
//       "token":"",
//       "customerId":customerId,
//       "password":passwords,
//       "netMetering":false,
//       "FirstStepDateTime":DateTime.now(),
//       "Step":0,
//       "inProcess":"null"

     
//       // role == "customer" ?"netMetering":false :null

//     });
//     user.updateDisplayName(name);

//     user.reload();
//     // user.sendEmailVerification();
// EasyLoading.dismiss();
//     //  Get.to(()=>MyNavigationBar());
//     return true;
//   }







//   List<DocumentSnapshot> checkingCustomerDocuments = [];
//     List cus = [];
    
//   Future<bool?> checkIfCustomerExsist() async {
//     cus.clear();
//     checkingCustomerDocuments.clear();
//     final QuerySnapshot result = await FirebaseFirestore.instance
//         .collection('complaint')
//         .where('customerName', isEqualTo:selectedName ).where('customerId', isEqualTo:selectedCustomerId ).where("status",isEqualTo: "pending")
//         .get();
//     checkingCustomerDocuments = result.docs;
//     update();
//     print(checkingCustomerDocuments.length);
//     if (checkingCustomerDocuments.length > 0) {
//       cus.add(result.docs);
//       print(cus);

//         return true;
        
  

//   }

// else {


  
//   return false;



// }
// }



// List<DocumentSnapshot> checkingCustomerDocumentsExsists = [];
//     List cusExsists = [];

//  Future<bool?> checkIfCustomerExsistFromCustomerPanel() async {
//     cusExsists.clear();
//     checkingCustomerDocumentsExsists.clear();
//     final QuerySnapshot result = await FirebaseFirestore.instance
//         .collection('complaint')
//         .where('customerName', isEqualTo:userName).where('customerId', isEqualTo:customerId).where("status",isEqualTo: "pending")
//         .get();
//     print(userName);
//     print(customerId);
//     checkingCustomerDocumentsExsists = result.docs;
//     update();
//     print(checkingCustomerDocumentsExsists.length);
//     if (checkingCustomerDocumentsExsists.length > 0) {
//       cusExsists.add(result.docs);
//       print(cusExsists);

//         return true;
        
  

//   }

// else {


  
//   return false;



// }
// }






















//}
