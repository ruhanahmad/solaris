
import 'package:flutter/material.dart';
import 'package:solaris/controllerRef.dart';
import 'package:solaris/links.dart';
import 'package:solaris/screens/aboutus.dart';
import 'package:solaris/screens/complaint.dart';
import 'package:solaris/screens/profile.dart';
import 'package:solaris/screens/test.dart';
import 'package:solaris/siteEngineer/complaintProcessing.dart';

import 'package:solaris/siteEngineer/complaintSiteEngineer.dart';


  
  
class SiteEngineer extends StatefulWidget {  
  SiteEngineer ({Key? key}) : super(key: key);  
  
  @override  
  _SiteEngineerState createState() => _SiteEngineerState();  
}  
  
class _SiteEngineerState extends State<SiteEngineer > {  

  @override
  void initState() {
   userController.requestPermission();
    // TODO: implement initState
    super.initState();
  }
  int _selectedIndex = 0;  
   List<Widget> _widgetOptions = <Widget>[  

   Links(),
  ComplaintScreenSiteEngineer(),
   ComplaintScreenProcessing(),
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
         label: "Complaint",  
            backgroundColor: Colors.white, 
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.task_sharp),  
             label: "Tasks",   
            backgroundColor: Colors.white,  
          ),  
            BottomNavigationBarItem(  
            icon: Icon(Icons.info),  
             label: "About us",   
            backgroundColor: Colors.white,  
          ),  
           BottomNavigationBarItem(  
            icon: Icon(Icons.verified_user),  
             label: "Profile",   
            backgroundColor: Colors.white,  
          ),  
        ],  
        // type: BottomNavigationBarType.shifting,  
        currentIndex: _selectedIndex,  
        selectedItemColor: Colors.black,  
        unselectedItemColor: Colors.grey,
        
        iconSize: 40,  
        onTap: _onItemTapped,  
        elevation: 5  
      ),  
    );  
  }  
}  
