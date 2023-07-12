import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solaris/controllers/userController.dart';

import 'models/authentication_service.dart';


AuthenticationService auths = Get.put(AuthenticationService());
UserController userController = Get.put(UserController());