import 'package:flutter/material.dart';
import 'package:solaris/screens/complaint.dart';
import 'package:solaris/screens/completedComplaint.dart';
import 'package:solaris/screens/previousComplaint.dart';


class tabBars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        
        appBar: AppBar(
        automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Complaint'),
              Tab(text: 'Previous Complaint'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contents of Tab 1
           ComplaintScreen(),
            // Contents of Tab 2
           PreviousComplaint(),
             CompletedComplaint(),
          ],
        ),
      ),
    );
  }
}
