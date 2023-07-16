
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/controllers/userController.dart';
import 'package:solaris/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart' show Document, Font, FontWeight, PageTheme;
import 'package:pdf/widgets.dart' as pw;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class AdminController extends GetxController {

UserController userController = Get.put(UserController());

String? id = "";
String? name = "";

 
 Future<void> generateAndUploadPdf(String officerName,String desc,String payment,String customerName,String userId,String docId) async {


  // Generate PDF
  final pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return
        pw.Column(children: [
           pw.Center(
          child: pw.Text('Document ID: $officerName'),
        )
        ,
        pw.Center(
          child: pw.Text('Document ID: $desc'),
        ),
          pw.Center(
          child: pw.Text('Document ID: $payment'),
        )
        ,
          pw.Center(
          child: pw.Text('Document ID: $customerName'),
        )
        ]);
        
      },
    ),
  );
var num;
  num  = await userController.tenNumberGenerated();
  // Save the PDF to a temporary file
  String customFilePath = '/path/to/save/pdf.pdf';
 final appDocumentsDir = await getApplicationDocumentsDirectory();
final output = await File('${appDocumentsDir.path}/$num.pdf').create();
  await output.writeAsBytes(await pdf.save());


  // Upload the PDF to Firebase Storage
  final storageRef = firebase_storage.FirebaseStorage.instance.ref().child('pdfs/$docId.pdf');
  await storageRef.putFile(output);

  // Get the download URL
  final downloadURL = await storageRef.getDownloadURL();

  // Store the download URL in Firestore
  final firestore = FirebaseFirestore.instance;
  await firestore.collection('users').doc(userId).collection("netMeteringProcedure").doc(docId).update({
    'pdfUrl': downloadURL,
  });
}


void downloadPdf(String documentId) async {
    final pdf = pw.Document();
  final firestore = FirebaseFirestore.instance;
  final docSnapshot =  await firestore.collection('users').doc(userId).collection("netMeteringProcedure").doc(docId).get();
  final data = docSnapshot.data();
  final downloadURL = data!['pdfURL'];


 final appDocumentsDir = await getApplicationDocumentsDirectory();
final output = await File('${appDocumentsDir.path}/$docId.pdf').create();
  await output.writeAsBytes(await pdf.save());
  // final appDir = Directory('path_to_save_downloaded_pdf');
  // await appDir.create(recursive: true);
  // final file = File('${appDir.path}/$userId.pdf');

  final http = HttpClient();
  final request = await http.getUrl(Uri.parse(downloadURL));
  final response = await request.close();
  await response.pipe(output.openWrite());

  print('PDF downloaded successfully.');
}

Future updateApproval(String id,String netId) async{
try{

 final usersRef = await FirebaseFirestore.instance.collection('users');
 await usersRef.doc(id).collection("netMeteringProcedure").doc(netId).update({'approved':true,});
  }catch(e){
 Get.snackbar("Error", "Issue in updating ${e}");
  }
}


}