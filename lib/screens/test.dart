// // // import 'dart:io';

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_sound/flutter_sound.dart';
// // // import 'package:path_provider/path_provider.dart';
// // // import 'package:permission_handler/permission_handler.dart';
// // // import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// // // import 'package:cloud_firestore/cloud_firestore.dart';


// // // class VoiceMessageScreen extends StatefulWidget {
// // //   @override
// // //   _VoiceMessageScreenState createState() => _VoiceMessageScreenState();
// // // }

// // // class _VoiceMessageScreenState extends State<VoiceMessageScreen> {
// // //   FlutterSoundPlayer? _player;
// // //   FlutterSoundRecorder? _recorder;
// // //   String? _filePath;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _initializeFlutterSound();
// // //   }

// // //   Future<void> _initializeFlutterSound() async {
// // //     _player = FlutterSoundPlayer();
// // //     await _player!.openPlayer();
// // //     _recorder = FlutterSoundRecorder();
// // //     await _recorder!.openRecorder();
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _player?.closePlayer();
// // //     _player = null;
// // //     _recorder?.closeRecorder();
// // //     _recorder = null;
// // //     super.dispose();
// // //   }

// // //   Future<void> _startRecording() async {
// // //     if (await Permission.microphone.request().isGranted) {
// // //       final directory = await getTemporaryDirectory();
// // //       _filePath = '${directory.path}/recording.aac';
// // //       await _recorder!.startRecorder(toFile: _filePath!, codec: Codec.aacMP4);
// // //     } else {
// // //       print('Microphone permission denied');
// // //     }
// // //   }

// // //   Future<void> _stopRecording() async {
// // //     await _recorder!.stopRecorder();
// // //   }

// // //   Future<void> _playRecording() async {
// // //     await _player!.startPlayer(fromURI: _filePath!);
// // //   }

// // //   Future<void> _uploadRecording() async {
// // //     if (_filePath != null) {
// // //       final File file = File(_filePath!);
// // //       final fileName = '${DateTime.now().millisecondsSinceEpoch}.aac';

// // //       final firebase_storage.Reference ref =
// // //           firebase_storage.FirebaseStorage.instance.ref().child(fileName);
// // //       final uploadTask = ref.putFile(file);

// // //       await uploadTask.whenComplete(() {
// // //         print('File uploaded successfully');
// // //       }).catchError((error) {
// // //         print('File upload failed: $error');
// // //       });

// // //       final downloadUrl = await ref.getDownloadURL();

// // //       await FirebaseFirestore.instance.collection('voice_messages').add({
// // //         'downloadUrl': downloadUrl,
// // //       });

// // //       print('Voice message uploaded to Firestore');
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Voice Messages'),
// // //       ),
// // //       body: Center(
// // //         child: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             ElevatedButton(
// // //               onPressed: _startRecording,
// // //               child: Text('Start Recording'),
// // //             ),
// // //             ElevatedButton(
// // //               onPressed: _stopRecording,
// // //               child: Text('Stop Recording'),
// // //             ),
// // //             ElevatedButton(
// // //               onPressed: _playRecording,
// // //               child: Text('Play Recording'),
// // //             ),
// // //             ElevatedButton(
// // //               onPressed: _uploadRecording,
// // //               child: Text('Upload Recording'),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class MyWidget extends StatelessWidget {
// //   final FirebaseFirestore firestore = FirebaseFirestore.instance;

// //   @override
// //   Widget build(BuildContext context) {
// //     return 
// //     StreamBuilder<QuerySnapshot>(
// //       stream: firestore.collection('users').snapshots(),
// //       builder: (context, snapshot) {
// //         if (!snapshot.hasData) {
// //           return CircularProgressIndicator();
// //         }

// //         List<DocumentSnapshot> documents = snapshot.data.docs;

// //         List<String> names = documents.map((doc) => doc['name']).toList();

// //         return DropdownButton<String>(
// //           value: null, // selected value
// //           items: names.map<DropdownMenuItem<String>>((String value) {
// //             return DropdownMenuItem<String>(
// //               value: value,
// //               child: Text(value),
// //             );
// //           }).toList(),
// //           onChanged: (String selectedName) {
// //             DocumentSnapshot selectedDoc = documents.firstWhere(
// //               (doc) => doc['name'] == selectedName,
// //               orElse: () => null,
// //             );

// //             if (selectedDoc != null) {
// //               String selectedUserId = selectedDoc['userId'];
// //               String selectedEmail = selectedDoc['email'];

// //               // Call your other function with the selected user ID and email
// //               // otherFunction(selectedUserId, selectedEmail);
// //             }
// //           },
// //         );
// //       },
// //     );
// //   }
// // }
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'DropdownButton2 Demo',
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final List<String> items = [
//     'Item1',
//     'Item2',
//     'Item3',
//     'Item4',
//     'Item5',
//     'Item6',
//     'Item7',
//     'Item8',
//   ];
//   String? selectedValue;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//        Center(
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton2<String>(
//             isExpanded: true,
//             hint: const Row(
//               children: [
//                 Icon(
//                   Icons.list,
//                   size: 16,
//                   color: Colors.yellow,
//                 ),
//                 SizedBox(
//                   width: 4,
//                 ),
//                 Expanded(
//                   child: Text(
//                     'Select Item',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.yellow,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//             items: items
//                 .map((String item) => DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(
//                         item,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ))
//                 .toList(),
//             value: selectedValue,
//             onChanged: (String? value) {
//               setState(() {
//                 selectedValue = value;
//               });
//             },
//             buttonStyleData: ButtonStyleData(
//               height: 50,
//               width: 160,
//               padding: const EdgeInsets.only(left: 14, right: 14),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14),
//                 border: Border.all(
//                   color: Colors.black26,
//                 ),
//                 color: Colors.redAccent,
//               ),
//               elevation: 2,
//             ),
//             iconStyleData: const IconStyleData(
//               icon: Icon(
//                 Icons.arrow_forward_ios_outlined,
//               ),
//               iconSize: 14,
//               iconEnabledColor: Colors.yellow,
//               iconDisabledColor: Colors.grey,
//             ),
//             dropdownStyleData: DropdownStyleData(
//               maxHeight: 200,
//               width: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14),
//                 color: Colors.redAccent,
//               ),
//               offset: const Offset(-20, 0),
//               scrollbarTheme: ScrollbarThemeData(
//                 radius: const Radius.circular(40),
//                 thickness: MaterialStateProperty.all<double>(6),
//                 thumbVisibility: MaterialStateProperty.all<bool>(true),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               height: 40,
//               padding: EdgeInsets.only(left: 14, right: 14),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import "package:firebase_messaging/firebase_messaging.dart";
import 'package:flutter/material.dart';
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import 'package:onesignal_flutter/onesignal_flutter.dart';

// class NotificationPage extends StatelessWidget {
//   void sendNotification() async {
//      var deviceState = await OneSignal.shared.getDeviceState();

//     if (deviceState == null || deviceState.userId == null)
//         return;

//     var playerId = deviceState.userId!;
//      print("playeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer" +playerId);
//     var notification = OSCreateNotification(
//       playerIds: [playerId], // Specify the player IDs or segments to target, leave empty for all users
//       content: 'Notification Body',
//       heading: 'Notification Title',
//     );

//     var response = await OneSignal.shared.postNotification(notification);
//     print('Notification sent: ${response}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('OneSignal Example'),
//       ),
//       body:
//        Center(
//         child: ElevatedButton(
//           onPressed: () {
//             sendNotification();
//           },
//           child: Text('Send Notification'),
//         ),
//       ),
//     );
//   }
// }

// void handleNotificationOpened(OSNotificationOpenedResult result) {
//   // Handle opened notification here
//   print('Notification opened: ${result.notification.jsonRepresentation()}');
//   print('Additional data: ${result.notification.additionalData}');
// }

// class NotificationOpenedHandler extends StatefulWidget {
//   @override
//   _NotificationOpenedHandlerState createState() =>
//       _NotificationOpenedHandlerState();
// }

// class _NotificationOpenedHandlerState extends State<NotificationOpenedHandler> {
//   @override
//   void initState() {
//     super.initState();
//     OneSignal.shared.setNotificationOpenedHandler(handleNotificationOpened);
//   }

//   void sendNotification() async {
//     //  var deviceState = await OneSignal.shared.getDeviceState();

//     // if (deviceState == null || deviceState.userId == null)
//     //     return;

//     // var playerId = deviceState.userId!;
//     //  print("playeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer" +playerId);
//     var notification = OSCreateNotification(
//       playerIds: ["a99a04ce-f1f2-4d40-8bef-1df6b0187644"], // Specify the player IDs or segments to target, leave empty for all users
//       content: 'Notification Body',
//       heading: 'Notification Title',
//     );

//     var response = await OneSignal.shared.postNotification(notification);
//     print('Notification sent: ${response}');
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Center(
//         child: ElevatedButton(
//           onPressed: () {
//             sendNotification();
//           },
//           child: Text('Send Notification'),
//         ),
//       );
//   }
// }

// class Demo extends StatefulWidget {
// @override
// _DemoState createState() => _DemoState();
// }
// class _DemoState extends State<Demo> {
// FirebaseMessaging messaging = FirebaseMessaging.instance;
// late FlutterLocalNotificationsPlugin fltNotification;
// void pushFCMtoken() async {
// String? token=await messaging.getToken();
// print(token);
// //you will get token here in the console
// }
// @override
// void initState() {
//  super.initState();
//  pushFCMtoken();
//  initMessaging();
// }
// @override
// Widget build(BuildContext context) {
// return Scaffold(
//  backgroundColor: Colors.white,
//  body: Center(child: Text("Flutter Push Notifiction"),),);
// }
// void initMessaging() {
// var androiInit = AndroidInitializationSettings("@mipmap/ic_launcher");
// // var iosInit = IOSInitializationSettings();
// var initSetting = InitializationSettings(android: androiInit, );
// fltNotification = FlutterLocalNotificationsPlugin();
// fltNotification.initialize(initSetting);
// var androidDetails =
// AndroidNotificationDetails("1", "channelName", channelDescription: "channelDescription");
// // var iosDetails = IOSNotificationDetails();
// var generalNotificationDetails =
// NotificationDetails(android: androidDetails,);
// FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// RemoteNotification? notification=message.notification;
// AndroidNotification? android=message.notification?.android;
// if(notification!=null && android!=null){
// fltNotification.show(
// notification.hashCode, notification.title, notification.body, generalNotificationDetails);
// }});}
// }







//                    StreamBuilder<QuerySnapshot>(
//   stream:  FirebaseFirestore.instance
//                               .collection('users').doc(userid).collection("netMeteringProcedure").where("approved",isEqualTo: true).snapshots(),
//   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     if (snapshot.hasError) {
//       return Text('Error: ${snapshot.error}');
//     }

//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return Text('Loading...');
//     }
//     if  (snapshot.data!.docs.isEmpty){
//       return  Text('No data');
//     }

//     // Data is ready, you can access it using snapshot.data
//     final  documents = snapshot.data!.docs;

//     return ListView.builder(
//       itemCount: documents.length,
//       itemBuilder: (BuildContext context, int index) {
//        var ids = documents.first.id;
//                        var name = documents[index]['name'];
                      
//                        var officerName = documents[index]['name'];
                       

//         // Display the data
//         return ListTile(
//           title: Text(title),
//           subtitle: Text(description),
//         );
//       },
//     );
//   },
// )
// ,











import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class HomeScreenss extends StatelessWidget {
  final CollectionReference _dataCollection =
      FirebaseFirestore.instance.collection('data');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Fetching Example'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:  FirebaseFirestore.instance
        .collection('complaint').where("status",isEqualTo: "pending")
        .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data!.docs;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final document = data[index];
              final fieldValue = document['complaint'];

              return Column(
                children: [
                  ListTile(
                    title: Text(fieldValue),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream:
                 FirebaseFirestore.instance
                              .collection('users')
                              .where('role', isEqualTo:"electrician" )
                              .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox();
                      }

                      final dropdownData = snapshot.data!.docs;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: dropdownData.length,
                        itemBuilder: (context, index) {
                          final dropdownDocument = dropdownData[index];
                          final dropdownValue =
                              dropdownDocument['name'];
                          bool isButtonVisible = false;

                          return ListTile(
                            title: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                items: dropdownData
                                    .map((dropdownDocument) =>
                                        DropdownMenuItem<String>(
                                          value:
                                              dropdownDocument['dropdownValue'],
                                          child: Text(
                                              dropdownDocument['dropdownValue']),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  if (value != dropdownValue) {
                                    isButtonVisible = false;
                                  } else {
                                    isButtonVisible = true;
                                  }
                                },
                              ),
                            ),
                            trailing: Visibility(
                              visible: isButtonVisible,
                              child: ElevatedButton(
                                child: Text('Button'),
                                onPressed: () {
                                  // Handle button press here
                                  print('Button pressed for $fieldValue');
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

