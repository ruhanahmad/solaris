import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:solaris/admin/bigImageNonPayment.dart';
import 'package:solaris/admin/filePendingDetail.dart';
import 'package:solaris/admin/inProcess.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/models/user_model.dart';

class FilesPFinished extends StatefulWidget {
  @override
  State<FilesPFinished> createState() => _FilesPFinishedState();
}

   
class _FilesPFinishedState extends State<FilesPFinished> {

  Future<void>? alerts(String customerName,String officerName,String payment,String description,String userIdCustomer,String ids,String docname){
    showDialog(context: context, builder: (context){
      return     AlertDialog(
        content: Container(
          height: 400,
          child: new
               Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
          
              SizedBox(height: 10),
              Column(
                children: [
                  Text(
                    'Customer Name: ${customerName}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Officer Name: ${officerName}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                   Text(
                    'Description: ${description}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                   Text(
                    'Step: ${docname}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                   
                ],
              ),
        //                                     ElevatedButton(
        //                   onPressed: () async{
                         
            
        //        await      adminController.updateApproval(userIdCustomer,ids,docname);
        //       Navigator.pop(context);
                  
             
        // //  try{
        
        // //  final usersRef = await FirebaseFirestore.instance.collection('users');
        // //  await usersRef.doc(widget.id).collection("netMeteringProcedure").doc(ids).update({'approved':true,});
        // //   }catch(e){
        // //  Get.snackbar("Error", "Issue in updating ${e}");
        // //   }
          
              
                          
        //                   },
        //                   child: 
        //               // payment == "" ?
        //                   // Text('Approve'):
        //                    Text('Sending for Approval')
        //                   ,
        //                                   )
                                        // widget.assignedTo == ""?
                                        //    Text("Select Electrican First"):
                                        //    Text("Selected electrician is ${widget.assignedTo}"),  
            ],
          ),
        ),
      );
    });
  }
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
              final InProcess = userDoc["inProcess"];
              return 
              StreamBuilder<QuerySnapshot>(
                stream: 
              FirebaseFirestore.instance
                              .collection('users').doc(userId).collection('netMeteringProcedure')
                              .where("approved",isEqualTo: true).where("sentForApproval",isEqualTo: true).orderBy("finishedDateTime",descending: true)
                              .snapshots(),
                //   .where('payment', isNotEqualTo: 
                // "").where("noted",isEqualTo: false)
              
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
                        final sentForApproval = subDoc["sentForApproval"];
                        final description = subDoc["description"];
                        final userIdCustomer =subDoc["userIdCustomer"];
                        final docName= subDoc["name"];
                        final noted= subDoc["noted"];
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
                                alerts(customerName, officerName,payment,description,userIdCustomer,ids, docName,);
                              },
                              title: Text(" ${names} " ), 
                             
                              subtitle:Text("${docName}  " ), 
                              trailing: 
                              
                              noted == true?
                              Text("paid")
                              :
                                Text("approved")
                              ,
                            ),
                            //   ListTile(
                        
                            //   title: Text(" ${officerName} apply for payment clearance to approved thePayment: ${payment}. for the Customer -- ${customerName} " ), 
                             
                            //   // subtitle:Text("${description} ---- ${payment} " ), 
                            // )
                            // ,
                                        
                      
 
                                        
                                        
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
