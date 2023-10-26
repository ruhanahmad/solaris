import 'package:flutter/material.dart';
import 'package:get/get.dart';




class AudioController extends GetxController{
  List vargya = ["Wifi","Breakers","Solar Panels","Battery","Solar Structure","Others"];

  String selectedValue = "";
   void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return
    
            ListView.builder(
              itemCount: vargya.length,
              itemBuilder: (context, index) {
          
                return ListTile(
                  title: Text(vargya[index]),
                  onTap: () {
                  
                      selectedValue = vargya[index];
                    
                
 

                    Navigator.pop(context);
                  },
                );
                
              },
            );
      
      },
    );
  }


}