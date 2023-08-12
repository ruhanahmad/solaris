import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SalesApproval extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('ReferalCustomers')
        .where('sendForApproval', isEqualTo: true).where('notedByFinance', isEqualTo: false)
        .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final usersDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: usersDocs.length,
            itemBuilder: (context, index) {
              final userDoc = usersDocs[index];
              final userId = userDoc.id;
              final sendForApproval = userDoc["sendForApproval"];
               final CustomerName = userDoc["CustomerName"];
                final CustomerCity = userDoc["CustomerCity"];
                 final CustomerPhone = userDoc["CustomerPhone"];
                 final notedByFinance = userDoc["notedByFinance"];

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
                        
                              title: Text(" ${CustomerName} apply for payment clearance to approved thePayment: ${CustomerCity}. for the Customer -- ${CustomerPhone} " ), 
                             
                              subtitle:Text("${userId}" ), 
                            ),
                                        
         notedByFinance == false ?              
     ElevatedButton(
                        onPressed: () async{
                         
       try{
        EasyLoading.show();
 final usersRef = await FirebaseFirestore.instance.collection('ReferalCustomers');
               
 await usersRef.doc(userId).update({'notedByFinance':true,});

 EasyLoading.dismiss();
  }
  catch(e)
  {
 Get.snackbar("Error", "Issue in updating ${e}");
 EasyLoading.dismiss();
  }
 

  
      
                        
                        },
                        child: Text('Noted'),
                                        ):Text("Noted By Finance")
                                        
                                        ,
                                        
                                        
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
