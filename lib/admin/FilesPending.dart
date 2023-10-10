import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:solaris/admin/FilesPendingNonPayments.dart';
import 'package:solaris/admin/filePFinished.dart';
import 'package:solaris/admin/filePendingPayment.dart';
import 'package:solaris/admin/inProcess.dart';
import 'package:solaris/admin/newFiles.dart';
import 'package:solaris/salesPerson/personalClients.dart';
import 'package:solaris/salesPerson/referalClients.dart';
import 'package:solaris/screens/complaint.dart';
import 'package:solaris/screens/completedComplaint.dart';
import 'package:solaris/screens/previousComplaint.dart';


class FilesPending extends StatefulWidget {
  @override
  State<FilesPending> createState() => _FilesPendingState();
}

class _FilesPendingState extends State<FilesPending> {


  
   









List<String>? documents;
  Future<void> fetchData() async {

  //   try {
      
  //     QuerySnapshot querySnapshot =
  //         await FirebaseFirestore.instance.collection('users')
  //       .where('netMetering', isEqualTo: true)
  //       .get();

      
  //     documents = [];
  //     querySnapshot.docs.forEach((doc)async {

  //       final userId = doc.id;
  //      QuerySnapshot querySnapshots =
  // await FirebaseFirestore.instance.collection('users').doc(userId).collection('netMeteringProcedure').get() ;
  //       // final QuerySnapshot result = await FirebaseFirestore.instance
  //       // .collection('users')
  //       // .where('email', isEqualTo:email )
  //       // .get();
  //       querySnapshots.docs.forEach((docs) {

  //    documents!.add(docs.id);
  //  print("asdasd ${documents!.length}");
  //       });
       
  //       // Assuming each document has a field named "title"
   
  //     });

  //     // _documentsStreamController.add(documents!);
  //   } catch (e) {
  //     // Handle any errors that might occur during the fetch process
  //     print("Error fetching data: $e");
  //   }
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        
        appBar: AppBar(
        automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              StreamBuilder<QuerySnapshot>(
                stream: 
               FirebaseFirestore.instance.collection('users')
                  .where("netMetering",isEqualTo: true)
                  .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Tab(text: 'payments');
                  }

                  if (snapshot.hasError) {
                    return Tab(text: 'payments');
                  }

                  if (snapshot.hasData) {
                    int totalPaymentCounter = 0;

              // Calculate the sum of paymentcounter values from all documents
              snapshot.data!.docs.forEach((document) {
                final data = document.data() as Map<String, dynamic>;
                if (data.containsKey('paymentCounter')) {
                  totalPaymentCounter += data['paymentCounter'] as int;
             
                }

              });
                   print(totalPaymentCounter);
                 return Tab(text:  'Payments(${totalPaymentCounter})');
                    // int recordCount = snapshot.data!.docs.length;
                    // return Tab(text:  'NonPayments($recordCount)');
                  }

                  return Tab(text: 'Payments');
                },
              ),
          //  Tab(text:  'Payments'),
              StreamBuilder<QuerySnapshot>(
                stream: 
               FirebaseFirestore.instance.collection('users')
                  .where("netMetering",isEqualTo: true)
                  .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Tab(text: 'NonPayments');
                  }

                  if (snapshot.hasError) {
                    return Tab(text: 'NonPayments');
                  }

                  if (snapshot.hasData) {
                    int totalPaymentCounter = 0;

              // Calculate the sum of paymentcounter values from all documents
              snapshot.data!.docs.forEach((document) {
                final data = document.data() as Map<String, dynamic>;
                if (data.containsKey('nonPaymentCounter')) {
                  totalPaymentCounter += data['nonPaymentCounter'] as int;
             
                }

              });
                   print(totalPaymentCounter);
                 return Tab(text:  'NonPayments (${totalPaymentCounter})');
                    // int recordCount = snapshot.data!.docs.length;
                    // return Tab(text:  'NonPayments($recordCount)');
                  }

                  return Tab(text:  'NonPayments');
                },
              ),
           
               Tab(text: 'Finished'),
             
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contents of Tab 1
            FilePendingPayment(),
            // Contents of Tab 2
          FilesPendingNonPayment(),
            FilesPFinished(),
            
          ],
        ),
      ),
    );
  }
}
