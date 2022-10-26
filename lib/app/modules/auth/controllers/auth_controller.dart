import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/modules/auth/providers/auth_provider.dart';
import 'package:simantan/app/routes/app_pages.dart';
import 'package:sp_util/sp_util.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isSubmit = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isAuth = false.obs;
  final RxBool isPasswordvisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<AuthProvider>(() => AuthProvider());
    Get.find<AuthProvider>().onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void login() async {
    isSubmit.value = true;
    await Get.find<AuthProvider>()
        .login(usernameController.text, passwordController.text)
        .then((value) {
      // print(value.body);

      if (value.statusCode == 200) {
        isAuth.value = true;
        isSubmit.value = false;
        SpUtil.putBool('isAuth', true);
        // Get.offAllNamed(Routes.CORE);
      } else {
        // error notifications
        isAuth.value = false;
        isSubmit.value = false;
        Get.snackbar('asdas', 'asdasd');
      }
    });
  }

  void logout() async {
    isLoading.value = true;
    await Get.find<AuthProvider>().logout().then((value) {
      print(value.body);
      if (value.statusCode == 200) {
        isAuth.value = false;
        SpUtil.putBool('isAuth', false);
        Get.offAllNamed(Routes.AUTH);
      } else {
        isLoading.value = false;
      }
    });
  }
}
