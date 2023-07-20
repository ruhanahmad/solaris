import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:solaris/admin/adminHomeScreen.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/customer.dart';
import 'package:solaris/financeDeprt/financeHomepage.dart';
import 'package:solaris/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solaris/netMeteringOfficer/officerHomeScreen.dart';
import 'package:solaris/salesPerson/salesPersonHome.dart';
import 'package:solaris/siteEngineer/siteEnginner.dart';

import '../electrician/electricianhomePage.dart';

class AuthenticationService extends GetxController{

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');


var useri;
  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }

    return User(user.uid, user.email, user.emailVerified);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    EasyLoading.show();
  
   
     await userController.prepaid(email);
      if (userController.role == "customer") {
   final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
     useri = credential.user!.uid;
     
     update();
    await notificationController.getPlayerId();

EasyLoading.dismiss();
     Get.to(()=>MyNavigationBar());
      return _userFromFirebase(credential.user);
      }

       else if (userController.role == "siteEngineer") {
   final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
     useri = credential.user!.uid;
     update();
    await notificationController.getPlayerId();

EasyLoading.dismiss();
     Get.to(()=>SiteEngineer());
      return _userFromFirebase(credential.user);
      }

 else if (userController.role == "electrician") {
   final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
     useri = credential.user!.uid;
     update();
    await notificationController.getPlayerId();

EasyLoading.dismiss();
     Get.to(()=>Electricians());
      return _userFromFirebase(credential.user);
      }
       else if (userController.role == "netMeteringAdmin") {
   final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
     useri = credential.user!.uid;
     update();
    await notificationController.getPlayerId();

EasyLoading.dismiss();
     Get.to(()=>AdminHomeScreen());
      return _userFromFirebase(credential.user);
      }

 else if (userController.role == "netMeteringOfficer") {
   final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
     useri = credential.user!.uid;
     update();
    await notificationController.getPlayerId();

EasyLoading.dismiss();
     Get.to(()=>OfficerHomeScreen());
      return _userFromFirebase(credential.user);
      }

      else if (userController.role == "finance") {
   final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
     useri = credential.user!.uid;
     update();
    await notificationController.getPlayerId();

EasyLoading.dismiss();
     Get.to(()=>FinanceHomeScreen());
      return _userFromFirebase(credential.user);
      }



            else if (userController.role == "salesperson") {
   final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
     useri = credential.user!.uid;
     update();
    await notificationController.getPlayerId();

EasyLoading.dismiss();
     Get.to(()=>SalesPerson());
      return _userFromFirebase(credential.user);
      }


      

  else {
   Get.snackbar("User", "User not Exsist");
   EasyLoading.dismiss();
  }    
 
   
  }
  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
    // String role,
    
    BuildContext buildContext,
  ) async {
  
    EasyLoading.show();
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final auth.User user = _firebaseAuth.currentUser!;
     useri = credential.user!.uid;
     update();
    users.doc(user.uid).set({
      'email': email,
      'id': user.uid,
      'name': name,
      "role":"",
      "token":"",
      // role == "customer" ?"netMetering":false :null

    });
    user.updateDisplayName(name);

    user.reload();
    user.sendEmailVerification();
EasyLoading.dismiss();
     Get.to(()=>MyNavigationBar());
    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    
    return await _firebaseAuth.signOut();
    
  }
}
