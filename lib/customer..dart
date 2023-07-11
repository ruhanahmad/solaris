// import 'package:solaris/links.dart';
// import 'package:solaris/screens/aboutus.dart';

// import 'main.dart';
// import 'package:flutter/material.dart';

// import 'screens/complaint.dart';
// class Customer extends StatefulWidget {
//   @override
//   _CustomerState createState() => _CustomerState();
// }

// class _CustomerState extends State<Customer> {
//   int _currentIndex = 0;
//   final List<Widget> _screens = [
//      Links(),
//      ComplaintScreen(),
//       Text("data"),
//         Text("data"),
//         // AboutUsScreen (),
//     // ChatsScreen(),
//     // StatusScreen(),
//     // CallsScreen(),
//   ];



//   //   int _selectedIndex = 0;  
//   // static const List<Widget> _widgetOptions = <Widget>[  
//   //   Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
//   //   Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
//   //   Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
//   // ];  
  
//   // void _onItemTapped(int index) {  
//   //   setState(() {  
//   //     _selectedIndex = index;  
//   //   });  
//   // }  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//  _screens[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.link),
//             label: 'Links',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message),
//             label: 'Complaints',
//           ),
//            BottomNavigationBarItem(
//             icon: Icon(Icons.task),
//             label: 'Tasks',
//           ),
          
//           BottomNavigationBarItem(
//             icon: Icon(Icons.info),
//             label: 'About us',
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:solaris/links.dart';
import 'package:solaris/screens/aboutus.dart';
import 'package:solaris/screens/complaint.dart';

import 'screens/profile.dart';  
  
  
class MyNavigationBar extends StatefulWidget {  
  MyNavigationBar ({Key? key}) : super(key: key);  
  
  @override  
  _MyNavigationBarState createState() => _MyNavigationBarState();  
}  
  
class _MyNavigationBarState extends State<MyNavigationBar > {  
  int _selectedIndex = 0;  
   List<Widget> _widgetOptions = <Widget>[  

   Links(),
   ComplaintScreen(),
   Text("ss"),
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
