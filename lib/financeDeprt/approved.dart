import 'package:flutter/material.dart';
import 'package:solaris/admin/approvalScreen.dart';
import 'package:solaris/admin/approvalScreenPayment.dart';
import 'package:solaris/admin/stepsCompleted.dart';
import 'package:solaris/financeDeprt/forApproval..dart';
import 'package:solaris/financeDeprt/netMeteringApproved.dart';
import 'package:solaris/financeDeprt/salesApproval.dart';
import 'package:solaris/financeDeprt/salesApproved.dart';
import 'package:solaris/netMeteringOfficer/officerApprovedFiles.dart';
import 'package:solaris/netMeteringOfficer/officerPendingFiles.dart';
import 'package:solaris/netMeteringOfficer/officerSendForApproval.dart';
import 'package:solaris/netMeteringOfficer/requestform.dart';
import 'package:solaris/screens/complaint.dart';
import 'package:solaris/screens/completedComplaint.dart';
import 'package:solaris/screens/previousComplaint.dart';


class Approved extends StatefulWidget {

  
  @override
  State<Approved> createState() => _ApprovedState();
}

class _ApprovedState extends State<Approved> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        
        appBar: AppBar(
        automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: 'NetMetering Approved'),
              //  Tab(text: 'Approval Pending Payment '),
              Tab(text: 'sales Approved'),
             
          
            ],
          ),
        ),
        body: TabBarView(
          children: [
              NetMeteringApproved(),
            // Contents of Tab 1
       SalesApproved(),
            // Contents of Tab 2
            // ApprovalScreenPayment(id:widget.id,name:widget.name),
       
     
          
          ],
        ),
      ),
    );
  }
}
