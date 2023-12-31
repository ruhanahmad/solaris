import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/models/auth.dart';
import 'package:solaris/models/authentication_service.dart';
import 'package:solaris/screens/tests.dart';
import 'package:solaris/test.dart';
import 'package:url_launcher/url_launcher.dart';


class Profile extends StatelessWidget {
  AuthenticationService auths = Get.put(AuthenticationService());
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
        automaticallyImplyLeading: false,
      ),
      body: 
 Column(
   children: [
    Text("Name : ${userController.userName}"),
     Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: mediaQuery.size.height * 0.01,
                      horizontal: mediaQuery.size.width * 0.1,
                    ),
                    child: ElevatedButton(
                      onPressed: ()async {
                        
                       await auths.signOut().then((value) => Get.to(()=> AuthPage()));
                   //   Get.to(()=> AudioPlayerScreen());
                        
                        },
                      child: Text("Logout"),
                    ),
                  ),
                  //  Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     vertical: mediaQuery.size.height * 0.01,
                  //     horizontal: mediaQuery.size.width * 0.1,
                  //   ),
                  //   child: ElevatedButton(
                  //     onPressed: ()async {
                  //       // Get.to(()=>HomeScreenss());
                  //   //  userController.sendNotificationToUser();
                      
                        
                  //       },
                  //     child: Text("Logout"),
                  //   ),
                  // ),
   ],
 )
    );
  }

 
}
