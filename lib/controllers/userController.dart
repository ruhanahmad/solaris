import 'dart:io' as io;

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/main.dart';
import 'package:flutter/material.dart';


class UserController extends GetxController {



var complaintName;
var complaint;


  List<DocumentSnapshot> documents = [];
    List news = [];
    String? role;
    String? userName;
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
       else if (documents.first["role"] == "netMetering") {
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


      String? selectedUserId ;
 String? selectedName;
     Future<UploadTask?> uploadFilesPassport(XFile? files,context) async {
  
    
     String rand = await tenNumberGenerated();
 var uniqueKeys = firebaseRef.collection("users");
    var uniqueKey = firebaseRef.collection("users");
    if (files == null) {
    Get.snackbar("Title", "No file was selected");

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
                "ticketId":rand

                
               

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

}