import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:solaris/admin/inProcess.dart';
import 'package:solaris/admin/newFiles.dart';
import 'package:solaris/salesPerson/personalClients.dart';
import 'package:solaris/salesPerson/referalClients.dart';
import 'package:solaris/screens/complaint.dart';
import 'package:solaris/screens/completedComplaint.dart';
import 'package:solaris/screens/previousComplaint.dart';


class netMeteringTabs extends StatefulWidget {
  @override
  State<netMeteringTabs> createState() => _netMeteringTabsState();
}

class _netMeteringTabsState extends State<netMeteringTabs> {


    StreamController<List<String>> _documentsStreamController =
      StreamController<List<String>>();
  StreamSubscription<List<String>>? _streamSubscription;






  @override
  void initState() {
    super.initState();
    // Fetch initial data when the widget is first created
    fetchData();

    // Set up a stream subscription to listen for changes
    _streamSubscription = _documentsStreamController.stream.listen((data) {
      // Handle the updated data here if needed
      // For example, update the UI with the new data
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _documentsStreamController.close();
    super.dispose();
  }


   









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
              Tab(text: 'New Files'),
              Tab(text: 'In Process'),
               Tab(text: 'Finished'),
             
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contents of Tab 1
             NewFiles(),
            // Contents of Tab 2
          InProcess(),
           NewFiles(),
            
          ],
        ),
      ),
    );
  }
}
