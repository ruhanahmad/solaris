import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/models/authentication_service.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_model.dart';

class RequestFormNetMetering extends StatefulWidget {
  @override
  State<RequestFormNetMetering> createState() => _RequestFormNetMeteringState();
}

class _RequestFormNetMeteringState extends State<RequestFormNetMetering> {
 final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  
// AuthenticationService auths = Get.put(AuthenticationService());

  Future submitApproval() async{
                        try{
                      EasyLoading.show();

 final usersRef = await FirebaseFirestore.instance.collection('users');
 await usersRef.doc(userController.selectedUserId).collection("netMeteringProcedure").add({
  "name":selectedNetMeteringStep,
  "approved":false,
  "officerName":userController.userName,
  "description":_descriptionController.text ??"",
  "payment":_priceController.text ?? "",
  "customerName":_selectedValue,
  "pdfUrl":"",
  "userIdCustomer":userController.selectedUserId,
  "sendApprovalDateTime":DateTime.now(),
  "noted":false,
  "approvalDateTimeFinance":"",
  "sentForApproval":false,
  });
  _descriptionController.text  = "";
  _priceController.text  = "";

    

  //   final usersRefs = await FirebaseFirestore.instance.collection('reviews').add({
  // "name":fieldValue,

  // "officerName":userController.userName,
 
  // "customerName":name,
  // "userIdCustomer":id,
  // "sendApprovalDateTime":DateTime.now(),

  // });


 Get.snackbar("Procedure Submitted", "Submitted.");



  EasyLoading.dismiss();
  }catch(e){
      _descriptionController.text  = "";
  _priceController.text  = "";
 Get.snackbar("Error", "Issue in updating ${e}");
  EasyLoading.dismiss();
  }


  }



 void _onButtonPressed(BuildContext context,String id) {
    // When the button is pressed, run the function to compare the streams and show the bottom sheet
    compareAndShowBottomSheet(context,id);
  }

  Stream<List<String>> getFirstCollectionData() {
    // Replace 'firstCollection' with the name of your first collection in Firestore
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('netMeteringSteps');

    return collectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  Stream<List<String>> getSecondCollectionData(String documentId) {
    // Replace 'secondCollection' and 'subCollection' with the names of your second collection and subcollection in Firestore
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .collection('netMeteringProcedure');

    return collectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  void compareAndShowBottomSheet(BuildContext context,String id) {
    Stream<List<String>> firstStream = getFirstCollectionData();

    firstStream.listen((firstNames) {
      // Replace 'documentId' with the ID of the document you want to retrieve from the second collection
      Stream<List<String>> secondStream =
          getSecondCollectionData(id);

      secondStream.listen((secondNames) {
        List<String> namesNotPresent = [];

        for (var name in firstNames) {
          if (!secondNames.contains(name)) {
            namesNotPresent.add(name);
          }
        }

        if (namesNotPresent.isNotEmpty) {
          // Show the bottom sheet with the names not present in the second stream
          _showBottomSheet(context, namesNotPresent);
        }
      });
    });
  }
var selectedNetMeteringStep = "";
  void _showBottomSheet(BuildContext context, List<String> names) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Center(
            child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(names[index]),
                  onTap: () {
                    setState(() {
                 selectedNetMeteringStep   =   names[index];
                 print(selectedNetMeteringStep);
                    });
                        Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  
 
 
  String _selectedValue = '';
 void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StreamBuilder<QuerySnapshot>(
          stream:  FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo:"customer" )
        .snapshots(),
               
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            final records = snapshot.data!.docs;
            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final fieldValue = records[index]['name'];
                return ListTile(
                  title: Text(fieldValue),
                  onTap: () {
                    setState(() {
                      _selectedValue = fieldValue;
                    });
                     DocumentSnapshot<Object?>? selectedDoc = records.firstWhere(
                             (doc) => doc['name'] == _selectedValue,);
  if (selectedDoc != null) {
   
                              userController.selectedUserId = selectedDoc['id'] as String;
                              print(userController.selectedUserId);
                              userController.update();
                             userController.selectedName = selectedDoc['name'] as String;
                               print(userController.selectedName);
                                    userController.update();

                                      userController.selectedCustomerId = selectedDoc['customerId'] as String;
                               print(userController.selectedCustomerId);
                                    userController.update();
                     
                           }

                    Navigator.pop(context);
                  },
                );
                
              },
            );
          },
        );
      },
    );
  }


  var selectedValues;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;
     
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Form'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
          SizedBox(height: halfHeight * 0.1),
               
              StreamBuilder<QuerySnapshot>(
                 stream:  FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo:"customer" )
          .snapshots(),
                 
                 builder: (context, snapshot) {
                   if (!snapshot.hasData) {
                     return CircularProgressIndicator();
                   }
              
                   List<DocumentSnapshot> documents = snapshot.data!.docs;
                  
                   List<String> names = documents.map((doc) => doc['name'] as String ).toList() ;
          String fieldData = documents.first['name'];
                   return Column(
                     children: [
                     ElevatedButton(
                  onPressed: () {
                    // Open the bottom sheet passing the field data
                     openBottomSheet(context);
                  },
                  child: Text('Select Customer'),
                ),
  ElevatedButton(
                  onPressed: () {
                    // Open the bottom sheet passing the field data
                _selectedValue == ""? null:     _onButtonPressed(context,userController.selectedUserId!);
                  },
                  child: Text('Net Metering Steps'),
                ),
 SizedBox(height: 15,),
 TextFormField(
                //   onChanged: (value) {
                //   userController.complaint = value;
                // },
                controller: _descriptionController ,
                // maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.green.withOpacity(0.2),
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.message, color: Colors.green),
                ),
                style: TextStyle(color: Colors.green),
              ),

              SizedBox(height: 15,),
               TextField(
                //   onChanged: (value) {
                //   userController.complaint = value;
                // },
                controller: _priceController ,
                // maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.green.withOpacity(0.2),
                  hintText: 'Price',
                  hintStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.message, color: Colors.green),
                ),
                style: TextStyle(color: Colors.green),
              ),

                
           _selectedValue == "" ?     Text("Customer Name :No Customer Selected"):Text("Customer Name ${_selectedValue}"),
                     
                     ],
                   );
                 },
               ),
        
          
        
               
            Container(
            height: mediaQuery.size.height,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
          
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               
        
        
          _selectedValue != "" && selectedNetMeteringStep != "" ?
                SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: ElevatedButton(
                    onPressed: () async{
                // bool? scene =  await  userController.checkIfCustomerExsist();
                // scene ==  true ?
        
                // Get.snackbar("Complaint", "Complaint already registered.")
                // :
                
 await  submitApproval();
 
               
//  await NetMeteringOfficerController.prepaid(userid,fieldValue);


                               

                       
                 
                    },
                    child: Text(
                      'Submit Complaint',
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
                ):Text('Select Customer First'),
              ],
            ),
          ),
        
            ],
          ),
        ),
      ),
    );
  }


}
