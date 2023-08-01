import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solaris/controllerRef.dart';
import 'dart:io';
class BigImagePayment extends StatefulWidget {
  final String customername;
  final String officerName;
  final String payment;
  final String description;
  final String userIdCustomer;
  final String id;

  BigImagePayment({required this.customername, required this.officerName, required this.payment,required this.description,required this.userIdCustomer,required this.id});

 
  @override
  State<BigImagePayment> createState() => _BigImagePaymentState();
}
 
class _BigImagePaymentState extends State<BigImagePayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Description'),
      ),
      body: Center(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
        
            SizedBox(height: 10),
            Column(
              children: [
                Text(
                  'Customer Name: ${widget.customername}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Officer Name: ${widget.officerName}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                   Text(
                  'Payment: ${widget.payment}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
                                          ElevatedButton(
                        onPressed: () async{
                       
          
            await     adminController.generateAndUploadPdf(widget.officerName,widget.description,widget.payment,widget.customername,widget.userIdCustomer,widget.id);
           ;       
     
//  try{

//  final usersRef = await FirebaseFirestore.instance.collection('users');
//  await usersRef.doc(widget.id).collection("netMeteringProcedure").doc(ids).update({'approved':true,});
//   }catch(e){
//  Get.snackbar("Error", "Issue in updating ${e}");
//   }
  
      
                        
                        },
                        child: 
                    // payment == "" ?
                        // Text('Approve'):
                         Text('Sending for approval to finance')
                        ,
                                        )
                                      // widget.assignedTo == ""?
                                      //    Text("Select Electrican First"):
                                      //    Text("Selected electrician is ${widget.assignedTo}"),  
          ],
        ),
      ),
    );
  }
}
