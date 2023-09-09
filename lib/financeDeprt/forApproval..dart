import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solaris/controllerRef.dart';

class ForApproal extends StatelessWidget {
  
 var startDate;
 var endDate;
 ForApproal({this.startDate,this.endDate});

TextEditingController _descriptionController= TextEditingController();

  Future<void>? alerts(String customerName,String officerName,String payment,String userIdCustomer,String ids,BuildContext context,String stepName,bool noted){
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
                    'Step: ${stepName}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                //   onChanged: (value) {
                //   userController.complaint = value;
                // },
                controller: _descriptionController ,
                // maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.green.withOpacity(0.2),
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.message, color: Colors.green),
                ),
                style: TextStyle(color: Colors.green),
              ),
                ],
              ),
                          //                   ElevatedButton(
                          // onPressed: () async{
                         
            
                noted ==false ?
     ElevatedButton(
                        onPressed: () async{
                           
       try{
        EasyLoading.show();
 final usersRef = await FirebaseFirestore.instance.collection('users').doc(userIdCustomer).collection('netMeteringProcedure');
               
 await usersRef.doc(ids).update({'noted':true,"approvalDateTimeFinance":DateTime.now(),"financeDescription":_descriptionController.text},);

 EasyLoading.dismiss();
  }
  catch(e)
  {
 Get.snackbar("Error", "Issue in updating ${e}");
 EasyLoading.dismiss();
  }
  _descriptionController.text ="";
Navigator.pop(context);
  
      
                        
                        },
                        child: Text('Noted'),
                                        )
                                        :
                                    ElevatedButton(
                        onPressed: () async{
                         adminController.downloadPdf(userIdCustomer,ids);
       
                        },
                        child: Text('Noted'),        
                                    )
            
                  
             
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

  @override
  Widget build(BuildContext context) {
    return
     StreamBuilder<QuerySnapshot>(
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

              return 
              
              StreamBuilder<QuerySnapshot>(
                stream:
                // startDate == null || endDate == null ? 
                FirebaseFirestore.instance.collection('users').doc(userId).collection('netMeteringProcedure')
                  .where('payment', isNotEqualTo: 
                "").where("noted",isEqualTo: false).where("sentForApproval",isEqualTo: true)
                  .snapshots()
                  // :
        //           FirebaseFirestore.instance.collection('users').doc(userId).collection('netMeteringProcedure')
        //           // .where('payment', isNotEqualTo: "")
        //         .where("noted",isEqualTo: false)
        //         .where('sentToFinanceDateTime', isGreaterThanOrEqualTo: startDate)
        // .where('sentToFinanceDateTime', isLessThanOrEqualTo: endDate)
        //           .snapshots()
                  ,
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
String formattedDate="";
String formattedTime="";
 if(sentToFinanceDateTime != "") {
  final Timestamp timestamp = sentToFinanceDateTime;
 DateTime dateTime = timestamp.toDate();
     formattedDate = DateFormat('MMM d, yyyy').format(dateTime);
     formattedTime = DateFormat('h:mm a').format(dateTime);
 }
//  final Timestamp timestamp = sentToFinanceDateTime;
//  DateTime dateTime = timestamp.toDate();
//     String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);
//     String formattedTime = DateFormat('h:mm a').format(dateTime);
                        // ...
                        

                        return 
                                Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {
                          
                          alerts( customerName, officerName,payment,userId,ids,context,name,noted);
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
                                    
                                                         Text( formattedDate  ),
                                                         SizedBox(height: 5,),
                                                           Text( formattedTime  ),
                                
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
