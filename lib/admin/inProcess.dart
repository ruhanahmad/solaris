import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:solaris/admin/stepsCompleted.dart';

class InProcess extends StatelessWidget {
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
              final names = userDoc["name"];
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('users').doc(userId).collection('netMeteringProcedure')
                //   .where('payment', isNotEqualTo: 
                // "").where("noted",isEqualTo: false)
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
                        // final subDoc = subDocs[subIndex];
                        // final officerName = subDoc['officerName'];
                        // final payment= subDoc['payment'];
                        // final customerName = subDoc["customerName"];
                        // final ids = subDoc.id;

                        // ...

                        return 
                         subDocs.length == 2 ?
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
                        
                              title: Text(" ${names} NetMetering procedure File status is Pending.Wotrking on it" ), 
                             onTap: () {
                                Get.to(()=> StepsCompleted(id:userId,name:names),);
                             },
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
                    ):Container();
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
