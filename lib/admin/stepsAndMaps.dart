import 'package:flutter/material.dart';
import 'package:solaris/admin/addMaps.dart';
import 'package:solaris/admin/addSteps.dart';
import 'package:solaris/admin/approvalScreen.dart';
import 'package:solaris/admin/approvalScreenPayment.dart';
import 'package:solaris/admin/stepsCompleted.dart';
import 'package:solaris/screens/complaint.dart';
import 'package:solaris/screens/completedComplaint.dart';
import 'package:solaris/screens/previousComplaint.dart';


class StepsAndMaps extends StatefulWidget {

 
  @override
  State<StepsAndMaps> createState() => _StepsAndMapsState();
}

class _StepsAndMapsState extends State<StepsAndMaps> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        
        appBar: AppBar(
        automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Add Steps'),
              //  Tab(text: 'Approval Pending Payment '),
              Tab(text: 'Add Location'),
          
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contents of Tab 1
           AddSteps(),
            // Contents of Tab 2
            // ApprovalScreenPayment(id:widget.id,name:widget.name),
           AddMaps(),
          
          ],
        ),
      ),
    );
  }
}
