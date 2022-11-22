import 'package:get/get.dart';

import 'package:simantan/app/modules/auth/controllers/auth_controller.dart';
import 'package:simantan/app/modules/profile/controllers/user_post_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserPostController>(
      () => UserPostController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}
