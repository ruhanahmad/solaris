import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/models/authentication_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solaris/screens/test.dart';
import '../models/user_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class CompletedComplaint extends StatefulWidget {
  @override
  State<CompletedComplaint> createState() => _CompletedComplaintState();
}

class _CompletedComplaintState extends State<CompletedComplaint> {
 final TextEditingController _nameController = TextEditingController();
  final TextEditingController _complaintController = TextEditingController();
  
AuthenticationService auths = Get.put(AuthenticationService());







  var selectedValues;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;
     
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('PrevipComplaint Processing'),
      //   automaticallyImplyLeading: false,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
  SizedBox(height: halfHeight * 0.1),
               Text(
                'Complaints ',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: halfHeight * 0.1),

  StreamBuilder<QuerySnapshot>(
               stream:  FirebaseFirestore.instance
        .collection('complaint').where('userid', isEqualTo:auths.useri ).where('status', isEqualTo:"completed" )
        .snapshots(),
               
               builder: (context, snapshot) {
                 if (!snapshot.hasData) {
                   return CircularProgressIndicator();
                 }
      
                 final documents = snapshot.data!.docs;
      
               
      
                 return
                 Container(
                  height: MediaQuery.of(context).size.height -300,
                  width: MediaQuery.of(context).size.width,
                   child: 
                   ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){
                        var ids = documents[index].id;
                       var cusName = documents[index]['customerName'];
                var complaintDescription = documents[index]['complaint'];
                  var status = documents[index]['status'];
                                var image = documents[index]["complaintImage"];
                                        var userId = documents[index]["userid"];
                                     
                                        var ticketId = documents[index]["ticketId"];
                                        var assignedTo = documents[index]["assignedTo"];
                                        var reviews = documents[index]["customerReviews"];
                                        Timestamp dateTime = documents[index]["dateTime"] as Timestamp;
                                     DateTime  one=   dateTime.toDate();
                                        Timestamp dateTimeCompleted = documents[index]["dateTimeCompleted"] as Timestamp;
                                    DateTime two =    dateTimeCompleted.toDate();
                                        Duration difference  =two.difference(one);
                                        int days = difference.inDays;
  int hours = difference.inHours.remainder(24);
  int minutes = difference.inMinutes.remainder(60);
                                       
                                      

                              
                 return     Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                         decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: Colors.green.withOpacity(0.2),
                   ),
                        child: Column(
                          children: [
             
                         
                         
                            ListTile(
                              leading: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(image ?? ""),
                              ),
                              title:  Text("Your Complaint Generated ticket number: ${ticketId}.Description : ${complaintDescription} is Completed.Kindly give reviews.Total time spent to complete this task is ${days} day , ${hours} hours and ${minutes} minutes "
                              
                               ), 
                              trailing:Text("${status}",style: TextStyle(color: Colors.green),) ,
                              subtitle:
                              
                              RatingBar.builder(
   initialRating:reviews == 0 ? 0 :reviews,
   minRating: 1,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount: 5,
   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
   itemBuilder: (context, _) => Icon(
     Icons.star,
     color: Colors.amber,
   ),
   onRatingUpdate: (rating) {
    //  print(rating);
      userController.reviews = rating;
   
      userController.update();
   },
)
                              // Text("Complaint received from ${ids} " )
                              
                              , 
                            ),
                                   reviews == 0 ?     
                     
                                        ElevatedButton(
                        onPressed: () async{
                  // sendNotification();
    await  userController.giveReviews(ids,userController.reviews!);
                //  Get.to(()=>NotificationOpenedHandler()); 
                          print('Button Pressed!');
                        },
                        child: Text('Send'),
                                        ): Container()
                                        
                                        
                          ],
                        ),
                      ),
                    );
                    }),
                 );
              
               },
             ),





             
   

          ],
        ),
      ),
    );
  }
}
