import 'dart:io';
// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/models/authentication_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solaris/widgets/textFeild.dart';
import '../models/user_model.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class ReferalScreen extends StatefulWidget {
  @override
  State<ReferalScreen> createState() => _ReferalScreenState();
}

class _ReferalScreenState extends State<ReferalScreen> {
 final TextEditingController _nameController = TextEditingController();
  final TextEditingController _complaintController = TextEditingController();
  
AuthenticationService auths = Get.put(AuthenticationService());
 String selectedOption = ''; 



  


    void submitComplaint(BuildContext context)async {
    
if( userController.referalName == "" || userController.referalCity  == "" || userController.customerIdss == "" || userController.referalPhoneNumber == "" || userController.googleLocation == "") 
{
 Get.snackbar("Error", "Fill the neccassarry field first");

}

else {
     EasyLoading.show();
var scene  =   await userController.tenNumberGenerated();
await   userController.createUserWithEmailAndPassword(userController.referalEmail,userController.referalName,userController.customerIdss,userController.referalCity,userController.referalPhoneNumber,userController.referalDescription,userController.googleLocation,selectedOption,context);
      FirebaseFirestore.instance.collection('ReferalCustomers').add({
         "userid":auths.useri,
         "referedBy":userController.userName,
        'CustomerName': userController.referalName,
        'CustomerCity': userController.referalCity,
        "CustomerPhone":userController.referalPhoneNumber,
        "Description":userController.referalDescription,
        "PickBy":"",
        "customerId":userController.customerIdss,
        "phoneNumber":userController.referalPhoneNumber,
        "googleLocation":userController.googleLocation,
        "email":userController.referalEmail,
        "netMeteringRequired":selectedOption,
        "sendForApproval":false,
        "notedByFinance":false,
        
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Customer Added successfully!')),
        );
         userController.referalCity = "";
        userController.referalName = "";
        userController.referalDescription ="";
         userController.customerIdss = "";
        userController.referalPhoneNumber = "";
        userController.googleLocation = "";
        userController.referalEmail = "";
        selectedOption = "";
         EasyLoading.dismiss();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(' Please try again.')),
        );
          EasyLoading.dismiss();
      });
       EasyLoading.dismiss();
    // }
}

 

    // if (name.isNotEmpty && complaint.isNotEmpty) {
  
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Complaint'),
      //   automaticallyImplyLeading: false,
      // ),
      body: Container(
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
       child: SingleChildScrollView(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             // FlutterLogo(
             //   size: halfHeight * 0.25,
             //   colors: Colors.white,
             // ),
          
          

          
          




             Text(
               'Referal',
               style: TextStyle(
                 color: Colors.green,
                 fontSize: 24.0,
                 fontWeight: FontWeight.bold,
               ),
             ),
             SizedBox(height: halfHeight * 0.1),
                TextField(
               onChanged: (value) {
                 userController.referalName = value;
               },
               // controller: _nameController,
               decoration: InputDecoration(
                 filled: true,
                 fillColor: Colors.green.withOpacity(0.2),
                 hintText: "Name",
                 hintStyle: TextStyle(color: Colors.green),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(8.0),
                   borderSide: BorderSide.none,
                 ),
                 // prefixIcon: Icon(Icons.person, color: Colors.green),
               ),
               style: TextStyle(color: Colors.green),
             ),
              SizedBox(height: halfHeight * 0.1),
                TextField(
               onChanged: (value) {
                 userController.referalCity = value;
               },
               // controller: _nameController,
               decoration: InputDecoration(
                 filled: true,
                 fillColor: Colors.green.withOpacity(0.2),
                 hintText: "City",
                 hintStyle: TextStyle(color: Colors.green),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(8.0),
                   borderSide: BorderSide.none,
                 ),
                 // prefixIcon: Icon(Icons.person, color: Colors.green),
               ),
               style: TextStyle(color: Colors.green),
             ),
              SizedBox(height: halfHeight * 0.1),
                TextField(
               onChanged: (value) {
                 userController.referalPhoneNumber = value;
               },
               // controller: _nameController,
               decoration: InputDecoration(
                 filled: true,
                 fillColor: Colors.green.withOpacity(0.2),
                 hintText: "Phone Number",
                 hintStyle: TextStyle(color: Colors.green),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(8.0),
                   borderSide: BorderSide.none,
                 ),
                 // prefixIcon: Icon(Icons.person, color: Colors.green),
               ),
               style: TextStyle(color: Colors.green),
             ),
              SizedBox(height: halfHeight * 0.1),
                TextField(
               onChanged: (value) {
                 userController.googleLocation = value;
               },
               // controller: _nameController,
               decoration: InputDecoration(
                 filled: true,
                 fillColor: Colors.green.withOpacity(0.2),
                 hintText: "Google Location",
                 hintStyle: TextStyle(color: Colors.green),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(8.0),
                   borderSide: BorderSide.none,
                 ),
                 // prefixIcon: Icon(Icons.person, color: Colors.green),
               ),
               style: TextStyle(color: Colors.green),
             ),
              SizedBox(height: halfHeight * 0.1),
                TextField(
               onChanged: (value) {
                 userController.referalDescription = value;
               },
               // controller: _nameController,
               decoration: InputDecoration(
                 filled: true,
                 fillColor: Colors.green.withOpacity(0.2),
                 hintText: "System Type",
                 hintStyle: TextStyle(color: Colors.green),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(8.0),
                   borderSide: BorderSide.none,
                 ),
                 // prefixIcon: Icon(Icons.person, color: Colors.green),
               ),
               style: TextStyle(color: Colors.green),
             ),
          
               SizedBox(height: halfHeight * 0.1),
                TextFormField(
               onChanged: (value) {
                 userController.referalEmail = value;
               },
               
               // controller: _nameController,
               decoration: InputDecoration(
                 filled: true,
                 fillColor: Colors.green.withOpacity(0.2),
                 hintText: "email",
                 hintStyle: TextStyle(color: Colors.green),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(8.0),
                   borderSide: BorderSide.none,
                 ),
                 // prefixIcon: Icon(Icons.person, color: Colors.green),
               ),
               style: TextStyle(color: Colors.green),
             ),
          
       
             SizedBox(height: halfHeight * 0.1),
                TextField(
               onChanged: (value) {
                 userController.customerIdss = value;
               },
               // controller: _nameController,
               decoration: InputDecoration(
                 filled: true,
                 fillColor: Colors.green.withOpacity(0.2),
                 hintText: "Customer Id",
                 hintStyle: TextStyle(color: Colors.green),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(8.0),
                   borderSide: BorderSide.none,
                 ),
                 // prefixIcon: Icon(Icons.person, color: Colors.green),
               ),
               style: TextStyle(color: Colors.green),
             ),
              SizedBox(height: halfHeight * 0.1),
             Text("Net Metering Required"),
               SizedBox(height: halfHeight * 0.1),
              Column(
          children: <Widget>[
            RadioListTile(
              title: Text('Yes'),
              value: 'Yes',
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text('No'),
              value: 'No',
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value.toString();
                });
              },
            ),
            SizedBox(height: 20),
            Text('Selected Option: $selectedOption'),
          ],
        ),
                 SizedBox(height: halfHeight * 0.1),
              
          
       
       
       
      
                 SizedBox(
               width: double.infinity,
               height: 48.0,
               child: ElevatedButton(
                 onPressed: () async{
                          submitComplaint(context);
                 },
                 child: Text(
                   'Refer Client',
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
             
             ,
           ],
         ),
       ),
        ),
    );
  }
}
