import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:solaris/admin/netMeteringProcedure.dart';
import 'package:solaris/admin/stepsCompleted.dart';

class Finished extends StatefulWidget {
  @override
  State<Finished> createState() => _FinishedState();
}

class _FinishedState extends State<Finished> {
  @override
  Widget build(BuildContext context) {
    return 
    StreamBuilder<QuerySnapshot>(
      stream: 
      FirebaseFirestore.instance.collection('users')
        .where('netMetering', isEqualTo: true).where("inProcess",isEqualTo: "Finished")
        .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final usersDocs = snapshot.data!.docs;
          return 
          ListView.builder(
            itemCount: usersDocs.length,
            itemBuilder: (context, index) {
              final userDoc = usersDocs[index];
              final userId = userDoc.id;
              final names = userDoc["name"];
              return 
                      
                                Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                         decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: Colors.green.withOpacity(0.2),
                   ),
                        child: Column(
                          children: [
             
                         
                        
                            ListTile(
                               onTap: () {
                             Get.to( StepsCompleted(id:userId,));    
                               },
                               
                              title: Text(" ${names} " ), 

                  //              trailing: IconButton(
                  //   icon: Icon(Icons.delete),
                  //   onPressed: () {
                  //     _deleteDocument(userId,ids);
                  //   },
                  // ),
                             
                              // subtitle:Text("${description} ---- ${payment} " ), 
                            )
                            //   ListTile(
                        
                            //   title: Text(" ${officerName} apply for payment clearance to approved thePayment: ${payment}. for the Customer -- ${customerName} " ), 
                             
                            //   // subtitle:Text("${description} ---- ${payment} " ), 
                            // )
                            // ,
                                        
                       
//      ElevatedButton(
//                         onPressed: () async{
                         
//        try{
//         EasyLoading.show();
//  final usersRef = await FirebaseFirestore.instance.collection('users').doc(userId).collection('netMeteringProcedure');
               
//  await usersRef.doc(ids).update({'noted':true,"approvalDateTimeFinance":DateTime.now()});

//  EasyLoading.dismiss();
//   }
//   catch(e)
//   {
//  Get.snackbar("Error", "Issue in updating ${e}");
//  EasyLoading.dismiss();
//   }
 

  
      
                        
//                         },
//                         child: Text('Noted'),
//                                         ),
                                        
                                        
                          ],
                        ),
                      ),
                    );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
