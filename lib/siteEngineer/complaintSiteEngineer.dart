import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/controllers/audioController.dart';
import 'package:solaris/models/authentication_service.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_model.dart';

class ComplaintScreenSiteEngineer extends StatefulWidget {
  @override
  State<ComplaintScreenSiteEngineer> createState() => _ComplaintScreenSiteEngineerState();
}

class _ComplaintScreenSiteEngineerState extends State<ComplaintScreenSiteEngineer> {
 final TextEditingController _nameController = TextEditingController();
  final TextEditingController _complaintController = TextEditingController();
  AudioController audioController = Get.put(AudioController());
  
AuthenticationService auths = Get.put(AuthenticationService());
 bool isSending = false;
bool?  isPlayingMsg ;

    Future<bool> checkPermissionSound() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }
 int i = 0;
  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }
  String recordFilePath="";
  void startRecord() async {
    bool hasPermission = await checkPermissionSound();
    if (hasPermission) {
      print("yes");
      recordFilePath = await getFilePath();

      RecordMp3.instance.start(recordFilePath, (type) {
        setState(() {});
      });
    } else {}
    setState(() {});
  }



  void stopRecord() async {
    bool s = RecordMp3.instance.stop();
    if (s) {
      setState(() {
        isSending = true;
      });
      // await uploadAudio();

      setState(() {
        isPlayingMsg = false;
      });
    }
  }

 void play()async {
    if (recordFilePath != null && File(recordFilePath).existsSync()) {
      AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(UrlSource(recordFilePath));
      
    }
  }
  
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
  String _selectedValue = '';
 void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StreamBuilder<QuerySnapshot>(
          stream:  FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo:"customer" )
        .snapshots(),
               
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            final records = snapshot.data!.docs;
            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final fieldValue = records[index]['name'];
                return ListTile(
                  title: Text(fieldValue),
                  onTap: () {
                    setState(() {
                      _selectedValue = fieldValue;
                    });
                     DocumentSnapshot<Object?>? selectedDoc = records.firstWhere(
                             (doc) => doc['name'] == _selectedValue,);
  if (selectedDoc != null) {
   
                              userController.selectedUserId = selectedDoc['id'] as String;
                              print(userController.selectedUserId);
                              userController.update();
                             userController.selectedName = selectedDoc['name'] as String;
                               print(userController.selectedName);
                                    userController.update();
                     
                           }

                    Navigator.pop(context);
                  },
                );
                
              },
            );
          },
        );
      },
    );
  }


  var selectedValues;



  List vargya = ["Wifi","Breakers","Solar Panels","Battery","Solar Structure","Others"];

  String selectedValuess = "";
   void openBottomSheetss(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return
    
            ListView.builder(
              itemCount: vargya.length,
              itemBuilder: (context, index) {
          
                return ListTile(
                  title: Text(vargya[index]),
                  onTap: () {
                    
                  setState(() {
             audioController.selectedValue = vargya[index]; 
             audioController.update();
                 print(vargya[index]);       
                  });
                     
           
                


                    Navigator.pop(context);
                  },
                );
                
              },
            );
      
      },
    );
   }








  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfHeight = mediaQuery.size.height * 0.5;
     
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint'),
        automaticallyImplyLeading: false,
      ),
      body: 
      
     
      
      SingleChildScrollView(
        child: Column(
          children: [
  SizedBox(height: halfHeight * 0.1),
               Text(
                'Complaint',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: halfHeight * 0.1),
        //     StreamBuilder<QuerySnapshot>(
        //        stream:  FirebaseFirestore.instance
        // .collection('users')
        // .where('role', isEqualTo:"customer" )
        // .snapshots(),
               
        //        builder: (context, snapshot) {
        //          if (!snapshot.hasData) {
        //            return CircularProgressIndicator();
        //          }
      
        //          List<DocumentSnapshot> documents = snapshot.data!.docs;
      
        //          List<String> names = documents.map((doc) => doc['name'] as String ).toList() ;
        // String fieldData = documents.first['name'];
                //  return Column(
                //    children: [
 ElevatedButton(
                onPressed: () {
                  // Open the bottom sheet passing the field data
                  openBottomSheetss(context);
                },
                child: Text('Steps'),
              ),


                   ElevatedButton(
                onPressed: () {
                  // Open the bottom sheet passing the field data
                   openBottomSheet(context);
                },
                child: Text('Select Customer'),
              ),
         _selectedValue == "" ?     Text("Customer Name :No Customer Selected"):Text("Customer Name ${_selectedValue}")
                    //  Container(
                    //    width: MediaQuery.of(context).size.width /4,
                    //    child: DropdownButton<String>(
                    //      value: null, // selected value
                    //      items: names.map<DropdownMenuItem<String>>((String value) {
                    //        return 
                    //        DropdownMenuItem<String>(
                    //          value: value,
                    //          child: Text(value),
                    //        );
                    //      }).toList(),
                    //        onChanged: (dynamic selectedName) {
                    //        String selectedNameString = selectedName as String;
                     
                    //          DocumentSnapshot<Object?>? selectedDoc = documents.firstWhere(
                    //          (doc) => doc['name'] == selectedNameString,
                    //          // orElse: () => null,
                    //        );
                    //        setState(() {
                    //           selectedValues = selectedDoc;
                    //        });
                               
                    //        if (selectedDoc != null) {
                    //           userController.selectedUserId = selectedDoc['id'] as String;
                    //           userController.update();
                    //          userController.selectedName = selectedDoc['name'] as String;
                    //                 userController.update();
                     
                    //          // Call your other function with the selected user ID and email
                    //         //  otherFunction(selectedUserId, selectedEmail);
                    //        }
                    //      },
                    //    ),
                    //  ),
                //    ],
                //  );
            //    },
            //  ),



    ,         
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
              // SizedBox(height: 16.0),
              
             audioController.selectedValue == "Others" ?

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
              )
              :
              Container()
              ,
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

GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              play();
            },
            child: Container(
              margin: EdgeInsets.only(top: 30),
              alignment: AlignmentDirectional.center,
              width: 100,
              height: 50,
              child:  recordFilePath != null
                  ? Text(
                      "play",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    )
                  : Container(),
            ),
          ),
   
 Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
   children: [
     SizedBox(
                    width: 100,
                    height: 48.0,
                    child: ElevatedButton(
                      onPressed: () async{

                          setState(() {
                        isPlayingMsg = true;
                    });
startRecord();
                      },
                      child: Text(
                        'Record',
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
                  SizedBox(
                width: 100,
                height: 48.0,
                child: ElevatedButton(
                  onPressed: () async{

                      setState(() {
                    isPlayingMsg = false;
                });
stopRecord();
                  },
                  child: Text(
                    'Stop',
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
SizedBox(height: 10,),
isPlayingMsg == true ? Text("Recording Start") :Text("Recording End"),

 

        _selectedValue != "" ?
              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton(
                  onPressed: () async{

                                  
                                  await       userController.uploadFilesPassport(_imageFile,context,recordFilePath);
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
              ):Text('Select Customer First'),
            ],
          ),
        ),

          ],
        ),
      ),
    );
  }


}
