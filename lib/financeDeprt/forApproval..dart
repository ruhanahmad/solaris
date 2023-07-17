import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ForApproal extends StatelessWidget {
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
                  .where('payment', isNotEqualTo: 
                "")
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
                        
                              title: Text("Approval request from ${officerName}.Description :Step Name ::${payment} " ), 
                             
                              // subtitle:Text("${description} ---- ${payment} " ), 
                            ),
                                        
                       
          //                               ElevatedButton(
          //               onPressed: () async{
          //                 payment == "" ?
          //  await      adminController.updateApproval(widget.id!,ids)
          //  :
          //   await      adminController.generateAndUploadPdf(netMeteringOfficerName,description,payment,customerName,widget.id!,ids)
          //  ;       
     

  
      
                        
          //               },
          //               child: Text('Approve'),
          //                               )
                                        
                                        
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
