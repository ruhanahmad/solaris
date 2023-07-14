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

class PreviousComplaint extends StatefulWidget {
  @override
  State<PreviousComplaint> createState() => _PreviousComplaintState();
}

class _PreviousComplaintState extends State<PreviousComplaint> {
 final TextEditingController _nameController = TextEditingController();
  final TextEditingController _complaintController = TextEditingController();
  
AuthenticationService auths = Get.put(AuthenticationService());







  var selectedValues;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;
     
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('PrevipComplaint Processing'),
      //   automaticallyImplyLeading: false,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
  SizedBox(height: halfHeight * 0.1),
               Text(
                'Complaints ',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: halfHeight * 0.1),

  StreamBuilder<QuerySnapshot>(
               stream:  FirebaseFirestore.instance
        .collection('complaint').where('userid', isEqualTo:auths.useri ).where("status",isEqualTo:"pending")
        .snapshots(),
               
               builder: (context, snapshot) {
                 if (!snapshot.hasData) {
                   return CircularProgressIndicator();
                 }
      
                 final documents = snapshot.data!.docs;
      
               
      
                 return
                 Container(
                  height: 400,
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
                //                         var token = documents[index]["token"];
                                        var ticketId = documents[index]["ticketId"];
                                        var assignedTo = documents[index]["assignedTo"];
                              
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
                              leading: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(image ?? ""),
                              ),
                              title:assignedTo == "" ?  Text("Your Complaint Generated ticket number: ${ticketId}.Description : ${complaintDescription} " ):Text("Your Complaint Generated ticket number: ${ticketId}. ${assignedTo} is Working on your Complaint.Description : ${complaintDescription} " ), 
                              trailing:Text("${status}",style: TextStyle(color: Colors.green),) ,
                              subtitle:Text("Complaint received from ${ids} " ), 
                            ),
                                        
                     
                                        
                                        
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
