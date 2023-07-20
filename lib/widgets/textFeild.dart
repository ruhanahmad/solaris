

import 'package:flutter/material.dart';
import 'package:solaris/controllerRef.dart';



Widget textField (String hintText,String onChanges,BuildContext context) {
  return   
   TextField(
                onChanged: (value) {
                  onChanges = value;
                },
                // controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.green.withOpacity(0.2),
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  // prefixIcon: Icon(Icons.person, color: Colors.green),
                ),
                style: TextStyle(color: Colors.green),
              );
}