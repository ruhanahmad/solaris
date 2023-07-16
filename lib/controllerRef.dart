import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solaris/controllers/adminController.dart';
import 'package:solaris/controllers/electricianController.dart';
import 'package:solaris/controllers/notificationController.dart';
import 'package:solaris/controllers/userController.dart';

import 'models/authentication_service.dart';


AuthenticationService auths = Get.put(AuthenticationService());
UserController userController = Get.put(UserController());
NotificationController notificationController = Get.put(NotificationController());
ElectricianController electricianController = Get.put(ElectricianController());
AdminController adminController = Get.put(AdminController());