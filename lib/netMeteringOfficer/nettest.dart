import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/controllers/userController.dart';
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
  _selectedValue == "";


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
    String _searchText = '';
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
            return Column(
              children: [
                 TextField(
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search...',
            ),
          ),
                Expanded(
                  child: ListView.builder(
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
                  ),
                ),
              ],
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
          child:
          
          GetBuilder<UserController>(builder: (controller){
            return  Column(
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
                    showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SearchBottomSheet();
              },
            );
                    // // Open the bottom sheet passing the field data
                    //  openBottomSheet(context);
                  },
                  child: Text('Select Customer'),
                ),
  ElevatedButton(
                  onPressed: () {
                    // Open the bottom sheet passing the field data
                controller.selectedName == ""? null:     _onButtonPressed(context,controller.selectedUserId!);
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

                
         controller.selectedName == "" ?     Text("Customer Name :No Customer Selected"):Text("Customer Name ${controller.selectedName}"),
                     
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
               
        
        
          controller.selectedName != "" && selectedNetMeteringStep != "" ?
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
                      'Submit Request',
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
          );
          })
          
          
        ),
      ),
    );
  }


}


class SearchBottomSheet extends StatefulWidget {
  @override
  _SearchBottomSheetState createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  String selectedCustomerName = '';
  String selectedCustomerId = '';
  String selectedCustomerCustomerId = '';

  void _selectCustomer(QueryDocumentSnapshot customer) {
    userController.selectedName = customer['name'];
    userController.selectedUserId= customer.id;
    userController.selectedCustomerId = customer['customerId'];
    userController.update();

   

    Navigator.of(context).pop(); // Close the bottom sheet
  }
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  final TextEditingController _searchController = TextEditingController();
  late List<QueryDocumentSnapshot> _initialData;
  List<QueryDocumentSnapshot> _filteredData = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    final snapshot = await usersCollection.where('role', isEqualTo: 'customer').get();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
                _filteredData = filterData(_searchQuery);
              });
            },
            decoration: InputDecoration(
              hintText: 'Search by name',
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: _filteredData.isEmpty
                ? Text('No data available.')
                : ListView.builder(
                    itemCount: _filteredData.length,
                    itemBuilder: (context, index) {
                      final document = _filteredData[index];
                      return ListTile(
                         onTap: () {
                          _selectCustomer(document);
                         },
                        title: Text(document['name']),
                        subtitle: Text(document['email']),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  List<QueryDocumentSnapshot> filterData(String searchQuery) {
    return _initialData
        .where((document) =>
            document['name'].toString().toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }
}