import 'package:flutter/material.dart';
import 'package:solaris/admin/approvalScreen.dart';
import 'package:solaris/admin/approvalScreenPayment.dart';
import 'package:solaris/admin/stepsCompleted.dart';
import 'package:solaris/financeDeprt/approved.dart';
import 'package:solaris/financeDeprt/forApproval..dart';
import 'package:solaris/financeDeprt/salesApproval.dart';
import 'package:solaris/netMeteringOfficer/officerApprovedFiles.dart';
import 'package:solaris/netMeteringOfficer/officerPendingFiles.dart';
import 'package:solaris/netMeteringOfficer/officerSendForApproval.dart';
import 'package:solaris/netMeteringOfficer/requestform.dart';
import 'package:solaris/screens/complaint.dart';
import 'package:solaris/screens/completedComplaint.dart';
import 'package:solaris/screens/previousComplaint.dart';


class FinanceTabBar extends StatefulWidget {

  
  @override
  State<FinanceTabBar> createState() => _FinanceTabBarState();
}


class _FinanceTabBarState extends State<FinanceTabBar> {
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        
        appBar: AppBar(
        automaticallyImplyLeading: false,
         actions: [
    IconButton(
      icon: Icon(Icons.calendar_today),
      onPressed: () => _selectStartDate(context),
    ),
    IconButton(
      icon: Icon(Icons.calendar_today),
      onPressed: () => _selectEndDate(context),
    ),
  ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'NetMetering Approval'),
              //  Tab(text: 'Approval Pending Payment '),
              Tab(text: 'Sales Approval'),
                Tab(text: 'Approved'),
          
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contents of Tab 1
        ForApproal(startDate:selectedStartDate.millisecondsSinceEpoch,endDate:selectedEndDate.millisecondsSinceEpoch),
            // Contents of Tab 2
            // ApprovalScreenPayment(id:widget.id,name:widget.name),
         SalesApproval(),
          Approved(),
          
          ],
        ),
      ),
    );
  }
   DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
      });
    }
  }
}
