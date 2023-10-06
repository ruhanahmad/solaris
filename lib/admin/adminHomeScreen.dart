
import 'package:flutter/material.dart';
import 'package:solaris/admin/FilesPending.dart';
import 'package:solaris/admin/NetMeteringCustomers.dart';
import 'package:solaris/admin/addSteps.dart';
import 'package:solaris/admin/netMeteringOfficersReviews.dart';
import 'package:solaris/admin/netMeteringtabs.dart';
import 'package:solaris/admin/stepsAndMaps.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/electrician/electricianDoComplaints.dart';
import 'package:solaris/electrician/receivedComplaints.dart';
import 'package:solaris/links.dart';
import 'package:solaris/screens/aboutus.dart';
import 'package:solaris/screens/complaint.dart';
import 'package:solaris/screens/profile.dart';
import 'package:solaris/screens/test.dart';
import 'package:solaris/siteEngineer/complaintProcessing.dart';
import 'package:solaris/siteEngineer/complaintSiteEngineer.dart';


  
  
class AdminHomeScreen extends StatefulWidget {  
  AdminHomeScreen ({Key? key}) : super(key: key);  
  
  @override  
  _AdminHomeScreenState createState() => _AdminHomeScreenState();  
}  
  
class _AdminHomeScreenState extends State<AdminHomeScreen > {  

  @override
  void initState() {
   userController.requestPermission();
    // TODO: implement initState
    super.initState();
  }
  int _selectedIndex = 0;  
   List<Widget> _widgetOptions = <Widget>[  

   Links(),
  StepsAndMaps(),
  NetMeteringCustomers(),
   AboutUsScreen(),
 Profile(),
   NetMeteringOfficersReviews(),
   netMeteringTabs(),
   FilesPending(),

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
         label: "Add",  
            backgroundColor: Colors.white, 
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.task_sharp),  
             label: "Metering",   
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
           BottomNavigationBarItem(  
            icon: Icon(Icons.verified_user),  
             label: "Approval",   
            backgroundColor: Colors.white,  
          ),  
            BottomNavigationBarItem(  
            icon: Icon(Icons.verified_user),  
             label: "Files",   
            backgroundColor: Colors.white,  
          ),  
            BottomNavigationBarItem(  
            icon: Icon(Icons.verified_user),  
             label: "Record",   
            backgroundColor: Colors.white,  
          ),  
 
        ],  
        // type: BottomNavigationBarType.shifting,  
        currentIndex: _selectedIndex,  
        selectedItemColor: Colors.black,  
        unselectedItemColor: Colors.grey,
        
        iconSize: 40,  
        onTap: _onItemTapped,  
        elevation: 5 ,
        type: BottomNavigationBarType.fixed, 
      ),  
    );  
  }  
}  
