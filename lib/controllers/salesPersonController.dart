
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SalesPersonController extends GetxController {



Future updateToken(String id,String name)async {
  try{
 final usersRef = await FirebaseFirestore.instance.collection('ReferalCustomers');
 await usersRef.doc(id).update({'PickBy':name,});
  }catch(e){
 Get.snackbar("Error", "Issue in updating ${e}");
  }
 
}

Future updateCustomer(String id)async {
  try{
 final usersRef = await FirebaseFirestore.instance.collection('ReferalCustomers');
 await usersRef.doc(id).update({'sendForApproval':true,});
  }catch(e){
 Get.snackbar("Error", "Issue in updating ${e}");
  }
 
}

Future notedFinance(String id)async {
  try{
 final usersRef = await FirebaseFirestore.instance.collection('ReferalCustomers');
 await usersRef.doc(id).update({'notedByFinance':true,});
  }catch(e){
 Get.snackbar("Error", "Issue in updating ${e}");
  }
 
}

 
}