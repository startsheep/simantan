import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void login() {
    // checking username and password
    if (usernameController.text == 'admin' &&
        passwordController.text == 'admin') {
      Get.snackbar('Login', 'Login Success');
      Get.offAllNamed('/home');
    } else {
      Get.snackbar('Login', 'Login Failed');
    }
  }
}
