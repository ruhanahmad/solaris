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

class AddSteps extends StatefulWidget {
  @override
  State<AddSteps> createState() => _AddStepsState();
}

class _AddStepsState extends State<AddSteps> {
 final TextEditingController _nameController = TextEditingController();
  final TextEditingController _complaintController = TextEditingController();
  
AuthenticationService auths = Get.put(AuthenticationService());
  TextEditingController _textEditingController = TextEditingController();
   TextEditingController _textEditingControllerOne = TextEditingController();
  bool _isErrorVisible = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    _textEditingControllerOne.dispose();
    super.dispose();
  }






  void _validateAndSubmit() {
    setState(() {
      _isErrorVisible = _textEditingController.text.isEmpty;
      _isErrorVisible = _textEditingControllerOne.text.isEmpty;
    });

    if (!_isErrorVisible) {

     EasyLoading.show();
     try{
 FirebaseFirestore.instance.collection("netMeteringSteps").add({
           
               
                "name":_textEditingController.text,
                "id":_textEditingControllerOne.text,

                
               

           });
           EasyLoading.dismiss();
           Navigator.pop(context);
     }catch(e){
EasyLoading.dismiss();

     }
          
     EasyLoading.dismiss();
   
    }
  }
Future<void> _deleteDocument(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('netMeteringSteps')
          .doc(documentId)
          .delete();
      print('Document deleted successfully');
    } catch (error) {
      print('Error deleting document: $error');
    }
  }


  Future<void> _Update(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('netMeteringSteps')
          .doc(documentId).update({"id":_textEditingControllerOne.text,"name":_textEditingController.text,});
      print('Document deleted successfully');
    } catch (error) {
      print('Error deleting document: $error');
    }
  }
  
    Future<void>? alerts(){
    showDialog(context: context, builder: (context){
      return     AlertDialog(
        content: 
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          Text("Add NetMetering Steps"),
            SizedBox(height: 20,),
            TextFormField(
              controller: _textEditingControllerOne,
            keyboardType: TextInputType.number,
              decoration: InputDecoration(
                
                labelText: 'Enter Step Id',
                errorText: _isErrorVisible ? 'Text cannot be empty' : null,
              ),
            ),
            SizedBox(height: 16.0),
              TextFormField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter Step Name',
                errorText: _isErrorVisible ? 'Text cannot be empty' : null,
              ),
            ),
             SizedBox(height: 16.0),
            ElevatedButton(
              onPressed:() 
              {
 _validateAndSubmit();
              },
              
          
              child: Text('Submit'),
            ),
      
          ],
        ),
      );
    });
  }





    Future<void>? alertsonly(String id,String name ,String ud){
      _textEditingController.text = name;
      _textEditingControllerOne.text = ud;
    showDialog(context: context, builder: (context){
      return     AlertDialog(
        content: 
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          Text("Add NetMetering Steps"),
            SizedBox(height: 20,),
            TextFormField(
              controller: _textEditingControllerOne,
            keyboardType: TextInputType.number,
              decoration: InputDecoration(
                
                labelText: 'Enter Step Id',
                errorText: _isErrorVisible ? 'Text cannot be empty' : null,
              ),
            ),
            SizedBox(height: 16.0),
              TextFormField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter Step Name',
                errorText: _isErrorVisible ? 'Text cannot be empty' : null,
              ),
            ),
             SizedBox(height: 16.0),
            ElevatedButton(
              onPressed:() 
              {
  _Update(id);
              },
              
          
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
        title: Text('Add Net Metering Steps'),
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
                              .collection('netMeteringSteps').snapshots(),
                             
               
               builder: (context, snapshot) {
                 if (!snapshot.hasData) {
                   return CircularProgressIndicator();
                 }
      
                 final documents = snapshot.data!.docs;
      
               
      
                 return
                 Container(
                  height:MediaQuery.of(context).size.height -300 ,
                  width: MediaQuery.of(context).size.width,
                   child: 
                   ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){
                        var ids = documents[index].id;
                       var name = documents[index]['name'];
                       var ud = documents[index]["id"];
               
                                       
                              
                 return     Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                         decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: Colors.green.withOpacity(0.2),
                   ),
                        child: 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("${ud}"),
                                SizedBox(width: 20,),
                                  Text("${name} " ),
                              ],
                            ),
                           
                             Row(
                               children: [
                                 IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteDocument(ids);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      alertsonly(ids,name,ud);
                    },
                  ),
                               ],
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
