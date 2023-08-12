import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:solaris/controllerRef.dart';
import 'package:intl/intl.dart';

class NetMeteringApproved extends StatefulWidget {
  @override
  State<NetMeteringApproved> createState() => _NetMeteringApprovedState();
}
  Future<void>? alerts(String customerName,String officerName,String payment,String userIdCustomer,String ids,BuildContext context,String stepName,bool noted,String customerId,String formattedDate,String formattedTime,String adminName,String formattedDateTwo,String formattedTimeTwo,String description){
    showDialog(context: context, builder: (context){
      return     AlertDialog(
        content: Container(
          height: 400,
          width: 700,
          child: new
               Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  Center(
        child: 
        Table(
          border: TableBorder.all(),
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Center(child: Text('Header 1')),
                ),
                TableCell(
                  child: Center(child: Text('Header 2')),
                ),
                TableCell(
                  child: Center(child: Text('Header 3')),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Center(child: Text('C.id')),
                ),
                TableCell(
                  child: Center(child: Text('${customerId}')),
                ),
                TableCell(
                  child: Center(child: Text('')),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Center(child: Text('Step Name')),
                ),
                TableCell(
                  child: Center(child: Text('${stepName}')),
                ),
                TableCell(
                  child: Center(child: Text('')),
                ),
              ],
            ),
             TableRow(
              children: [
                TableCell(
                  child: Center(child: Text('Requested By')),
                ),
                TableCell(
                  child: Center(child: Text('${officerName}')),
                ),
                TableCell(
                  child: Center(child: Text('${formattedDate}- ${formattedTime}')),
                ),
              ],
            ),
             TableRow(
              children: [
                TableCell(
                  child: Center(child: Text('Approved By')),
                ),
                TableCell(
                  child: Center(child: Text('${adminName}')),
                ),
                TableCell(
                  child: Center(child: Text('${formattedDateTwo}- ${formattedTimeTwo}')),
                ),
              ],
            ),

              TableRow(
              children: [
                TableCell(
                  child: Center(child: Text('Noticed By')),
                ),
                TableCell(
                  child: Center(child: Text('${userController.userName}')),
                ),
                TableCell(
                  child: Center(child: Text('${formattedDateTwo}- ${formattedTimeTwo}')),
                ),
              ],
            ),

              TableRow(
              children: [
                TableCell(
                  child: Center(child: Text('Amount Requested')),
                ),
                TableCell(
                  child: Center(child: Text('${payment}')),
                ),
                TableCell(
                  child: Center(child: Text('')),
                ),
              ],
            ),
             TableRow(
              children: [
                TableCell(
                  child: Center(child: Text('Description')),
                ),
                TableCell(
                  child: Center(child: Text('${description}')),
                ),
                TableCell(
                  child: Center(child: Text('')),
                ),
              ],
            ),
          ],
        ),
      ),
          
              // SizedBox(height: 10),
              // Column(
              //   children: [
              //     Text(
              //       'Customer Name: ${customerName}',
              //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //     ),
              //     Text(
              //       'Officer Name: ${officerName}',
              //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //     ),
              //        Text(
              //       'Payment: ${payment}',
              //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //     ),
              //       Text(
              //       'Step: ${stepName}',
              //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),
                          //                   ElevatedButton(
                          // onPressed: () async{
                         
            

                                        
                                    ElevatedButton(
                        onPressed: () async{
                        
          await  adminController.downloadPdf(userIdCustomer, ids);
              Navigator.pop(context);
                        },
                        child: Text('Download'),        
                                    ),
                                   
            
                  
             
        //  try{
        
        //  final usersRef = await FirebaseFirestore.instance.collection('users');
        //  await usersRef.doc(widget.id).collection("netMeteringProcedure").doc(ids).update({'approved':true,});
        //   }catch(e){
        //  Get.snackbar("Error", "Issue in updating ${e}");
        //   }
          
              
                          
                      //     },
                      //     child: 
                      // // payment == "" ?
                      //     // Text('Approve'):
                      //      Text('Sending for approval to finance')
                      //     ,
                      //                     )
                                        // widget.assignedTo == ""?
                                        //    Text("Select Electrican First"):
                                        //    Text("Selected electrician is ${widget.assignedTo}"),  
            ],
          ),
        ),
      );
    });
  }
class _NetMeteringApprovedState extends State<NetMeteringApproved> {
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
              final customerId = userDoc["customerId"];

              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('users').doc(userId).collection('netMeteringProcedure')
                 .where("noted",isEqualTo: true)
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
                        final noted = subDoc["noted"];
                        final sentToFinanceDateTime = subDoc["sentToFinanceDateTime"];
                        final sendApprovalDateTime = subDoc["sendApprovalDateTime"];
                        final adminName = subDoc["adminName"];
                         final description = subDoc["description"];
                         final userIdCustomer = subDoc["userIdCustomer"];
                         
                        final Timestamp timestamp = sendApprovalDateTime;
 DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);
    String formattedTime = DateFormat('h:mm a').format(dateTime);
     final Timestamp timestampTwo = sentToFinanceDateTime;
 DateTime dateTimeTwo = timestampTwo.toDate();
    String formattedDateTwo = DateFormat('MMM d, yyyy').format(dateTimeTwo);
    String formattedTimeTwo = DateFormat('h:mm a').format(dateTimeTwo);

                        // ...

                        return 

                              Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {
                          
                          alerts( customerName, officerName,payment,userIdCustomer,ids,context,name,noted,customerId,formattedDate,formattedTime,adminName,formattedDateTwo,formattedTimeTwo,description);
                        },
                        child: Container(
                           decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(10),
                                           color: Colors.green.withOpacity(0.2),
                                         ),
                          child: Column(
                            children: [
                                   
                             Padding(
                               padding: const EdgeInsets.all(20.0),
                               child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text(" ${customerName} " ),
                                  SizedBox(height: 5,),
                                    Text(" ${name} " ),
                                      SizedBox(height: 5,),
                                        Text(" ${payment} " ),
                                ],),
                                
                                  Column(
                                 
                                  children: [
                                    
                                                        //  Text(" ${sentToFinanceDateTime} " ),
                                
                                ],),
                                
                                
                               ],),
                             ),
                             
                           
                              // ListTile(
                          
                              //   title: Text(" ${officerName} apply for payment clearance to approved thePayment: ${payment}. for the Customer -- ${customerName} " ), 
                               
                              //   // subtitle:Text("${description} ---- ${payment} " ), 
                              // ),
                                          
                         
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
                      ),
                    );
                  //               Padding(
                  //     padding: const EdgeInsets.all(4.0),
                  //     child: Container(
                  //        decoration: BoxDecoration(
                  //    borderRadius: BorderRadius.circular(10),
                  //    color: Colors.green.withOpacity(0.2),
                  //  ),
                  //       child: Column(
                  //         children: [
             
                         
                         
                  //           ListTile(
                        
                  //             title: Text(" ${officerName} apply for payment clearance to approved thePayment: ${payment}. for the Customer -- ${customerName} " ), 
                             
                  //             // subtitle:Text("${description} ---- ${payment} " ), 
                  //           ),
                                        
                       

                                        
                                        
                  //         ],
                  //       ),
                  //     ),
                  //   );
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
