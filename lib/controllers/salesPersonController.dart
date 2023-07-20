
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SalesPersonController extends GetxController {



Future updateToken(String id,String userName)async {
  try{
 final usersRef = await FirebaseFirestore.instance.collection('ReferalCustomers');
 await usersRef.doc(id).update({'PickBy':userName,});
  }catch(e){
 Get.snackbar("Error", "Issue in updating ${e}");
  }
 
}

 
}