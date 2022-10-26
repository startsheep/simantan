import 'package:get/get.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/modules/auth/controllers/auth_controller.dart';
import 'package:simantan/app/modules/core/controllers/core_controller.dart';
import 'package:simantan/app/modules/home/controllers/home_controller.dart';
import 'package:simantan/app/modules/profile/controllers/profile_controller.dart';

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoreController>(
      () => CoreController(),
    );
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PostController>(() => PostController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
