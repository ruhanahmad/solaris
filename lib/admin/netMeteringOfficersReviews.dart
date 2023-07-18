

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

class NetMeteringOfficersReviews extends StatefulWidget {
   
  @override
  State<NetMeteringOfficersReviews> createState() => _NetMeteringOfficersReviewsState();
}

class _NetMeteringOfficersReviewsState extends State<NetMeteringOfficersReviews> {
 
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;
     
    return Scaffold(
      appBar: AppBar(
        title: Text('Performance'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
  SizedBox(height: halfHeight * 0.1),
               Text(
                'Approval Received',
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
                              .collection('users')
                              .where("approved",isEqualTo: false).where("payment",isNotEqualTo: "")
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
                var description = documents[index]["description"];
                var payment = documents[index]["payment"];
                var customerName = documents[index]["customerName"];
                 var sentForApproval = documents[index]["sentForApproval"];
                 var noted = documents[index]["noted"];
                                        // var token = documents[index]["token"];
                              
                 return   
                   Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                         decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: Colors.green.withOpacity(0.2),
                   ),
                        child: Column(
                          children: [
             
                         
                         
                            ListTile(
                        
                              title: Text("Approval request from ${netMeteringOfficerName}.Description :Step Name ::${name} " ), 
                             
                              subtitle:Text("${description} ---- ${payment} " ), 
                            ),
                                        
                       
                                        ElevatedButton(
                        onPressed: () async{

                    
           ;       
     
//  try{

//  final usersRef = await FirebaseFirestore.instance.collection('users');
//  await usersRef.doc(widget.id).collection("netMeteringProcedure").doc(ids).update({'approved':true,});
//   }catch(e){
//  Get.snackbar("Error", "Issue in updating ${e}");
//   }
  
      
                        
                        },
                        child: 
                     noted == false ?
                       
                         Text('Sending for approval to finance'):Text("Approve")
                        ,
                                        )
                                        
                                        
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
