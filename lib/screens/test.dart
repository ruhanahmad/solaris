// // import 'dart:io';

// // import 'package:flutter/material.dart';
// // import 'package:flutter_sound/flutter_sound.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// // import 'package:cloud_firestore/cloud_firestore.dart';


// // class VoiceMessageScreen extends StatefulWidget {
// //   @override
// //   _VoiceMessageScreenState createState() => _VoiceMessageScreenState();
// // }

// // class _VoiceMessageScreenState extends State<VoiceMessageScreen> {
// //   FlutterSoundPlayer? _player;
// //   FlutterSoundRecorder? _recorder;
// //   String? _filePath;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializeFlutterSound();
// //   }

// //   Future<void> _initializeFlutterSound() async {
// //     _player = FlutterSoundPlayer();
// //     await _player!.openPlayer();
// //     _recorder = FlutterSoundRecorder();
// //     await _recorder!.openRecorder();
// //   }

// //   @override
// //   void dispose() {
// //     _player?.closePlayer();
// //     _player = null;
// //     _recorder?.closeRecorder();
// //     _recorder = null;
// //     super.dispose();
// //   }

// //   Future<void> _startRecording() async {
// //     if (await Permission.microphone.request().isGranted) {
// //       final directory = await getTemporaryDirectory();
// //       _filePath = '${directory.path}/recording.aac';
// //       await _recorder!.startRecorder(toFile: _filePath!, codec: Codec.aacMP4);
// //     } else {
// //       print('Microphone permission denied');
// //     }
// //   }

// //   Future<void> _stopRecording() async {
// //     await _recorder!.stopRecorder();
// //   }

// //   Future<void> _playRecording() async {
// //     await _player!.startPlayer(fromURI: _filePath!);
// //   }

// //   Future<void> _uploadRecording() async {
// //     if (_filePath != null) {
// //       final File file = File(_filePath!);
// //       final fileName = '${DateTime.now().millisecondsSinceEpoch}.aac';

// //       final firebase_storage.Reference ref =
// //           firebase_storage.FirebaseStorage.instance.ref().child(fileName);
// //       final uploadTask = ref.putFile(file);

// //       await uploadTask.whenComplete(() {
// //         print('File uploaded successfully');
// //       }).catchError((error) {
// //         print('File upload failed: $error');
// //       });

// //       final downloadUrl = await ref.getDownloadURL();

// //       await FirebaseFirestore.instance.collection('voice_messages').add({
// //         'downloadUrl': downloadUrl,
// //       });

// //       print('Voice message uploaded to Firestore');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Voice Messages'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             ElevatedButton(
// //               onPressed: _startRecording,
// //               child: Text('Start Recording'),
// //             ),
// //             ElevatedButton(
// //               onPressed: _stopRecording,
// //               child: Text('Stop Recording'),
// //             ),
// //             ElevatedButton(
// //               onPressed: _playRecording,
// //               child: Text('Play Recording'),
// //             ),
// //             ElevatedButton(
// //               onPressed: _uploadRecording,
// //               child: Text('Upload Recording'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class MyWidget extends StatelessWidget {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return 
//     StreamBuilder<QuerySnapshot>(
//       stream: firestore.collection('users').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return CircularProgressIndicator();
//         }

//         List<DocumentSnapshot> documents = snapshot.data.docs;

//         List<String> names = documents.map((doc) => doc['name']).toList();

//         return DropdownButton<String>(
//           value: null, // selected value
//           items: names.map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (String selectedName) {
//             DocumentSnapshot selectedDoc = documents.firstWhere(
//               (doc) => doc['name'] == selectedName,
//               orElse: () => null,
//             );

//             if (selectedDoc != null) {
//               String selectedUserId = selectedDoc['userId'];
//               String selectedEmail = selectedDoc['email'];

//               // Call your other function with the selected user ID and email
//               // otherFunction(selectedUserId, selectedEmail);
//             }
//           },
//         );
//       },
//     );
//   }
// }

