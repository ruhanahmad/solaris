
import 'package:flutter/material.dart';
import 'package:solaris/admin/netMeteringtabs.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/electrician/electricianDoComplaints.dart';
import 'package:solaris/electrician/receivedComplaints.dart';
import 'package:solaris/links.dart';
import 'package:solaris/salesPerson/referalClients.dart';
import 'package:solaris/salesPerson/referalScreen.dart';
import 'package:solaris/salesPerson/tabbarss.dart';
import 'package:solaris/screens/aboutus.dart';
import 'package:solaris/screens/complaint.dart';
import 'package:solaris/screens/profile.dart';
import 'package:solaris/screens/test.dart';
import 'package:solaris/siteEngineer/complaintProcessing.dart';
import 'package:solaris/siteEngineer/complaintSiteEngineer.dart';


  
  
class SalesPerson extends StatefulWidget {  
  SalesPerson ({Key? key}) : super(key: key);  
  
  @override  
  _SalesPersonState createState() => _SalesPersonState();  
}  
  
class _SalesPersonState extends State<SalesPerson > {  

  @override
  void initState() {
   userController.requestPermission();
    // TODO: implement initState
    super.initState();
  }
  int _selectedIndex = 0;  
   List<Widget> _widgetOptions = <Widget>[  

   Links(),
  ReferalScreen(),
tabbs(),
netMeteringTabs(),
   AboutUsScreen(),
   Profile(),
  ];  
  
  void _onItemTapped(int index) {  
    setState(() {  
      _selectedIndex = index;  
    });  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      // appBar: AppBar(  
      //   title: const Text('Flutter BottomNavigationBar Example'),  
      //     backgroundColor: Colors.green  
      // ),  
      body: Center(  
        child: _widgetOptions.elementAt(_selectedIndex),  
      ),  
      bottomNavigationBar: BottomNavigationBar(  
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        items: const <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
            icon: Icon(Icons.link),  
            label: "Links",  
            backgroundColor: Colors.white  ,
           
           

          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.comment),  
         label: "Customer",  
            backgroundColor: Colors.white, 
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.task_sharp),  
             label: "Clients",   
            backgroundColor: Colors.white,  
          ), 
          BottomNavigationBarItem(  
            icon: Icon(Icons.verified_user),  
             label: "Files",   
            backgroundColor: Colors.white,  
          ),   
            BottomNavigationBarItem(  
            icon: Icon(Icons.info),  
             label: "About us",   
            backgroundColor: Colors.white,  
          ), 
           
           BottomNavigationBarItem(  
            icon: Icon(Icons.verified_user),  
             label: "Logout",   
            backgroundColor: Colors.white,  
          ),  
        ],  
        // type: BottomNavigationBarType.shifting,  
        currentIndex: _selectedIndex,  
        selectedItemColor: Colors.black,  
        unselectedItemColor: Colors.grey,
        
        iconSize: 40,  
        onTap: _onItemTapped,  
        elevation: 5  ,
        type: BottomNavigationBarType.fixed,
      ),  
    );  
  }  
}  
