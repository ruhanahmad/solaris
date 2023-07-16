import 'package:flutter/material.dart';
import 'package:solaris/admin/approvalScreen.dart';
import 'package:solaris/admin/stepsCompleted.dart';
import 'package:solaris/screens/complaint.dart';
import 'package:solaris/screens/completedComplaint.dart';
import 'package:solaris/screens/previousComplaint.dart';


class netMeteringProcedure extends StatefulWidget {

  String id;
  String name;
  netMeteringProcedure({required this.id, required this.name});
  @override
  State<netMeteringProcedure> createState() => _netMeteringProcedureState();
}

class _netMeteringProcedureState extends State<netMeteringProcedure> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        
        appBar: AppBar(
        automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Approval Pending'),
              Tab(text: 'Steps Completed'),
          
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contents of Tab 1
           ApprovalScreen(),
            // Contents of Tab 2
           StepsCompleted(),
          
          ],
        ),
      ),
    );
  }
}
