import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:solaris/admin/stepsCompleted.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/netMeteringOfficer/customerProcedure.dart';

class OfficerApprovedFiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users')
        .where('netMetering', isEqualTo: true)
        .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final usersDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: usersDocs.length,
            itemBuilder: (context, index) {
              final userDoc = usersDocs[index];
              final userId = userDoc.id;

              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('users').doc(userId).collection('netMeteringProcedure')
                  .where('officerName', isEqualTo: 
                userController.userName).where("approved",isEqualTo: true).where("sentForApproval",isEqualTo: true)
                  .snapshots(),
                builder: (context, subSnapshot) {
                  if (subSnapshot.hasData) {
                    final subDocs = subSnapshot.data!.docs;
                    // Process and display data from the sub-collection
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: subDocs.length,
                      itemBuilder: (context, subIndex) {
                        final subDoc = subDocs[subIndex];
                        final officerName = subDoc['officerName'];
                        final payment= subDoc['payment'];
                        final customerName = subDoc["customerName"];
                        final ids = subDoc.id;
                        final name = subDoc["name"];

                        // ...

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
                              Get.to(StepsCompleted(id: userId,))  ;
                              },
                        
                              title:
                              //  Text(" ${officerName} apply for payment clearance to approved thePayment: ${payment}. for the Customer -- ${customerName} " ), 
                               Text("${customerName} " ), 
                             
                              subtitle:Text("${name} ---- ${payment ??""} " ), 
                              trailing: Text("Approved",style: TextStyle(color: Colors.green),),
                            ),
                                         
                       
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
                  } else if (subSnapshot.hasError) {
                    return Text('Error: ${subSnapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
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
