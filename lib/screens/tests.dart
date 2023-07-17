import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyStreamScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Screen'),
      ),
      body: 
      StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('your_collection').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            
            // Access and process the data as needed
            // ...

            String textToShow = ''; // Variable to store the text to display

            for (var doc in documents) {
              textToShow += doc['your_field'].toString() + '\n';
            }

            return Text(textToShow);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference _dataCollection =
      FirebaseFirestore.instance.collection('data');
  CollectionReference _dropdownCollection =
      FirebaseFirestore.instance.collection('dropdown');

  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Fetching Example'),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _dataCollection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              final data = snapshot.data!.docs;

              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final document = data[index];
                  final fieldValue = document['name'];

                  return Column(
                    children: [
                      ListTile(
                        title: Text(fieldValue),
                        trailing: DropdownWidget(
                          collection: _dropdownCollection,
                          onValueChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                        ),
                      ),
                      Visibility(
                        visible: fieldValue == _selectedValue,
                        child: ElevatedButton(
                          child: Text('Button'),
                          onPressed: () {
                            // Handle button press here
                            print('Button pressed for $fieldValue');
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class DropdownWidget extends StatefulWidget {
  final CollectionReference collection;
  final ValueChanged<String> onValueChanged;

  DropdownWidget({required this.collection, required this.onValueChanged});

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  List<String> _dropdownValues = [];

  @override
  void initState() {
    super.initState();
    _fetchDropdownData();
  }

  Future<void> _fetchDropdownData() async {
    final snapshot = await widget.collection.get();
    final dropdownData =
        snapshot.docs.map((doc) => doc['value'] as String).toList();
    setState(() {
      _dropdownValues = dropdownData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: null,
      hint: Text('Select a value'),
      items: _dropdownValues.map((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        widget.onValueChanged(value!);
      },
    );
  }
}
