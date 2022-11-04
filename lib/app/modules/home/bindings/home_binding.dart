import 'package:get/get.dart';
import 'package:simantan/app/controllers/comment_controller.dart';
import 'package:sp_util/sp_util.dart';

import 'package:simantan/app/controllers/post_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(
      () => PostController(),
    );
    Get.lazyPut<CommentController>(() => CommentController());
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
