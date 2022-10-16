import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.lazyPut(() => Typography());
    Get.putAsync(() => SpUtil.getInstance());
  }
}
