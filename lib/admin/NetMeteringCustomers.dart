import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solaris/admin/netMeteringProcedure.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/models/authentication_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solaris/screens/test.dart';
import '../models/user_model.dart';

class NetMeteringCustomers extends StatefulWidget {
  @override
  State<NetMeteringCustomers> createState() => _NetMeteringCustomersState();
}

class _NetMeteringCustomersState extends State<NetMeteringCustomers> {
 


   

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;
     
    return Scaffold(
      appBar: AppBar(
        title: Text('Net Metering Customers'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
  SizedBox(height: halfHeight * 0.1),
               Text(
                'NetMetering Steps',
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
                              .collection('users').where("role",isEqualTo: "customer").snapshots(),
                             
               
               builder: (context, snapshot) {
                 if (!snapshot.hasData) {
                   return CircularProgressIndicator();
                 }
      
                 final documents = snapshot.data!.docs;
      
               
      
                 return
                 Container(
                  height:MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                   child: 
                   ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){
                        var ids = documents.first.id;
                       var name = documents[index]['name'];
                       var netMetering = documents[index]['netMetering'];
                       var userid = documents[index]['id'];
                      //  adminController.id = documents[index]['id'];
                      //  adminController.update();
               
                              // adminController.name = documents[index]['name'];  
                              //   adminController.update();     
                              
                 return     Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                         decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(10),
                                         color: Colors.green.withOpacity(0.2),
                                       ),
                        child: Column(
                          children: [
                                 
                         
                         
                            
                              
                               Text("Customer Name : ${name}",style: TextStyle(fontSize: 20), ), 
                        
                                           
                                              
                         netMetering == false ? 
                          SizedBox(
                                    width: 190.0,
                                    height: 40.0,
                                    child: ElevatedButton(
                                      onPressed: () async{
                                        print("object ${ids}");
                                         try{
                       final usersRef = await FirebaseFirestore.instance.collection('users');
                       await usersRef.doc(userid).update({'netMetering':true,});
                      //  await usersRef.doc(ids).collection("netMeteringProcedure").add({"name":"","approved":false,"netMeteringOfficerName":""});
                       await usersRef.doc(userid).collection("netMeteringProcedure").add({});
                      }catch(e){
                       Get.snackbar("Error", "Issue in updating ${e}");
                      }
                                  
                                      },
                                      child: Text(
                                        'Add to Net Metering',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                                        ),
                                      ),
                                    ),
                                  ):

   SizedBox(
                                    width: 190.0,
                                    height: 40.0,
                                    child: ElevatedButton(
                                      onPressed: () async{
                                  Get.to(()=>netMeteringProcedure(id:userid,name:name));
                                  
                                      },
                                      child: Text(
                                        'See The procedure',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                                        ),
                                      ),
                                    ),
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
