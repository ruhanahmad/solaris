import 'package:flutter/material.dart';
import 'package:solaris/admin/approvalScreen.dart';
import 'package:solaris/admin/approvalScreenPayment.dart';
import 'package:solaris/admin/netMeteringOfficersReviews.dart';
import 'package:solaris/admin/netMeteringtabs.dart';
import 'package:solaris/admin/reviewsDead.dart';
import 'package:solaris/admin/stepsCompleted.dart';
import 'package:solaris/screens/complaint.dart';
import 'package:solaris/screens/completedComplaint.dart';
import 'package:solaris/screens/previousComplaint.dart';


class reviewsTabbar extends StatefulWidget {


 
  @override
  State<reviewsTabbar> createState() => _reviewsTabbarState();
}

class _reviewsTabbarState extends State<reviewsTabbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        
        appBar: AppBar(
        automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Active Officers'),
              //  Tab(text: 'Approval Pending Payment '),
              Tab(text: 'InActive Officers'),
          
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contents of Tab 1
           NetMeteringOfficersReviews(),
            // Contents of Tab 2
            // ApprovalScreenPayment(id:widget.id,name:widget.name),
           ReviewsDead(),
          
          ],
        ),
      ),
    );
  }
}
