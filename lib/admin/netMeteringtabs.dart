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
             _buildTabWithCounts(context, 'New Files'),
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


Widget _buildTabWithCounts(BuildContext context, String title, ) {
    return StreamBuilder<QuerySnapshot>(
      stream:  FirebaseFirestore.instance.collection('users')
        .where('netMetering', isEqualTo: true)
        .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Tab(text: title);
        }

        List<String> userIds = snapshot.data!.docs.map((doc) => doc.id).toList();
        
        int totalRecordCount = 0;

        return
        StreamBuilder<List<int>>(
          stream: _getUserDocumentCounts(userIds),
          builder: (context, innerSnapshot) {
            if (!innerSnapshot.hasData) {
              return Tab(text: title);
            }

            int totalRecordCount = innerSnapshot.data!.fold(0, (sum, count) => sum + count);

            return Tab(text: '$title ($totalRecordCount)');
          },
        );
      },
    );
        //  FutureBuilder<List<int>>(
        //   future: _getUserDocumentCounts(userIds),
        //   builder: (context, innerSnapshot) {
        //     if (!innerSnapshot.hasData) {
        //       return Tab(text: title);
        //     }

        //     innerSnapshot.data!.forEach((count) {
        //       totalRecordCount += count;
        //     });

        //     return Tab(text: '$title ($totalRecordCount)');
        //   },
        // );
      }
 
  }

 Stream<List<int>> _getUserDocumentCounts(List<String> userIds) {
    StreamController<List<int>> controller = StreamController();

    List<int> counts = [];

    int completed = 0;

    for (String userId in userIds) {
      FirebaseFirestore.instance.collection('users').doc(userId).collection('netMeteringProcedure')
                   .where('payment', isNotEqualTo: 
                 "").where("noted",isEqualTo: false)
                  .snapshots().listen((userSnapshot) {
        int userRecordCount = userSnapshot.size;
        counts.add(userRecordCount);
        completed++;
        if (completed == userIds.length) {
          controller.add(counts);
        }
      });
    }

    return controller.stream;
  }

  Widget _buildTabWithCountss(BuildContext context, String title,) {
    return 
    StreamBuilder<QuerySnapshot>(
      stream: 
      FirebaseFirestore.instance.collection('users')
        .where('netMetering', isEqualTo: true)
        .snapshots(),
      builder: (context, snapshot) {
             if (!snapshot.hasData) {
          return Tab(text: title);
        }
        if (snapshot.hasData) {
          final usersDocs = snapshot.data!.docs;
         
                       int recordCount = usersDocs.length;
        return
        

         Tab(text: '$title ($recordCount)');
          //  return Tab(text: title);
        //   ListView.builder(
        //     itemCount: usersDocs.length,
        //     itemBuilder: (context, index) {
        //       final userDoc = usersDocs[index];
        //       final userId = userDoc.id;
        //       final names = userDoc["name"];
        //       return 
        //       StreamBuilder<QuerySnapshot>(
        //         stream: 
        // FirebaseFirestore.instance.collection('users').doc(userId).collection('netMeteringProcedure')
        //         //   .where('payment', isNotEqualTo: 
        //         // "").where("noted",isEqualTo: false)
        //           .snapshots(),
        //         builder: (context, subSnapshot) {
        //           if (subSnapshot.hasData) {
        //             final subDocs = subSnapshot.data!.docs;
        //             // Process and display data from the sub-collection
        //             return ListView.builder(
        //               shrinkWrap: true,
        //               physics: NeverScrollableScrollPhysics(),
        //               itemCount: subDocs.length,
        //               itemBuilder: (context, subIndex) {
        //                 final subDoc = subDocs[subIndex];
        //                 // final officerName = subDoc['officerName'];
        //                 // final payment= subDoc['payment'];
        //                 // final customerName = subDoc["customerName"];
        //                 final ids = subDoc.id;

        //                 // ...

                        
        //                      int recordCount = subDocs.length;
        // return Tab(text: '$title ($recordCount)');
        //               },
        //             );
        //           } else if (subSnapshot.hasError) {
        //             return Text('Error: ${subSnapshot.error}');
                    
        //           } 
        //           else{
        //             return CircularProgressIndicator();
        //           }
                 
        //         },
        //       );
        //     },
        //   );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
    // StreamBuilder<QuerySnapshot>(
    //   stream:  FirebaseFirestore.instance.collection('users')
    //     .where('netMetering', isEqualTo: true)
    //     .snapshots(),
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return Tab(text: title);
    //     }
    //     int recordCount = snapshot.data!.docs.length;
    //     return Tab(text: '$title ($recordCount)');
    //   },
    // );
  }

