import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';



class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final LatLng _companyLocation = LatLng(37.421998, -122.084);

  GoogleMapController? _mapController;

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Company Name',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Company Description...',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            // Container(
            //   height: 300,
            //   child: GoogleMap(
            //     initialCameraPosition: CameraPosition(
            //       target: _companyLocation,
            //       zoom: 15,
            //     ),
            //     markers: {
            //       Marker(
            //         markerId: MarkerId('companyMarker'),
            //         position: _companyLocation,
            //       ),
            //     },
            //     onMapCreated: (GoogleMapController controller) {
            //       setState(() {
            //         _mapController = controller;
            //       });
            //     },
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () async{
                  
//                                    await OneSignal.shared.postNotification(OSCreateNotification(
//   playerIds: ["f291b37f-63a5-4173-be71-f38b277052ba"], // Replace with the recipient's player ID
//   content: "You are added in netMetering Procedure!",
//   heading: "Hey ! You are added",
// ));
                },
                child: Text(
                  'Company Address',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '123 Main Street, City, Country',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
