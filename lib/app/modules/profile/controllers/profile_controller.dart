import 'package:get/get.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/modules/auth/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  late AuthController authController;
  late PostController postController;
  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<PostController>(() => PostController());
    postController = Get.find<PostController>();
    authController = Get.find<AuthController>();
    postController.getMyPosts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
