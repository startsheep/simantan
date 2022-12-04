import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simantan/app/modules/auth/providers/auth_provider.dart';
import 'package:simantan/app/theme/colors.dart';

class ResetPasswordController extends GetxController {
  //TODO: Implement ResetPasswordController
  Rx<TextEditingController> oldPassControl = TextEditingController().obs;
  Rx<TextEditingController> newPassControl = TextEditingController().obs;
  Rx<TextEditingController> confirmPassControl = TextEditingController().obs;
  RxBool isShowOldPass = false.obs;
  RxBool isShowNewPass = false.obs;
  RxBool isShowConfirmPass = false.obs;
  RxBool isShowPass = false.obs;
  RxBool isLoading = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    Get.lazyPut<AuthProvider>(() => AuthProvider());
    Get.find<AuthProvider>().onInit();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void changePassword() async {
    isLoading.value = true;
    final response = await Get.find<AuthProvider>().changePassword(
      oldPass: oldPassControl.value.text,
      newPass: newPassControl.value.text,
      confirmPass: confirmPassControl.value.text,
    );
    // print(response.statusCode);
    if (response.statusCode == 200) {
      isLoading.value = false;
      print(response.statusCode);
      Get.back();
      Get.snackbar(
        "Berhasil",
        "Password berhasil diubah",
        backgroundColor: SchemaColor.primary,
        // colorText: Colors.white,
      );
    } else {
      isLoading.value = false;
      Get.snackbar(
        "Gagal",
        "Password gagal diubah",
        backgroundColor: SchemaColor.primary,
        // colorText: Colors.white,
      );
    }
  }
}
