import 'package:get/get.dart';
import 'package:simantan/app/modules/auth/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  late AuthController authController;
  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<AuthController>(() => AuthController());
    authController = Get.find<AuthController>();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
