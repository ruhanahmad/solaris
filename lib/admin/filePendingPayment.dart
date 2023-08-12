import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:solaris/admin/filePendingDetail.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/models/user_model.dart';

class FilePendingPayment extends StatefulWidget {
  @override
  State<FilePendingPayment> createState() => _FilePendingPaymentState();
}

class _FilePendingPaymentState extends State<FilePendingPayment> {


    Future<void>? alerts(String customerName,String officerName,String payment,String description,String userIdCustomer,String ids,String StepName){
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
                    'Payment: ${payment}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                    Text(
                    'Step: ${StepName}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
                                            ElevatedButton(
                          onPressed: () async{
                         
            
              await     adminController.generateAndUploadPdf(officerName,description,payment,customerName,userIdCustomer,ids);
              Navigator.pop(context);
                  
             
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
          print(usersDocs);
          return ListView.builder(
            itemCount: usersDocs.length,
            itemBuilder: (context, index) {
              final userDoc = usersDocs[index];
              final userId = userDoc.id;
              final names = userDoc["name"];
              return 
              StreamBuilder<QuerySnapshot>(
                stream: 
              FirebaseFirestore.instance
                              .collection('users').doc(userId).collection('netMeteringProcedure')
                              .where("approved",isEqualTo: false) .where("payment",isNotEqualTo: "")
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
                      final StepName = subDoc["name"];
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
                                alerts( customerName, officerName,payment,description,userIdCustomer,ids,StepName);
                                // Get.to(()=> BigImagePayment(customername: customerName,officerName: officerName,payment: payment,description:description,userIdCustomer:userIdCustomer,id:ids));
                              },
                              title: Text(" ${names} " ), 
                              
                             subtitle: Text("${StepName}"),
                              // subtitle:Text("${description} ---- ${payment} " ), 
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
