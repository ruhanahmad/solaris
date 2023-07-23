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

class DetailAboutOfficer extends StatefulWidget {
String? name;
String? ids;

DetailAboutOfficer({required this.name,required this.ids});
  @override
  State<DetailAboutOfficer> createState() => _DetailAboutOfficerState();
}

class _DetailAboutOfficerState extends State<DetailAboutOfficer> {
 
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
                'Performance',
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
                              .collection('reviews')
                              .where("officerName",isEqualTo: widget.name)
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
                  height: MediaQuery.of(context).size.height -300,
                  width: MediaQuery.of(context).size.width,
                   child: 
                   ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){
                        var ids = documents[index].id;
                       var name = documents[index]['name'];
                var officerName = documents[index]['officerName'];
               
                var userIdCustomer= documents[index]["userIdCustomer"];
                var customerName = documents[index]["customerName"];
                 var sendApprovalDateTime = documents[index]["sendApprovalDateTime"];
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
                        
                              title: Text("${officerName} ---  choose  ${name}   " ), 
                             
                              subtitle:Text(" " ), 
                            ),
                                        
                       
                                        ElevatedButton(
                        onPressed: () async{
                    
           ;       
     

  
      
                        
                        },
                        child: 
                   
                        Text('Approve')
                       
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
