import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.putAsync(() => SpUtil.getInstance());
  }
}
