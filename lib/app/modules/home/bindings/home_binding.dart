import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import 'package:simantan/app/modules/home/controllers/post_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(
      () => PostController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
