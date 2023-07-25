import 'dart:io';
// import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/models/authentication_service.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_model.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class ComplaintScreen extends StatefulWidget {
  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
 final TextEditingController _nameController = TextEditingController();
  final TextEditingController _complaintController = TextEditingController();
  
AuthenticationService auths = Get.put(AuthenticationService());


// FlutterSoundRecorder _soundRecorder = FlutterSoundRecorder();
//   bool _isRecording = false;
//   String? _recordingPath;

  @override
  void initState() {
    super.initState();
    // _soundRecorder.openRecorder();
    // checkPermission();
  }
 



  @override
  void dispose() {
    // _soundRecorder.closeRecorder();
    super.dispose();
  }

  // Future<void> _startRecording() async {
  //   try {
  //     await _soundRecorder.startRecorder(toFile: 'temp_recording.aac');
  //     setState(() {
  //       _isRecording = true;
  //     });
  //   } catch (e) {
  //     print("Error starting recording: $e");
  //   }
  // }

  // Future<void> _stopRecording() async {
  //   try {
  //     var recordingResult = await _soundRecorder.stopRecorder();
  //     setState(() {
  //       _isRecording = false;
  //       _recordingPath = recordingResult;
  //     });
  //   } catch (e) {
  //     print("Error stopping recording: $e");
  //   }
  // }

  // void _uploadRecordingToFirebase() async {
  //   if (_recordingPath == null) {
  //     print("No recording to upload");
  //     return;
  //   }

  //   final storageRef = firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('voice_recordings')
  //       .child(DateTime.now().millisecondsSinceEpoch.toString() + '.aac');

  //   try {
  //     // await storageRef.putFile(File(_recordingPath));
  //     final downloadUrl = await storageRef.getDownloadURL();

  //     // Save the download URL in Firestore so other users can access it.
  //     await FirebaseFirestore.instance.collection('recordings').add({
  //       'url': downloadUrl,
  //       'createdAt': FieldValue.serverTimestamp(),
  //     });

  //     print("Recording uploaded successfully!");
  //   } catch (e) {
  //     print("Error uploading recording: $e");
  //   }
  // }

  
    Future<void>? alerts(){
    showDialog(context: context, builder: (context){
      return     AlertDialog(
        content: new
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          
            SizedBox(height: 30,),
            GestureDetector(
              onTap:(){
                // _pickImage(ImageSource.gallery);
                selectImages();
                Navigator.pop(context);
                print("object");
              } ,
              child: Row(
                children: [
                   Icon(Icons.browse_gallery),
       
                            //                Container(
                            // height: 40,
                            // width: 70,
                            // decoration: BoxDecoration(
                            //     color: Colors.black,
                            //     image: DecorationImage(image: AssetImage("assets/3.png"),fit: BoxFit.cover)),),
                  SizedBox(width: 5),
                  Text('Choose from Gallery '),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<void>? _clear() {
    setState(() => _imageFile = null,

    );
  }
   XFile? _imageFile;
    final ImagePicker _picker = ImagePicker();
    var imageFile;
    void  selectImages()async {
    final XFile? images = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {

   _imageFile =  images!;

    });
    
    // if (images !=null) {
    //     userController.imageFile = images.path == null ? "" :images.path;
    // userController.update();
    // }
  
  }


    void _submitComplaint(BuildContext context) {
    
    final String name = _nameController.text;
    final String complaint = _complaintController.text;

    if (name.isNotEmpty && complaint.isNotEmpty) {
       EasyLoading.show();

      FirebaseFirestore.instance.collection('complaints').add({
         "userid":auths.useri,
        'name': _nameController.text,
        'complaint': _complaintController.text,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Complaint submitted successfully!')),
        );
         EasyLoading.dismiss();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit complaint. Please try again.')),
        );
          EasyLoading.dismiss();
      });
       EasyLoading.dismiss();
    }
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Complaint'),
      //   automaticallyImplyLeading: false,
      // ),
      body: SingleChildScrollView(
        child:
         Container(
          height: mediaQuery.size.height,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     Colors.green[400]!,
            //     Colors.green[700]!,
            //   ],
            // ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // FlutterLogo(
              //   size: halfHeight * 0.25,
              //   colors: Colors.white,
              // ),
           
              Text(
                'Complaint',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: halfHeight * 0.1),
              // TextField(
              //   onChanged: (value) {
              //     userController.complaintName = value;
              //   },
              //   controller: _nameController,
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: Colors.green.withOpacity(0.2),
              //     hintText: 'Name',
              //     hintStyle: TextStyle(color: Colors.green),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8.0),
              //       borderSide: BorderSide.none,
              //     ),
              //     prefixIcon: Icon(Icons.person, color: Colors.green),
              //   ),
              //   style: TextStyle(color: Colors.green),
              // ),
              SizedBox(height: 16.0),
              TextField(
                  onChanged: (value) {
                  userController.complaint = value;
                },
                controller: _complaintController ,
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.green.withOpacity(0.2),
                  hintText: 'Complaint',
                  hintStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.message, color: Colors.green),
                ),
                style: TextStyle(color: Colors.green),
              ),
                  SizedBox(height: 24.0),
                   Center(child: GestureDetector(
                onTap: ()async{
                  await alerts();
                },
                 child: Container(height: 30,width: 30,child: IconButton(
                  onPressed: ()async {
                      await alerts();
                  }, 
                 icon: Icon(Icons.upload_file)),),
               ),),
                 if (_imageFile != null) ...[
                            Image.file(
                              width:200,
                              height:200,
                              File(
                                
                                _imageFile!.path)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // ElevatedButton(
                                //   child: Icon(Icons.crop),
                                //   onPressed: _cropImage,
                                // ),
                                ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Color(0xFF9D0105),),
                                  child: Icon(Icons.refresh,),
                                  onPressed: _clear,
                                ),
                             
          
          
                              ],
                            ),
            
                            // Uploader(file: _imageFile)
                          ],
              
              SizedBox(height: 24.0),




              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton(
                  onPressed: () async{
             bool? scene =  await  userController.checkIfCustomerExsistFromCustomerPanel();
              scene ==  true ?

              Get.snackbar("Complaint", "Complaint already registered."):
                                  await       userController.uploadFilesPassport(_imageFile,context);
                                  // await       userController.uploadFilesPassport(_imageFile,context);
                  },
                  child: Text(
                    'Submit Complaint',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
