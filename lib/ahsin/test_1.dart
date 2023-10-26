// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class Test1 extends StatefulWidget {
//   @override
//   _Test1State createState() => _Test1State();
// }

// class _Test1State extends State<Test1> {
//   List<TextEditingController> oddTextControllers = [];
//   List<TextEditingController> evenTextControllers = [];
//   @override
//   void dispose() {
//     for (var controller in oddTextControllers) {
//       controller.dispose();
//     }
//     for (var controller1 in evenTextControllers) {
//       controller1.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.green,
//         appBar: AppBar(
//           title: Text('Ahsin Test'),
//         ),
//         body: Center(
//           child: GestureDetector(
//               onTap: () {
//                 showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: true,
//                   builder: (BuildContext context) => DraggableScrollableSheet(
//                     initialChildSize: 0.4,
//                     maxChildSize: 0.8,
//                     expand: false,
//                     builder: (BuildContext context,
//                         ScrollController scrollController) {
//                       return Container(
//                         color: Colors.white,
//                         child: StreamBuilder<QuerySnapshot>(
//                           stream: FirebaseFirestore.instance
//                               .collection('netMeteringSteps')
//                               .snapshots(),
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               final documents = snapshot.data!.docs;

//                               oddTextControllers = List.generate(documents.length, (_) => TextEditingController());
//                               evenTextControllers = List.generate(documents.length, (_) => TextEditingController());

//                               return Column(
//                                 children: [
//                                   Expanded(
//                                     child:
//                                     ListView.builder(
//                                       controller: scrollController,
//                                       itemCount: documents.length,
//                                       itemBuilder: (context, index)
//                                       {
//                                         final document = documents[index];
//                                         return Column(
//                                           children: [
//                                             Text(document['name']??""),
//                                             SizedBox(
//                                               height: 4,
//                                             ),
//                                             TextField(
//                                               controller: oddTextControllers[index],
//                                               decoration: InputDecoration(
//                                                 hintText: 'Enter text',
//                                                 labelText: 'Text',
//                                                 border: OutlineInputBorder(),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 4,
//                                             ),
//                                             TextField(
//                                               controller: evenTextControllers[index],
//                                                decoration: InputDecoration(
//                                                 hintText: 'Enter text',
//                                                 labelText: 'Text',
//                                                 border: OutlineInputBorder(),
//                                               ),
//                                             )
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                   ElevatedButton(onPressed: (){
//                                     for(int i = 0; i<documents.length;i++){
//                                       QueryDocumentSnapshot doc = documents[i];
//                                       doc.reference.set({
//                                         "name": doc['name']??"",
//                                         "field1": oddTextControllers[i].text,
//                                         "field2": evenTextControllers[i].text
//                                       })
//                                           .then((value) => print('Data added successfully.'))
//                                           .catchError((error) => print('Failed to add data: $error'));
//                                     }

//                                   }, child: Text("Submit Data to Firestore"),)
//                                 ],
//                               );
//                             } else if (snapshot.hasError) {
//                               return Text('Error: ${snapshot.error}');
//                             } else {
//                               return SizedBox(
//                                   width: 40,
//                                   height: 40,
//                                   child: CircularProgressIndicator());
//                             }
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//               child: Text("Show Bottom Sheet")),
//         ));
//   }

// }


// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: TableExample(),
// //     );
// //   }
// // }

// // class TableExample extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Table Example'),
// //       ),
// //       body: 
// //       Center(
// //         child: 
// //         Table(
// //           border: TableBorder.all(),
// //           children: [
// //             TableRow(
// //               children: [
// //                 TableCell(
// //                   child: Center(child: Text('Header 1')),
// //                 ),
// //                 TableCell(
// //                   child: Center(child: Text('Header 2')),
// //                 ),
// //                 TableCell(
// //                   child: Center(child: Text('Header 3')),
// //                 ),
// //               ],
// //             ),
// //             TableRow(
// //               children: [
// //                 TableCell(
// //                   child: Center(child: Text('Row 1, Cell 1')),
// //                 ),
// //                 TableCell(
// //                   child: Center(child: Text('Row 1, Cell 2')),
// //                 ),
// //                 TableCell(
// //                   child: Center(child: Text('Row 1, Cell 3')),
// //                 ),
// //               ],
// //             ),
// //             TableRow(
// //               children: [
// //                 TableCell(
// //                   child: Center(child: Text('Row 2, Cell 1')),
// //                 ),
// //                 TableCell(
// //                   child: Center(child: Text('Row 2, Cell 2')),
// //                 ),
// //                 TableCell(
// //                   child: Center(child: Text('Row 2, Cell 3')),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }





// import 'package:flutter/material.dart';

// class User {
//   final int id;
//   final String name;

//   User(this.id, this.name);
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: UserList(),
//     );
//   }
// }

// class UserList extends StatefulWidget {
//   @override
//   _UserListState createState() => _UserListState();
// }

// class _UserListState extends State<UserList> {
//   String _searchQuery = "";
//   // Replace with your actual user data stream
//   Stream<List<User>> _userStream;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("User Search"),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               onChanged: (value) {
//                 setState(() {
//                   _searchQuery = value;
//                 });
//               },
//               decoration: InputDecoration(labelText: "Search by name or ID"),
//             ),
//           ),
//           StreamBuilder<List<User>>(
//             stream: _userStream, // Replace with your user data stream
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return CircularProgressIndicator();
//               }

//               final users = snapshot.data;

//               final filteredUsers = _searchQuery.isEmpty
//                   ? users
//                   : users.where((user) {
//                       final nameMatches = user.name.toLowerCase().contains(_searchQuery.toLowerCase());
//                       final idMatches = user.id.toString().contains(_searchQuery);
//                       return nameMatches || idMatches;
//                     }).toList();

//               return Expanded(
//                 child: ListView.builder(
//                   itemCount: filteredUsers.length,
//                   itemBuilder: (context, index) {
//                     final user = filteredUsers[index];
//                     return ListTile(
//                       title: Text(user.name),
//                       subtitle: Text("ID: ${user.id}"),
//                       // Add other user information as needed
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
