
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solaris/admin/FilesPending.dart';
import 'package:solaris/admin/filePendingPayment.dart';
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


import 'package:image/image.dart' as img;


class AdminController extends GetxController {

UserController userController = Get.put(UserController());

String? id = "";
String? name = "";

 
 Future<void> generateAndUploadPdf(String officerName,String desc,String payment,String customerName,String userId,String docId) async {

// Uint8List writeDataOnImage(String data) {
//   // Create an image (400x200) with a white background
//   final image = img.Image(width: 200,height: 200);
//   final white = img.getColor(255, 255, 255);
//   img.fill(image, white);

//   // Create a font
//   final font = img.Font.ttf(await rootBundle.load('assets/fonts/YourFont.ttf'), 20);

//   // Draw the text on the image (centered horizontally and vertically)
//   final text = img.TextStyle(color: img.getColor(0, 0, 0), font: font);
//   img.drawString(image, img.CenteredText(data, style: text), 200, 100);

//   // Convert the image to bytes
//   return img.encodePng(image);
// }
EasyLoading.show();

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
    'pdfUrl': downloadURL,"sentForApproval":true,"approved":true,"sentToFinanceDateTime":DateTime.now(),"adminName":userController.userName
  });
  await firestore.collection('users').doc(userId).update({
    "Step":FieldValue.increment(1)
  });
 

  EasyLoading.dismiss();
}


 downloadPdf(String userId,String docId)async {
    final pdf = pw.Document();
  final firestore = FirebaseFirestore.instance;
  final docSnapshot =  await firestore.collection('users').doc(userId).collection("netMeteringProcedure").doc(docId).get();
  final data = docSnapshot.data();
  print(data);
  final downloadURL = data!['pdfUrl'];
  print(downloadURL);


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

Future updateApproval(String id,String netId,String docname) async{
try{

 final usersRef = await FirebaseFirestore.instance.collection('users');
 await usersRef.doc(id).collection("netMeteringProcedure").doc(netId).update({'approved':true,'sentForApproval':true,'approvedDateTime':DateTime.now(),"adminName":userController.userName});
 docname == "Net Metering Procedure Finished" ? await usersRef.doc(id).update({'inProcess':"Finished",}):await usersRef.doc(id).update({'inProcess':"inProcess",});

 usersRef.doc(id).update({"Step":FieldValue.increment(1)});
  }catch(e){
 Get.snackbar("Error", "Issue in updating ${e}");
  }

}





}