import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:solaris/models/authentication_service.dart';

import '../models/user_model.dart';

class ComplaintScreen extends StatefulWidget {
  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
 final TextEditingController _nameController = TextEditingController();
  final TextEditingController _complaintController = TextEditingController();
  
AuthenticationService auths = Get.put(AuthenticationService());
    void _submitComplaint(BuildContext context) {
    
    final String name = _nameController.text;
    final String complaint = _complaintController.text;

    if (name.isNotEmpty && complaint.isNotEmpty) {
       EasyLoading.show();

      FirebaseFirestore.instance.collection('complaints').add({
         "userid":auths.useri,
        'name': _nameController.text,
        'complaint': _complaintController.text,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Complaint submitted successfully!')),
        );
         EasyLoading.dismiss();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit complaint. Please try again.')),
        );
          EasyLoading.dismiss();
      });
       EasyLoading.dismiss();
    }
  }
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
        child: Container(
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
           
              Text(
                'Complaint',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: halfHeight * 0.1),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.green.withOpacity(0.2),
                  hintText: 'Name',
                  hintStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.person, color: Colors.green),
                ),
                style: TextStyle(color: Colors.green),
              ),
              SizedBox(height: 16.0),
              TextField(
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
              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton(
                  onPressed: () {
                    _submitComplaint( context);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
