import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solaris/controllerRef.dart';
import 'dart:io';
class BigImageScreen extends StatefulWidget {
  final String imagePath;
  final String id;
  final String name;
  final String assignedTo;

  BigImageScreen({required this.imagePath, required this.id, required this.name,required this.assignedTo});

 
  @override
  State<BigImageScreen> createState() => _BigImageScreenState();
}
 String _selectedValue = '';
  bool  _isButtonVisible =  false;

void openBottomSheet(BuildContext context,String id) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StreamBuilder<QuerySnapshot>(
          stream:  FirebaseFirestore.instance
                              .collection('users')
                              .where('role', isEqualTo:"electrician" )
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
                // final bool isButtonVisible = fieldValue == 'visible';
                return ListTile(
                  title: Text(fieldValue),
                  onTap: () async{

                   
                      siteEngineerController.selectedValue = fieldValue;
                       siteEngineerController.update();   
                  
                    
                     DocumentSnapshot<Object?>? selectedDoc = records.firstWhere(
                             (doc) => doc['name'] == siteEngineerController.selectedValue,);
  if (selectedDoc != null) {
   
                              userController.selectedUserId = selectedDoc['id'] as String;
                              print(userController.selectedUserId);
                              userController.update();
                             userController.selectedName = selectedDoc['name'] as String;
                               print(userController.selectedName);
                                    userController.update();
                               
                              
  try{
 final usersRef = await FirebaseFirestore.instance.collection('complaint');
 await usersRef.doc(id).update({"assignedTo":userController.selectedName});
  }catch(e){
 Get.snackbar("Error", "Issue in updating ${e}");
  }



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
class _BigImageScreenState extends State<BigImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Description'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Container(
              width: 200, // Adjust the width as needed
              height: 200, // Adjust the height as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(widget.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Text(
            //   'ID: ${widget.id}',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: 10),
            Text(
              'Description: ${widget.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
               ElevatedButton(
                onPressed: () {
                  // Open the bottom sheet passing the field data
                   openBottomSheet(context,widget.id);
                },
                child: Text('Select Electrician'),
              ),
                                      // widget.assignedTo == ""?
                                      //    Text("Select Electrican First"):
                                      //    Text("Selected electrician is ${widget.assignedTo}"),  
          ],
        ),
      ),
    );
  }
}
