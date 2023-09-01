import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:solaris/admin/stepsCompleted.dart';

class InProcess extends StatelessWidget {
  Future<void>? alerts(String customerName,String phone,String city,String address,String email,BuildContext context,String customerId){
    showDialog(context: context, builder: (context){
      return     AlertDialog(
        content:
         Container(
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
                    'phone: ${phone}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                     Text(
                    'city: ${city}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                    Text(
                    'address: ${address}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                     Text(
                    'email: ${email}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'customer id: ${customerId}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
                                         
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
              final phone = userDoc["phone"];
              final namess = userDoc["name"];
              final email = userDoc["email"];
               final city = userDoc["city"]; 
               final address = userDoc["address"];
               final customerId = userDoc["customerId"];
               final FirstStepDateTime = userDoc["FirstStepDateTime"];
               final Step = userDoc["Step"];
               final inProcess = userDoc["inProcess"];
               
               final Timestamp firstStep = FirstStepDateTime;
 DateTime dateTimeFirstStep = firstStep.toDate();
    DateTime currentDate = DateTime.now();
Duration difference = currentDate.difference(dateTimeFirstStep);
int daysDifference = difference.inDays;
              return 
                           inProcess == "inProcess"   ?
                                  Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                         decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: Colors.green.withOpacity(0.2),
                   ),
                        child: Column(
                          children: [
             
                           Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                         onTap: () {
                                    //  alerts( namess, phone,city,address,email,context,customerId,);
                                  },
                        // onTap: () {
                          
                        //   alerts( customerName, officerName,payment,userId,ids,context,name,noted);
                        // },
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
                                GestureDetector(
                                  onTap: () {
                                  alerts( namess, phone,city,address,email,context,customerId,); 
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2.0,color: Colors.black)
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                     Text(" ${namess} " )
                                    
                                          // SizedBox(height: 5,),
                                          //   Text(" ${payment} " ),
                                    ],),
                                  ),
                                ),
                                 GestureDetector(
                                  onTap: () {
                                   Get.to( StepsCompleted(id:userId,));    
                                  },
                                   child: Column(
                                   
                                    children: [
                                      
                                                           Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration: BoxDecoration(
                                                              border: Border.all(width: 2)
                                                            ),
                                                            child:
                                                             Text(" ${Step} " )
                                                                // Text(" subDocs.length" )
                                                             
                                                             ),
                                                                 
                                                                 ],),
                                 ),
                                
                                  Column(
                                 
                                  children: [
                                    
                                                         Row(
                                                           children: [
                                                             Text(" ${daysDifference} Days " ),

                                                ],
                                                         ),
                                
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
                    ),
                        
                  //           ListTile(
                  //              onTap: () {
                  //            Get.to( StepsCompleted(id:userId,));    
                  //              },
                               
                  //             title: Text(" ${names} " ), 

                  //              trailing: 
                  //              IconButton(
                  //   icon: Icon(Icons.delete),
                  //   onPressed: () {
                  //     _deleteDocument(userId,ids);
                  //   },
                  // ),
                             
                  //             // subtitle:Text("${description} ---- ${payment} " ), 
                  //           )
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
                    )
//                                 Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Container(
//                          decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(10),
//                      color: Colors.green.withOpacity(0.2),
//                    ),
//                         child: Column(
//                           children: [
             
                         
                        
//                             ListTile(
                        
//                               title: Text(" ${names} " ), 
//                              onTap: () {
//                                 Get.to(()=> StepsCompleted(id:userId),);
//                              },
//                               // subtitle:Text("${description} ---- ${payment} " ), 
//                             )
//                             //   ListTile(
                        
//                             //   title: Text(" ${officerName} apply for payment clearance to approved thePayment: ${payment}. for the Customer -- ${customerName} " ), 
                             
//                             //   // subtitle:Text("${description} ---- ${payment} " ), 
//                             // )
//                             // ,
                                        
                       
// //      ElevatedButton(
// //                         onPressed: () async{
                         
// //        try{
// //         EasyLoading.show();
// //  final usersRef = await FirebaseFirestore.instance.collection('users').doc(userId).collection('netMeteringProcedure');
               
// //  await usersRef.doc(ids).update({'noted':true,"approvalDateTimeFinance":DateTime.now()});

// //  EasyLoading.dismiss();
// //   }
// //   catch(e)
// //   {
// //  Get.snackbar("Error", "Issue in updating ${e}");
// //  EasyLoading.dismiss();
// //   }
 

  
      
                        
// //                         },
// //                         child: Text('Noted'),
// //                                         ),
                                        
                                        
//                           ],
//                         ),
//                       ),
//                     )
                    
                    :Container();
              
//               StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance.collection('users').doc(userId).collection('netMeteringProcedure')
//                 //   .where('payment', isNotEqualTo: 
//                 // "").where("noted",isEqualTo: false)
//                   .snapshots(),
//                 builder: (context, subSnapshot) {
//                   if (subSnapshot.hasData) {
//                     final subDocs = subSnapshot.data!.docs;
//                     // Process and display data from the sub-collection
//                     return ListView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: subDocs.length,
//                       itemBuilder: (context, subIndex) {
//                         // final subDoc = subDocs[subIndex];
//                         // final officerName = subDoc['officerName'];
//                         // final payment= subDoc['payment'];
//                         // final customerName = subDoc["customerName"];
//                         // final ids = subDoc.id;

//                         // ...

//                         return 
//                         inProcess == "inProcess"   ?
//                                 Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Container(
//                          decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(10),
//                      color: Colors.green.withOpacity(0.2),
//                    ),
//                         child: Column(
//                           children: [
             
                         
                        
//                             ListTile(
                        
//                               title: Text(" ${names} NetMetering procedure File status is Pending.Wotrking on it" ), 
//                              onTap: () {
//                                 Get.to(()=> StepsCompleted(id:userId,name:names),);
//                              },
//                               // subtitle:Text("${description} ---- ${payment} " ), 
//                             )
//                             //   ListTile(
                        
//                             //   title: Text(" ${officerName} apply for payment clearance to approved thePayment: ${payment}. for the Customer -- ${customerName} " ), 
                             
//                             //   // subtitle:Text("${description} ---- ${payment} " ), 
//                             // )
//                             // ,
                                        
                       
// //      ElevatedButton(
// //                         onPressed: () async{
                         
// //        try{
// //         EasyLoading.show();
// //  final usersRef = await FirebaseFirestore.instance.collection('users').doc(userId).collection('netMeteringProcedure');
               
// //  await usersRef.doc(ids).update({'noted':true,"approvalDateTimeFinance":DateTime.now()});

// //  EasyLoading.dismiss();
// //   }
// //   catch(e)
// //   {
// //  Get.snackbar("Error", "Issue in updating ${e}");
// //  EasyLoading.dismiss();
// //   }
 

  
      
                        
// //                         },
// //                         child: Text('Noted'),
// //                                         ),
                                        
                                        
//                           ],
//                         ),
//                       ),
//                     ):Container();
//                       },
//                     );
//                   } else if (subSnapshot.hasError) {
//                     return Text('Error: ${subSnapshot.error}');
//                   } else {
//                     return CircularProgressIndicator();
//                   }
//                 },
//               );
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
