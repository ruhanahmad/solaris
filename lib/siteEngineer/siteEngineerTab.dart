import 'package:flutter/material.dart';
import 'package:solaris/electrician/pendingComplaint.dart';
import 'package:solaris/electrician/receivedComplaints.dart';
import 'package:solaris/electrician/resolved.dart';
import 'package:solaris/screens/complaint.dart';
import 'package:solaris/screens/completedComplaint.dart';
import 'package:solaris/screens/previousComplaint.dart';
import 'package:solaris/siteEngineer/assignedPage.dart';
import 'package:solaris/siteEngineer/complaintProcessing.dart';
import 'package:solaris/siteEngineer/resolvedByElectrician.dart';


class tabBarSiteEngineer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        
        appBar: AppBar(
        automaticallyImplyLeading: false,
          bottom: 
          TabBar(
            tabs: [
              Tab(text: 'New Complaints'),
              Tab(text: 'Assigned'),
              Tab(text: 'Resolved'),
            ],
          ),
        ),
        body:
         TabBarView(
          children: [
            // Contents of Tab 1
            ComplaintScreenProcessing(),
            // Contents of Tab 2
           
             AssignedPage(),
             ResolvedByElectrician(),
          ],
        ),
      ),
    );
  }
}
