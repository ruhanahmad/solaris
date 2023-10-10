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

class ReferalClients extends StatefulWidget {
  @override
  State<ReferalClients> createState() => _ReferalClientsState();
}

class _ReferalClientsState extends State<ReferalClients> {


 



  var selectedValues;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;
     
    return Scaffold(
      appBar: AppBar(
        title: Text('Clients '),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
  SizedBox(height: halfHeight * 0.1),
               Text(
                'Clients',
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
                              .collection('ReferalCustomers')
                            
                              .snapshots(),
               
               builder: (context, snapshot) {
                 if (!snapshot.hasData) {
                   return CircularProgressIndicator();
                 }
      
                 final documents = snapshot.data!.docs;
      
               
      
                 return
                 Container(
                  height: MediaQuery.of(context).size.height - 300,
                  width: MediaQuery.of(context).size.width,
                   child: 
                   ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){
                        var ids = documents[index].id;
                       var cusName = documents[index]['CustomerName'];
                var customerCity = documents[index]['CustomerCity'];
                  var customerPhone = documents[index]['CustomerPhone'];
                               
                                        var PickBy = documents[index]["PickBy"];
                                        var referedBy = documents[index]["referedBy"];
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
                             
                              title: Text("This is Customer refered by ${referedBy}.Customer Name ${cusName}.Customer City ${customerCity}} .${PickBy == "" ?"NoOne":PickBy} pick that Customer " ), 
                              // trailing: PickBy == "" ? Text("Add to List",style: TextStyle(color: Colors.green),) :  null,
                              subtitle:Text("Customer from ${ids} " ), 
                            ),
                                        
                       
                                 PickBy == "" ?      
                                   ElevatedButton(
                        onPressed: () async{
                  // sendNotification();
    await  salesPersonController.updateToken(ids,userController.userName!);
    
                //  Get.to(()=>NotificationOpenedHandler()); 
                          print('Button Pressed!');
                        },
                        child: Text('Add to leads'),
                                        )
                                        : 
    //                                                            ElevatedButton(
    //                     onPressed: () async{
    //               // sendNotification();
    // await  salesPersonController.updateToken(ids,userController.userName!);
    //             //  Get.to(()=>NotificationOpenedHandler()); 
    //                       print('Button Pressed!');
    //                     },
    //                     child: Text('Add to Customer'),
    //                                     )
                                        Text("${PickBy} pick that Customer ")
                                        
                                        
                          ] ,
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
