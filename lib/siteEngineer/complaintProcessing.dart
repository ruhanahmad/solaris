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

class ComplaintScreenProcessing extends StatefulWidget {
  @override
  State<ComplaintScreenProcessing> createState() => _ComplaintScreenProcessingState();
}

class _ComplaintScreenProcessingState extends State<ComplaintScreenProcessing> {
 final TextEditingController _nameController = TextEditingController();
  final TextEditingController _complaintController = TextEditingController();
  
AuthenticationService auths = Get.put(AuthenticationService());

  
    Future<void>? alerts(){
    showDialog(context: context, builder: (context){
      return     AlertDialog(
        content: new
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          
            SizedBox(height: 30,),
            GestureDetector(
              onTap:(){
                // _pickImage(ImageSource.gallery);
                selectImages();
                Navigator.pop(context);
                print("object");
              } ,
              child: Row(
                children: [
                   Icon(Icons.browse_gallery),
       
                            //                Container(
                            // height: 40,
                            // width: 70,
                            // decoration: BoxDecoration(
                            //     color: Colors.black,
                            //     image: DecorationImage(image: AssetImage("assets/3.png"),fit: BoxFit.cover)),),
                  SizedBox(width: 5),
                  Text('Choose from Gallery '),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<void>? _clear() {
    setState(() => _imageFile = null,

    );
  }
   XFile? _imageFile;
    final ImagePicker _picker = ImagePicker();
    var imageFile;
    void  selectImages()async {
    final XFile? images = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {

   _imageFile =  images!;

    });
    
    // if (images !=null) {
    //     userController.imageFile = images.path == null ? "" :images.path;
    // userController.update();
    // }
  
  }




  var selectedValues;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;
     
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Processing'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
  SizedBox(height: halfHeight * 0.1),
               Text(
                'Complaints Received',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: halfHeight * 0.1),

  StreamBuilder<QuerySnapshot>(
               stream:  FirebaseFirestore.instance
        .collection('complaint')
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
                   child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){
                        var ids = documents[index].id;
                       var cusName = documents[index]['customerName'];
                var complaintDescription = documents[index]['complaint'];
                  var status = documents[index]['status'];
                                var image = documents[index]["complaintImage"];
                                var token = documents[index]["token"];
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
                              title: Text("Complaint received from ${cusName}.Description : ${complaintDescription} " ), 
                              trailing:Text("${status}",style: TextStyle(color: Colors.green),) ,
                              subtitle:Text("Complaint received from ${ids} " ), 
                            ),
                                        
                           StreamBuilder<QuerySnapshot>(
                                     stream:  FirebaseFirestore.instance
                              .collection('users')
                              .where('role', isEqualTo:"electrician" )
                              .snapshots(),
                                     
                                     builder: (context, snapshot) {
                                       if (!snapshot.hasData) {
                         return CircularProgressIndicator();
                                       }
                            
                                       List<DocumentSnapshot> documents = snapshot.data!.docs;
                            
                                       List<String> names = documents.map((doc) => doc['name'] as String ).toList() ;
                            
                                       return
                        Container(
                         width: MediaQuery.of(context).size.width /4,
                         child: DropdownButton<String>(
                           value: null, // selected value
                           items: names.map<DropdownMenuItem<String>>((String value) {
                             return 
                             DropdownMenuItem<String>(
                               value: value,
                               child: Text(value),
                             );
                           }).toList(),
                             onChanged: (dynamic selectedName) {
                             String selectedNameString = selectedName as String;
                                       
                               DocumentSnapshot<Object?>? selectedDoc = documents.firstWhere(
                               (doc) => doc['name'] == selectedNameString,
                               // orElse: () => null,
                             );
                             setState(() {
                                selectedValues = selectedDoc;
                             });
                                 
                             if (selectedDoc != null) {
                                userController.selectedUserId = selectedDoc['id'] as String;
                                userController.update();
                               userController.selectedName = selectedDoc['name'] as String;
                                      userController.update();
                                       
                               // Call your other function with the selected user ID and email
                              //  otherFunction(selectedUserId, selectedEmail);
                             }
                           },
                         ),
                                       );
                                     },
                                   ),
                                        ElevatedButton(
                        onPressed: () {
                  userController.sendNotificationToUser( );
                          print('Button Pressed!');
                        },
                        child: Text('Send'),
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
