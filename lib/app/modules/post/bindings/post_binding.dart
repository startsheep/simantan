import 'package:get/get.dart';

import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/modules/post/controllers/like_controller.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LikeController>(
      () => LikeController(),
    );
    Get.lazyPut<PostController>(
      () => PostController(),
    );
  }
}
