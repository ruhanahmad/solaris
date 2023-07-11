import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:solaris/customer..dart';
import 'package:solaris/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  ) async {
    EasyLoading.show();
    
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
     useri = credential.user!.uid;
     update();
EasyLoading.dismiss();
     Get.to(()=>MyNavigationBar());
    return _userFromFirebase(credential.user);
  }
  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
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
