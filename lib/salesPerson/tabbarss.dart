import 'package:flutter/material.dart';
import 'package:solaris/salesPerson/personalClients.dart';
import 'package:solaris/salesPerson/referalClients.dart';
import 'package:solaris/screens/complaint.dart';
import 'package:solaris/screens/completedComplaint.dart';
import 'package:solaris/screens/previousComplaint.dart';


class tabbs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        
        appBar: AppBar(
        automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Refer Clients'),
              Tab(text: 'Personal Clients'),
             
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contents of Tab 1
             ReferalClients(),
            // Contents of Tab 2
          PersonalClients(),
            
          ],
        ),
      ),
    );
  }
}
