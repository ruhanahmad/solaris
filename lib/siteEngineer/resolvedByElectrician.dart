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
import 'package:solaris/widgets/alertPicture.dart';
import '../models/user_model.dart';

class ResolvedByElectrician extends StatefulWidget {
  @override
  State<ResolvedByElectrician> createState() => _ResolvedByElectricianState();
}

class _ResolvedByElectricianState extends State<ResolvedByElectrician> {
 
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;
     
    return Scaffold(
      appBar: AppBar(
        title: Text('Resolve'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
  SizedBox(height: halfHeight * 0.1),
               Text(
                'Resolve',
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
                              .collection('complaint')
                             .where('status', isEqualTo:"completed" )
                              .snapshots(),
               
               builder: (context, snapshot) {
                 if (!snapshot.hasData) {
                   return CircularProgressIndicator();
                 }
      
                 final documents = snapshot.data!.docs;
      
               
      
                 return
                 Container(
                  height:MediaQuery.of(context).size.height -300,
                  width: MediaQuery.of(context).size.width,
                   child: 
                   ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){
                        var ids = documents[index].id;
                       var cusName = documents[index]['customerName'];
                var complaintDescription = documents[index]['complaint'];
                  var status = documents[index]['status'];
                                var image = documents[index]["complaintImage"];
                                        var userId = documents[index]["userid"];
                                        var assignedTo = documents[index]["assignedTo"];
                                        // var token = documents[index]["token"];
                              
                 return     Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                         decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: Colors.green.withOpacity(0.2),
                   ),
                        child: Column(
                          children: [
             
                         
                         
                            ListTile(
                              leading: GestureDetector(
                                onTap: () {
                                  alertPicture(image,context);
                                },
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(image ?? ""),
                                ),
                              ),
                              title: Text("Complaint received from ${cusName}.Description : ${complaintDescription} " ), 
                              trailing:Text("${status}",style: TextStyle(color: Colors.green),) ,
                              subtitle:Text("Complaint resolved by  ${assignedTo} " ), 
                            ),
                                        
                       
    //                                     ElevatedButton(
    //                     onPressed: () async{
    //               // sendNotification();
    // await  electricianController.updateToken(ids);
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
