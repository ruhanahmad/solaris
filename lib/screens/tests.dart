import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
