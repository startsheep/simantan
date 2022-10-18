import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/routes/app_pages.dart';
import 'package:sp_util/sp_util.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isSubmit = false.obs;
  final RxBool isAuth = false.obs;

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
    isSubmit.value = true;
    Future.delayed(const Duration(seconds: 3), () {
      if (usernameController.text == 'admin' &&
          passwordController.text == 'admin') {
        // set isAuth to true
        isSubmit.value = false;
        isAuth.value = true;
        SpUtil.putBool('isAuth', true);
        update();
        // navigate to home page
        Get.offAllNamed(Routes.CORE);
      } else {
        // show dialog
        isSubmit.value = false;
        Get.defaultDialog(
          title: 'Login Gagal',
          middleText: 'Username atau Password salah',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
        );
      }
    });
  }

  void logout() {
    SpUtil.putBool('isAuth', false);
    Get.offAndToNamed(Routes.AUTH);
  }
}
