import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/models/authentication_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solaris/screens/test.dart';
import '../models/user_model.dart';

class StepsCompleted extends StatefulWidget {

  String? id;
  String? name;
  StepsCompleted({required this.id,required this.name});
  @override
  State<StepsCompleted> createState() => _StepsCompletedState();
}

class _StepsCompletedState extends State<StepsCompleted> {
 
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;
     
    return Scaffold(
      appBar: AppBar(
        title: Text('Steps Completed'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
  SizedBox(height: halfHeight * 0.1),
               Text(
                'Steps Completed',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: halfHeight * 0.1),

  StreamBuilder<QuerySnapshot>(
               stream:  
                           FirebaseFirestore.instance
                              .collection('users').doc(widget.id).collection('netMeteringProcedure')
                              .where("approved",isEqualTo: true)
                              .snapshots(),
               
               builder: (context, snapshot) {
                 if (!snapshot.hasData) {
                   return CircularProgressIndicator();
                 }
        else   if (snapshot.data!.docs.isEmpty) {
      Text('Collection is empty');
    } 
                 final documents = snapshot.data!.docs;
      
               
      
                 return
                 Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                   child: 
                   ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){
                        var ids = documents[index].id;
                       var name = documents[index]['name'];
                var approved = documents[index]['approved'];
                var netMeteringOfficerName  =documents[index]['officerName'];
                              
                 return     Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                         decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: Colors.green.withOpacity(0.2),
                   ),
                        child: Column(
                          children: [
             
                         
                         Text("Step ${index} \n | \n | \n | \n | "),
                            ListTile(
                              
                              title: Text("${name} : Completed by ${netMeteringOfficerName} " ), 
                              // trailing:Text("${status}",style: TextStyle(color: Colors.green),) ,
                              // subtitle:Text("Complaint received from ${ids} " ), 
                            ),
                                        
                       
    //                                     ElevatedButton(
    //                     onPressed: () async{
    //               // sendNotification();
    // // await  electricianController.updateToken(ids);
    //             //  Get.to(()=>NotificationOpenedHandler()); 
    //                       print('Button Pressed!');
    //                     },
    //                     child: Text('Resolve'),
    //                                     )
                                        
                                        
                          ],
                        ),
                      ),
                    );
                    }),
                 );
              
               },
             ),





             
   

          ],
        ),
      ),
    );
  }
}
