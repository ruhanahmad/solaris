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

  Stream<QuerySnapshot>? _recordsStream;

  void _fetchRecords() {
    setState(() {
      // Set up a Firestore query to fetch records from your collection
      _recordsStream = FirebaseFirestore.instance.collection('netMeteringSteps').snapshots();
    });

    showModalBottomSheet(
            context: context,
            builder: (context) {

              return 
              //RecordListBottomSheet(recordsStream: _recordsStream);
              Container(
      padding: EdgeInsets.all(16.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: _recordsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No records available.');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final document = snapshot.data!.docs[index];
                final data = document.data() as Map<String, dynamic>;

                // Display your record data in ListTile or other widgets as needed
                return ListTile(
                  title: Text(data['name']), // Replace with your data fields
                  onTap: () {
                    // Store the selected value in a variable here
                     userController.selectedValueForReview = data['name'];
                       userController.update();
                    print(userController.selectedValueForReview);
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                );
              },
            );
          }
        },
      ),
    );
            },
          );
     }

     bool isEditing= false;
 
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
      icon: Icon(Icons.filter_2_sharp),
      onPressed: () {
    setState(() {
      isEditing == false ? isEditing =true:isEditing = false;
      print(isEditing);
    });
      }
    ),    
    isEditing == true ?
                Row(
                  children: [
                    IconButton(
      icon: Icon(Icons.calendar_today),
      onPressed: () => _selectStartDate(context),
    ),
    IconButton(
      icon: Icon(Icons.calendar_today),
      onPressed: () => _selectEndDate(context),
    ),
    Center(
        child: ElevatedButton(
          onPressed: 
          (){
    _fetchRecords();
          },
      
          child: Text('Fetch Records'),
        ),
      ),
                  ],
                ):
                Container()
                ,

     
              ],
            ),
   
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
//here to add all logic

  StreamBuilder<QuerySnapshot>(
               stream:  
               isEditing == true?
                           FirebaseFirestore.instance
                              .collection('reviews')
                              .where("officerName",isEqualTo: widget.name)
                              .where("name",isEqualTo:userController.selectedValueForReview)
                              .where("sendApprovalDateTime",isGreaterThanOrEqualTo:selectedStartDate ).where("sendApprovalDateTime",isLessThan: selectedEndDate)
                              .snapshots()
                              :
                               FirebaseFirestore.instance
                              .collection('reviews')
                              .where("officerName",isEqualTo: widget.name)
                             
                              .snapshots()
                              
                              ,
               
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
                             
                            //  subtitle:Text(" " ), 
                            ),
                                        
                       
          //                               ElevatedButton(
          //               onPressed: () async{
                    
          //  ;       
     

  
      
                        
          //               },
          //               child: 
                   
          //               Text('Approve')
                       
          //               ,
          //                               )
                                        
                                        
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

    DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
        print(selectedStartDate);
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
      });
    }
  }
}



// class RecordListBottomSheet extends StatelessWidget {
//   final Stream<QuerySnapshot>? recordsStream;

//   RecordListBottomSheet({this.recordsStream});

//   @override
//   Widget build(BuildContext context) {
//     return 
    
    
//   }
// }
