import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solaris/admin/netMeteringProcedure.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/controllers/netMeteringOfficerController.dart';
import 'package:solaris/models/authentication_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solaris/screens/test.dart';
import '../models/user_model.dart';

class OfficerSendForApproval extends StatefulWidget {
  @override
  State<OfficerSendForApproval> createState() => _OfficerSendForApprovalState();
}

class _OfficerSendForApprovalState extends State<OfficerSendForApproval> {
 
List<TextEditingController> _controllers = [];
List<bool> _checkBoxStates = [];
  List<TextEditingController> _textControllers = [];
// List<String> _textValues = [];
// List<String> _textValuesPayment = [];

  String _selectedValue = '';
  bool  _isButtonVisible =  false;
   
 void openBottomSheet(BuildContext context,String id,String name) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StreamBuilder<QuerySnapshot>(
          stream:  FirebaseFirestore.instance
                              .collection('netMeteringSteps').snapshots(),
                              
               
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
      
            final records = snapshot.data!.docs;
           
//             records.forEach((element) { 
//  print(element["name"]);
//       if(element["name"] == ) 
//             });
            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                if(_controllers.isEmpty){
                 _controllers = List.generate(
     records.length,
      (index) => TextEditingController(),
    );
    }
    //  _checkBoxStates = List<bool>.filled(records.length, false);
    if(_textControllers.isEmpty){
    _textControllers = List.generate(
      records.length,
      (index) => TextEditingController(),
    );
    }

    print("text"+_controllers.length.toString());
    print("here-----");
    print("controller ${_textControllers.length}");

                final fieldValue = records[index]['name'];
                // final bool isButtonVisible = fieldValue == 'visible';
                return Column(
                  children: [
        
                    ListTile(
                      
                      title: Text(fieldValue),
                      subtitle: Column(
                        children: [
                          
                          TextFormField(
             controller: _controllers[index],
            
              decoration: const InputDecoration(
                    hintText: 'Enter description (optional)',
              ),
            ),

                        TextFormField(
             controller: _textControllers[index],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter Price (optional)',
              ),
            ),
                        ],
                      ),
                      trailing:    GestureDetector(
              onTap: ()async {
                print("here");
                debugPrint(_controllers[index].text);
                debugPrint(_textControllers[index].text);
//  await NetMeteringOfficerController.prepaid(userid,fieldValue);
                    try{
                      EasyLoading.show();

 final usersRef = await FirebaseFirestore.instance.collection('users');
 await usersRef.doc(id).collection("netMeteringProcedure").add({
  "name":fieldValue,
  "approved":false,
  "officerName":userController.userName,
  "description":_controllers[index].text,
  "payment":_textControllers[index].text,
  "customerName":name,
  "pdfUrl":"",
  "userIdCustomer":id,
  "sendApprovalDateTime":DateTime.now(),
  });
  _controllers[index].text  = "";
  _textControllers[index].text  = "";
  EasyLoading.dismiss();
  }catch(e){
      _controllers[index].text  = "";
  _textControllers[index].text  = "";
 Get.snackbar("Error", "Issue in updating ${e}");
  EasyLoading.dismiss();
  }



                               

                        Navigator.pop(context);
                    // Perform an action when the button is pressed
                    // print('Button pressed!');
              },
              child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
              ),
            ) ,
                      // onTap: () async{
                       
                      
                         
   
                                
                                   
                                  
  
                      // },
                    ),
                  ],
                );
                
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _textControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;
     
    return Scaffold(
      appBar: AppBar(
        title: Text('Send For Approval'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
  SizedBox(height: halfHeight * 0.1),
               Text(
                'Send For Approval',
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
                              .collection('users').where("role",isEqualTo: "customer").where("netMetering",isEqualTo: true).snapshots(),
                             
               
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
                         
                              
                 return     Column(
                   children: [
 
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
                                  
                                  title: Text("This Customer ${name} is on netMetering procedure  " ), 
                                  // trailing:Text("${status}",style: TextStyle(color: Colors.green),) ,
                                  // subtitle:Text("Complaint received from ${ids} " ), 
                                ),
                                  ElevatedButton(
                onPressed: () {
                  
                  // Open the bottom sheet passing the field data
                   openBottomSheet(context,userid,name);
                },
                child: Text('Select Procedure'),
              ),
                             
                                 
                                  
                                  
                            
                                               
                                                  
                          
                                         
                                            
                                            
                              ],
                            ),
                          ),
                        ),
                   ],
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
