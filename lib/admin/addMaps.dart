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
import 'package:url_launcher/url_launcher.dart';
import '../models/user_model.dart';

class AddMaps extends StatefulWidget {
  @override
  State<AddMaps> createState() => _AddMapsState();
}

class _AddMapsState extends State<AddMaps> {
 final TextEditingController _nameController = TextEditingController();
  final TextEditingController _complaintController = TextEditingController();
  
AuthenticationService auths = Get.put(AuthenticationService());
  TextEditingController _textEditingController = TextEditingController();
    TextEditingController _textEditingControllerTwo = TextEditingController();
     TextEditingController _textEditingControllerXAxis = TextEditingController();
      TextEditingController _textEditingControllerYAxis = TextEditingController();
  bool _isErrorVisible = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    _textEditingControllerXAxis.dispose();
    _textEditingControllerYAxis.dispose();
    super.dispose();
  }
  void navigateToMarker(double latitude, double longitude) async {
    final String googleMapsUrl = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }
  void _validateAndSubmit() {
    setState(() {
      _isErrorVisible = _textEditingController.text.isEmpty;
      _isErrorVisible = _textEditingControllerXAxis.text.isEmpty;
      _isErrorVisible = _textEditingControllerYAxis.text.isEmpty;
    });

    if (!_isErrorVisible) {

     EasyLoading.show();
     try{
 FirebaseFirestore.instance.collection("location").add({
           
               
                "name":_textEditingController.text,
                "XAxis":double.parse(_textEditingControllerXAxis.text),
                "YAxis":double.parse(_textEditingControllerYAxis.text),
                 

                
               

           });
           EasyLoading.dismiss();
     }catch(e){
EasyLoading.dismiss();

     }
          
     EasyLoading.dismiss();
   
    }
  }
Future<void> _deleteDocument(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('location')
          .doc(documentId)
          .delete();
      print('Document deleted successfully');
    } catch (error) {
      print('Error deleting document: $error');
    }
  }
  
    Future<void>? alerts(){
    showDialog(context: context, builder: (context){
      return     AlertDialog(
        content: new
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          Text("Add location"),
            SizedBox(height: 20,),
            TextFormField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter some text',
                errorText: _isErrorVisible ? 'Text cannot be empty' : null,
              ),
            ),
             TextFormField(
              controller: _textEditingControllerXAxis,
              decoration: InputDecoration(
                labelText: 'X-axis Coordinates',
                errorText: _isErrorVisible ? 'Text cannot be empty' : null,
              ),
            ),
            TextFormField(
              controller: _textEditingControllerYAxis,
              decoration: InputDecoration(
                labelText: 'Y- axis Coordinates',
                errorText: _isErrorVisible ? 'Text cannot be empty' : null,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _validateAndSubmit,
              child: Text('Submit'),
            ),
      
          ],
        ),
      );
    });
  }




  var selectedValues;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;
     
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Location'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        
        onPressed:(){
        alerts();
      } ),
      body: SingleChildScrollView(
        child: Column(
          children: [
  SizedBox(height: halfHeight * 0.1),
               Text(
                'Add Location',
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
                              .collection('location').snapshots(),
                             
               
               builder: (context, snapshot) {
                 if (!snapshot.hasData) {
                   return CircularProgressIndicator();
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
                        var ids = documents.first.id;
                       var name = documents[index]['name'];
                         var XAxis = documents[index]['XAxis'];
                            var YAxis = documents[index]['YAxis'];

               
                                       
                              
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
                              leading: IconButton(
                    icon: Icon(Icons.location_city),
                    onPressed: () {
                      navigateToMarker(XAxis, YAxis);
                    },
                  ) ,
                              title: Text("${name} " ), 
                            trailing: 
                            IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                       _deleteDocument(ids);
                    },
                  ),
                            ),

                                        
                       
                                     
                                        
                                        
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
