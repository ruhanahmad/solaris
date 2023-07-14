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

class ComplaintScreenElectrician extends StatefulWidget {
  @override
  State<ComplaintScreenElectrician> createState() => _ComplaintScreenElectricianState();
}

class _ComplaintScreenElectricianState extends State<ComplaintScreenElectrician> {
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
        title: Text('Complaint'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
  SizedBox(height: halfHeight * 0.1),
               Text(
                'Complaint',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
         _selectedValue == "" ?     Text("Customer Name :No Customer Selected"):Text("Customer Name ${_selectedValue}"),
                    //  Container(
                    //    width: MediaQuery.of(context).size.width /4,
                    //    child: DropdownButton<String>(
                    //      value: null, // selected value
                    //      items: names.map<DropdownMenuItem<String>>((String value) {
                    //        return 
                    //        DropdownMenuItem<String>(
                    //          value: value,
                    //          child: Text(value),
                    //        );
                    //      }).toList(),
                    //        onChanged: (dynamic selectedName) {
                    //        String selectedNameString = selectedName as String;
                     
                    //          DocumentSnapshot<Object?>? selectedDoc = documents.firstWhere(
                    //          (doc) => doc['name'] == selectedNameString,
                    //          // orElse: () => null,
                    //        );
                    //        setState(() {
                    //           selectedValues = selectedDoc;
                    //        });
                               
                    //        if (selectedDoc != null) {
                    //           userController.selectedUserId = selectedDoc['id'] as String;
                    //           userController.update();
                    //          userController.selectedName = selectedDoc['name'] as String;
                    //                 userController.update();
                     
                    //          // Call your other function with the selected user ID and email
                    //         //  otherFunction(selectedUserId, selectedEmail);
                    //        }
                    //      },
                    //    ),
                    //  ),
                   ],
                 );
               },
             ),



             
    Container(
          height: mediaQuery.size.height,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     Colors.green[400]!,
            //     Colors.green[700]!,
            //   ],
            // ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // FlutterLogo(
              //   size: halfHeight * 0.25,
              //   colors: Colors.white,
              // ),
           
           
              // TextField(
              //   onChanged: (value) {
              //     userController.complaintName = value;
              //   },
              //   controller: _nameController,
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: Colors.green.withOpacity(0.2),
              //     hintText: 'Name',
              //     hintStyle: TextStyle(color: Colors.green),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8.0),
              //       borderSide: BorderSide.none,
              //     ),
              //     prefixIcon: Icon(Icons.person, color: Colors.green),
              //   ),
              //   style: TextStyle(color: Colors.green),
              // ),
              // SizedBox(height: 16.0),
              TextField(
                  onChanged: (value) {
                  userController.complaint = value;
                },
                controller: _complaintController ,
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.green.withOpacity(0.2),
                  hintText: 'Complaint',
                  hintStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.message, color: Colors.green),
                ),
                style: TextStyle(color: Colors.green),
              ),
                  SizedBox(height: 24.0),
                   Center(child: GestureDetector(
                onTap: ()async{
                  await alerts();
                },
                 child: Container(height: 30,width: 30,child: IconButton(
                  onPressed: ()async {
                      await alerts();
                  }, 
                 icon: Icon(Icons.upload_file)),),
               ),),
                 if (_imageFile != null) ...[
                            Image.file(
                              width:200,
                              height:200,
                              File(
                                
                                _imageFile!.path)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // ElevatedButton(
                                //   child: Icon(Icons.crop),
                                //   onPressed: _cropImage,
                                // ),
                                ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Color(0xFF9D0105),),
                                  child: Icon(Icons.refresh,),
                                  onPressed: _clear,
                                ),
                             
          
          
                              ],
                            ),
            
                            // Uploader(file: _imageFile)
                          ],
              
              SizedBox(height: 24.0),



        _selectedValue != "" ?
              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton(
                  onPressed: () async{
                    
                                  await       userController.uploadFilesPassport(_imageFile,context);
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
    );
  }


}
