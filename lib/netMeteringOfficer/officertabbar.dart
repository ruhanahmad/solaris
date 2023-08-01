import 'package:flutter/material.dart';
import 'package:solaris/admin/approvalScreen.dart';
import 'package:solaris/admin/approvalScreenPayment.dart';
import 'package:solaris/admin/stepsCompleted.dart';
import 'package:solaris/netMeteringOfficer/officerSendForApproval.dart';
import 'package:solaris/netMeteringOfficer/requestform.dart';
import 'package:solaris/screens/complaint.dart';
import 'package:solaris/screens/completedComplaint.dart';
import 'package:solaris/screens/previousComplaint.dart';


class NetMeteringOfficer extends StatefulWidget {

  
  @override
  State<NetMeteringOfficer> createState() => _NetMeteringOfficerState();
}

class _NetMeteringOfficerState extends State<NetMeteringOfficer> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        
        appBar: AppBar(
        automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Request Form'),
              //  Tab(text: 'Approval Pending Payment '),
              Tab(text: 'Pending'),
                Tab(text: 'Approval'),
          
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contents of Tab 1
         RequestFormNetMetering(),
            // Contents of Tab 2
            // ApprovalScreenPayment(id:widget.id,name:widget.name),
         OfficerSendForApproval(),
          OfficerSendForApproval(),
          
          ],
        ),
      ),
    );
  }
}
