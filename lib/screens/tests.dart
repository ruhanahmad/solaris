// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';



// class haha extends StatelessWidget {
//   void _onButtonPressed(BuildContext context) {
//     // When the button is pressed, run the function to compare the streams and show the bottom sheet
//     compareAndShowBottomSheet(context);
//   }

//   Stream<List<String>> getFirstCollectionData() {
//     // Replace 'firstCollection' with the name of your first collection in Firestore
//     CollectionReference collectionRef =
//         FirebaseFirestore.instance.collection('netMeteringSteps');

//     return collectionRef.snapshots().map((querySnapshot) {
//       return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
//     });
//   }

//   Stream<List<String>> getSecondCollectionData(String documentId) {
//     // Replace 'secondCollection' and 'subCollection' with the names of your second collection and subcollection in Firestore
//     CollectionReference collectionRef = FirebaseFirestore.instance
//         .collection('users')
//         .doc(documentId)
//         .collection('netMeteringProcedure');

//     return collectionRef.snapshots().map((querySnapshot) {
//       return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
//     });
//   }

//   void compareAndShowBottomSheet(BuildContext context) {
//     Stream<List<String>> firstStream = getFirstCollectionData();

//     firstStream.listen((firstNames) {
//       // Replace 'documentId' with the ID of the document you want to retrieve from the second collection
//       Stream<List<String>> secondStream =
//           getSecondCollectionData('18kMPyOYrzV2V9fJNyk3Dqz0Ju82');

//       secondStream.listen((secondNames) {
//         List<String> namesNotPresent = [];

//         for (var name in firstNames) {
//           if (!secondNames.contains(name)) {
//             namesNotPresent.add(name);
//           }
//         }

//         if (namesNotPresent.isNotEmpty) {
//           // Show the bottom sheet with the names not present in the second stream
//           _showBottomSheet(context, namesNotPresent);
//         }
//       });
//     });
//   }

//   void _showBottomSheet(BuildContext context, List<String> names) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           height: 200,
//           child: Center(
//             child: ListView.builder(
//               itemCount: names.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(names[index]),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Firestore Example'),
//       ),
//       body: 
//       Center(
//         child: ElevatedButton(
//           onPressed: () {
//             _onButtonPressed(context);
//           },
//           child: Text('Show Names Not Present'),
//         ),
//       ),
//     );
//   }
// }




// class FirestoreDataWidget extends StatelessWidget {
//   // Future<QuerySnapshot> fetchDataWithQuery(String collection, dynamic query) async {
//   //   return FirebaseFirestore.instance.collection(collection).where(query[0], isEqualTo: query[1]).get();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream:   FirebaseFirestore.instance.collection('users')
//         .where('netMetering', isEqualTo: true)
//         .get().asStream(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           // Extract document IDs from the fetched data
//           List<String> documentIds = [];
//           snapshot.data!.docs.forEach((doc) {
//             documentIds.add(doc.id);

//                      StreamBuilder<QuerySnapshot>(
//             stream: 
//              FirebaseFirestore.instance.collection('users').doc(doc.id).collection('netMeteringProcedure').get().asStream() ,
//             builder: (context, subSnapshot) {
//               if (subSnapshot.hasData) {
//                 // Get the length of documents in the sub-collection
//                 int subCollectionLength = subSnapshot.data!.docs.length;
//                 print(subCollectionLength);

//                 // Use subCollectionLength and other data in your app's body
//                 return YourAppBody(subCollectionLength: subCollectionLength);
//               } else {
//                 return Center(child: CircularProgressIndicator());
//               }
//             },
//           );
//           });

//           // Use the documentIds to apply the second query

//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//         return YourAppBodys();
//       },
//     );
//   }
// }

// class YourAppBody extends StatelessWidget {
//   final int subCollectionLength;

//   // Add other data you want to use in the body here

//   YourAppBody({required this.subCollectionLength});

//   @override
//   Widget build(BuildContext context) {
//     // Use subCollectionLength and other data here to build your app's UI
//     return Center(
//       child: Text('Sub-collection Length: $subCollectionLength'),
//     );
//   }
// }

// class YourAppBodys extends StatelessWidget {


//   @override
//   Widget build(BuildContext context) {
//     // Use subCollectionLength and other data here to build your app's UI
//     return Center(
//       child: Text("Sub-collection Length"),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';




// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class MyStreamScreen extends StatelessWidget {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Stream Screen'),
//       ),
//       body: 
//       StreamBuilder<QuerySnapshot>(
//         stream: _firestore.collection('your_collection').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            
//             // Access and process the data as needed
//             // ...

//             String textToShow = ''; // Variable to store the text to display

//             for (var doc in documents) {
//               textToShow += doc['your_field'].toString() + '\n';
//             }

//             return Text(textToShow);
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   CollectionReference _dataCollection =
//       FirebaseFirestore.instance.collection('data');
//   CollectionReference _dropdownCollection =
//       FirebaseFirestore.instance.collection('dropdown');

//   String? _selectedValue;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Data Fetching Example'),
//       ),
//       body: Column(
//         children: [
//           StreamBuilder<QuerySnapshot>(
//             stream: _dataCollection.snapshots(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return CircularProgressIndicator();
//               }

//               final data = snapshot.data!.docs;

//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: data.length,
//                 itemBuilder: (context, index) {
//                   final document = data[index];
//                   final fieldValue = document['name'];

//                   return Column(
//                     children: [
//                       ListTile(
//                         title: Text(fieldValue),
//                         trailing: DropdownWidget(
//                           collection: _dropdownCollection,
//                           onValueChanged: (value) {
//                             setState(() {
//                               _selectedValue = value;
//                             });
//                           },
//                         ),
//                       ),
//                       Visibility(
//                         visible: fieldValue == _selectedValue,
//                         child: ElevatedButton(
//                           child: Text('Button'),
//                           onPressed: () {
//                             // Handle button press here
//                             print('Button pressed for $fieldValue');
//                           },
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DropdownWidget extends StatefulWidget {
//   final CollectionReference collection;
//   final ValueChanged<String> onValueChanged;

//   DropdownWidget({required this.collection, required this.onValueChanged});

//   @override
//   _DropdownWidgetState createState() => _DropdownWidgetState();
// }

// class _DropdownWidgetState extends State<DropdownWidget> {
//   List<String> _dropdownValues = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchDropdownData();
//   }

//   Future<void> _fetchDropdownData() async {
//     final snapshot = await widget.collection.get();
//     final dropdownData =
//         snapshot.docs.map((doc) => doc['value'] as String).toList();
//     setState(() {
//       _dropdownValues = dropdownData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: null,
//       hint: Text('Select a value'),
//       items: _dropdownValues.map((value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       onChanged: (value) {
//         widget.onValueChanged(value!);
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TabBarWithDynamicTabNames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('TabBar with Dynamic Tab Names'),
          bottom: TabBar(
            tabs: [
              // You can use StreamBuilder here to dynamically update tab names
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('your_collection').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Tab(text: 'Loading...');
                  }

                  if (snapshot.hasError) {
                    return Tab(text: 'Error');
                  }

                  if (snapshot.hasData) {
                    int recordCount = snapshot.data!.docs.length;
                    return Tab(text: 'Tab 1 ($recordCount)');
                  }

                  return Tab(text: 'No Data');
                },
              ),
              Tab(text: 'Tab 2'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Your tab content for Tab 1
            Center(child: Text('Tab 1 Content')),
            // Your tab content for Tab 2
            Center(child: Text('Tab 2 Content')),
          ],
        ),
      ),
    );
  }
}
