
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ElectricianController extends GetxController {



Future updateToken(String id,)async {
  try{
 final usersRef = await FirebaseFirestore.instance.collection('complaint');
 await usersRef.doc(id).update({'status':"completed","dateTimeCompleted":DateTime.now(),});
  }catch(e){
 Get.snackbar("Error", "Issue in updating ${e}");
  }
 
}



 
}