import 'package:flutter/material.dart';



  Future<void>? alertPicture(String image,BuildContext context){
    showDialog(context: context, builder: (context){
      return     AlertDialog(
        content: 
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
           Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              // Add a border around the container (optional)
              border: Border.all(color: Colors.black, width: 2),
              // Use the Image.network widget to load the picture from the URL
              image: DecorationImage(
                image: NetworkImage(image ),
                fit: BoxFit.cover,
              ),
            ),
          ),
            
          ],
        ),
      );
    });
  }