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

class CustomerApproval extends StatefulWidget {
  @override
  State<CustomerApproval> createState() => _CustomerApprovalState();
}

class _CustomerApprovalState extends State<CustomerApproval> {
  Future validateAndSubmit(String customerId,String customerName,String id) async{

     EasyLoading.show();
     try{
      var emailGenerated = await userController.emailNumberGenerated();
   
   userController.update();
   // await   userController.createUserWithEmailAndPassword(userController.referalEmail,userController.referalName,userController.customerIdss,userController.referalCity,userController.referalPhoneNumber,userController.referalDescription,userController.googleLocation,selectedOption,context);
//  await   userController.createUserWithEmailAndPassword("${customerName}${emailGenerated}@solaris.com",customerName,customerId,context);
   await   salesPersonController.notedFinance(id);
 

           EasyLoading.dismiss();
     }catch(e){
EasyLoading.dismiss();

     }
          
     EasyLoading.dismiss();
   
    // }
  }
 
 



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;
     
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Approval'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
  SizedBox(height: halfHeight * 0.1),
               Text(
                'Customer Approval',
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
                              .collection('ReferalCustomers').
                              where("sendForApproval",isEqualTo:true).snapshots(),
               
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
                                var description = documents[index]["Description"];
                                        var userId = documents[index]["userid"];
                                        var PickBy = documents[index]["PickBy"];
                                        var referedBy = documents[index]["referedBy"];
                                        var customerId = documents[index]["customerId"];
                                        var sendForApproval = documents[index]["sendForApproval"];
                                        var notedByFinance = documents[index]["notedByFinance"];
                              
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
                              subtitle:notedByFinance ==  false ? Text("Customer from ${ids} " ) :Text("Customer is approved"),
                            ),
                                        
                       
                                notedByFinance == false ?
                                   ElevatedButton(
                        onPressed: () async{
                  // sendNotification();
                  // await alerts(customerId,cusName,ids);
                    
                  await    validateAndSubmit(customerId,cusName,ids);
    // await  salesPersonController.updateToken(ids,userController.userName!);
                //  Get.to(()=>NotificationOpenedHandler()); 
                          print('Button Pressed!');
                        },
                        child: Text('Create Customer'),
                                        )
                                        : 
                                       
     Text("Created Successfully"),

    //                                                            ElevatedButton(
    //                     onPressed: () async{
    //               // sendNotification();
    // await  salesPersonController.updateToken(ids,userController.userName!);
    //             //  Get.to(()=>NotificationOpenedHandler()); 
    //                       print('Button Pressed!');
    //                     },
    //                     child: Text('Add to Customer'),
    //                                     )
                                      
                                        
                                        
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
