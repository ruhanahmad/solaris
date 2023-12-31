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
 
Future<void>? _showAlertDialog(BuildContext context,bool net,String name,String userid) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return 

      AlertDialog(
        title: Text("Net Metering Customers "),
        actions: [
    net == false ? 
     SizedBox(
                                      width: 190.0,
                                      height: 40.0,
                                      child: ElevatedButton(
                                        onPressed: () async{
                      
                               
                      
                                 
                                          // print("object ${ids}");
                                           try{
                                            // var n=0;
                      
                         final usersRef = await FirebaseFirestore.instance.collection('users');
                         await usersRef.doc(userid).update({'netMetering':true,"FirstStepDateTime":DateTime.now(),"inProcess":"notStarted"});
                        //  await usersRef.doc(ids).collection("netMeteringProcedure").add({"name":"","approved":false,"netMeteringOfficerName":""});
                        //  await usersRef.doc(userid).collection("netMeteringProcedure").add({"name":"net Metering",});
                         await usersRef.doc(userid).collection("netMeteringProcedure").add({
                        "name":"File Created",
                        "approved":true,
                        "officerName":userController.userName,
                        "description":"",
                        "payment":"",
                        "customerName":name,
                        "pdfUrl":"",
                        "userIdCustomer":userid,
                        "sendApprovalDateTime":DateTime.now(),
                        "noted":false,
                        "approvalDateTimeFinance":"",
                        "sentForApproval":true,
                        "finishedDateTime":DateTime.now(),
                        "nonPaymentCounter":0,
                        "paymentCounter":0,
                        });
                        }
                        catch(e){
                         Get.snackbar("Error", "Issue in updating ${e}");
                        }
                                    Navigator.pop(context);
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
                                    )
                                    
                                    :Text("Added")
                                    
        ],
      );
  
    },
  );
}

late List<QueryDocumentSnapshot> _initialData;
  List<QueryDocumentSnapshot> _filteredData = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }
    final TextEditingController _searchController = TextEditingController();

  Future<void> fetchInitialData() async {
    final snapshot = await 
   // usersCollection.where('role', isEqualTo: 'customer').where("netMetering",isEqualTo: true).get();
   FirebaseFirestore.instance.collection('users').where("role",isEqualTo: "customer").get();
    setState(() {
      _initialData = snapshot.docs;
      _filteredData = _initialData;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
List<QueryDocumentSnapshot> filterData(String searchQuery) {
  return _initialData.where((document) {
    final name = document['name'].toString().toLowerCase();
    final id = document['customerId'].toString().toLowerCase(); // Assuming 'id' is the field for ID

    return name.contains(searchQuery.toLowerCase()) || id.contains(searchQuery.toLowerCase());
  }).toList();
}

   

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;
     
    return Scaffold(
      appBar: AppBar(
        title: Text('Net Metering Customers'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
  SizedBox(height: halfHeight * 0.1),
            //  Text(
            //   'NetMetering Steps',
            //   style: TextStyle(
            //     color: Colors.green,
            //     fontSize: 24.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
              _filteredData = filterData(_searchQuery);
            });
          },
          decoration: InputDecoration(
            hintText: 'Search by name or id',
          ),
        ),
        SizedBox(height: 16.0),
            SizedBox(height: halfHeight * 0.1),


            Expanded(
              child:
               _filteredData.isEmpty
              ? Text('No data available.')
              :
              
               ListView.builder(
               itemCount: _filteredData.length,
               itemBuilder: (context,index){
                  final document = _filteredData[index];
                  //  var ids = documents.first.id;
                  // var name = documents[index]['name'];
                  // var netMetering = documents[index]['netMetering'];
                  // var userid = documents[index]['id'];
                  // var token = documents[index]["token"];
            
                  //   var inProcess = documents[index]["inProcess"];
                  
                 //  adminController.id = documents[index]['id'];
                 //  adminController.update();
               
                         // adminController.name = documents[index]['name'];  
                         //   adminController.update();     
                         
                 return     
                 Padding(
                 padding: const EdgeInsets.all(4.0),
                 child: GestureDetector(
                   onTap: () async{
                   await   _showAlertDialog(context,document["netMetering"],document["name"],document["id"]);
                   },
                   child: Column(
                     children: [
                       Container(
                         height: 70,
                          decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.green.withOpacity(0.2),
                                        ),
                         child: Center(child: Column(
                           children: [
                             Column(
                               children: [
                                 Text("Customer Name : ${document["name"]}",style: TextStyle(fontSize: 20), ),
                                 Text("${document["inProcess"]}")
                               ],
                             ),
                             document["netMetering"] == false ?
                       Text("") 
                       :
                       Text("Added")
                           ],
                         )),
                       ),
                       
                     ],
                   ),
                 ),
               );
               }),
            ),

  // StreamBuilder<QuerySnapshot>(
  //              stream:  
  //                          FirebaseFirestore.instance
  //                             .collection('users').where("role",isEqualTo: "customer").snapshots(),
                           
             
  //              builder: (context, snapshot) {
  //                if (!snapshot.hasData) {
  //                  return CircularProgressIndicator();
  //                }
      
  //                final documents = snapshot.data!.docs;
      
             
      
  //                return
  //                Container(
  //                 height:MediaQuery.of(context).size.height -300,
  //                 width: MediaQuery.of(context).size.width,
  //                  child: 
  //                  ListView.builder(
  //                   itemCount: snapshot.data!.docs.length,
  //                   itemBuilder: (context,index){
  //                       var ids = documents.first.id;
  //                      var name = documents[index]['name'];
  //                      var netMetering = documents[index]['netMetering'];
  //                      var userid = documents[index]['id'];
  //                      var token = documents[index]["token"];

  //                        var inProcess = documents[index]["inProcess"];
                     
  //                     //  adminController.id = documents[index]['id'];
  //                     //  adminController.update();
             
  //                             // adminController.name = documents[index]['name'];  
  //                             //   adminController.update();     
                            
  //                return     
  //                Padding(
  //                     padding: const EdgeInsets.all(4.0),
  //                     child: GestureDetector(
  //                       onTap: () async{
  //                       await   _showAlertDialog(context,netMetering,name,userid);
  //                       },
  //                       child: Column(
  //                         children: [
  //                           Container(
  //                             height: 70,
  //                              decoration: BoxDecoration(
  //                                              borderRadius: BorderRadius.circular(10),
  //                                              color: Colors.green.withOpacity(0.2),
  //                                            ),
  //                             child: Center(child: Column(
  //                               children: [
  //                                 Column(
  //                                   children: [
  //                                     Text("Customer Name : ${name}",style: TextStyle(fontSize: 20), ),
  //                                     Text("${inProcess}")
  //                                   ],
  //                                 ),
  //                                 netMetering == false ?
  //                           Text("") 
  //                           :
  //                           Text("Added")
  //                               ],
  //                             )),
  //                           ),
                          
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                   }),
  //                );
            
  //              },
  //            ),





           
   

        ],
      ),
    );
  }
}
