import 'package:flutter/material.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_blue/flutter_blue.dart' as blue;
import 'package:solaris/controllerRef.dart';

class ThermalPrinter extends StatefulWidget {


  @override
  State<ThermalPrinter> createState() => _ThermalPrinterState();
}


  // blue.FlutterBlue flutterBlue = blue.FlutterBlue.instance;
  // List<blue.BluetoothDevice> devicesList = [];


  void startDiscovery() {
    userController.flutterBlue.startScan(timeout: Duration(seconds: 4));
    userController.flutterBlue.scanResults.listen((results) {
      
        userController.devicesList = results.map((result) => result.device).toList();
        userController.update();
      });
  
  }
BlueThermalPrinter bluetoothPrinter = BlueThermalPrinter.instance;

void connectPrinter() async {
  try {
    bool? connected = await bluetoothPrinter.isConnected;
    if (connected == false) {
      List<BluetoothDevice> devices = await bluetoothPrinter.getBondedDevices();
      if (devices.isNotEmpty) {
        BluetoothDevice printer = devices[0]; // Replace with the desired printer device
        await bluetoothPrinter.connect(printer);
        printData();
      } else {
        print("No bonded devices found.");
      }
    } else {
      print("Printer is already connected.");
    }
  } catch (e) {
    print("Error connecting to printer: $e");
  }
}
 
void printData() async {
 
  
  try {
    // Send data to the printer (e.g., receipt data, text, etc.)
    String data = "Hello, this is a test print from Flutter!";
    await bluetoothPrinter.write(data);
    await bluetoothPrinter.printNewLine();
  } catch (e) {
    print("Error printing data: $e");
  }

}


void disconnectPrinter() async {
  try {
    bool? connected = await bluetoothPrinter.isConnected;
    if (connected == true) {
      await bluetoothPrinter.disconnect();
    } else {
      print("Printer is not connected.");
    }
  } catch (e) {
    print("Error disconnecting printer: $e");
  }
}

   Future<bool> checkPermission() async {
    if (!await Permission.bluetooth.isGranted    ) {
      PermissionStatus status = await Permission.bluetooth.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
    
  }

var value;
class _ThermalPrinterState extends State<ThermalPrinter> {
  @override
  Widget build(BuildContext context) {
    return 
  Scaffold(
    appBar:AppBar(actions:[
        Center(
          child: ElevatedButton(
            onPressed: () async {

            // startDiscovery();
               value = await checkPermission();
               value == true ?
               connectPrinter() :
               Get.snackbar("Bluetooth", "Bluetooth not");
              // Request Bluetooth permissions
           
            },
            child: Text('Request Bluetooth Permissions'),
          ),
        ),
    ]),
        body:
        //           Center(
        //   child: 
        //   ElevatedButton(
        //     onPressed: () async {
        //        value = await checkPermission();
        //        value == true ?
        //       connectPrinter() :
        //        Get.snackbar("Bluetooth", "Bluetooth not");
        //       // Request Bluetooth permissions
           
        //     },
        //     child: Text('Request Bluetooth Permissions'),
        //   ),
        // ),
        ListView.builder(
        itemCount: userController.devicesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(  userController.devicesList[index].name),
            subtitle: Text(userController.devicesList[index].id.toString()),
            onTap: () {
              _connectToDevice(userController.devicesList[index]);
            },
          );
        },
      ),
        //  Center(
        //   child: ElevatedButton(
        //     onPressed: () async {
        //        value = await checkPermission();
        //        value == true ?
        //        printData() :
        //        Get.snackbar("Bluetooth", "Bluetooth not");
        //       // Request Bluetooth permissions
           
        //     },
        //     child: Text('Request Bluetooth Permissions'),
        //   ),
        // ),
      );
      
  }
  void _connectToDevice(blue.BluetoothDevice device) async {
  try {
    await device.connect;
    // Device is now connected, perform actions as needed
    print('Connected to ${device.name}');
  } catch (e) {
    print("Error connecting to device: $e");
  }
}

}
