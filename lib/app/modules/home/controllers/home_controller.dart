import 'package:get/get.dart';
import 'package:simantan/app/controllers/post_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  late PostController postController;
  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<PostController>(() => PostController());
    postController = Get.find<PostController>();
    postController.onInit();
  }

  @override
  void onReady() {
    Get.lazyPut<PostController>(() => PostController());
    super.onReady();
    postController.fetchPosts();
  }

  @override
  void onClose() {}

  String formatDateTime(dateTime) {
    // parse to datetime to Datetime
    DateTime date = DateTime.parse(dateTime);
    return date.day.toString() +
        " " +
        date.month.toString() +
        " " +
        date.year.toString();
  }

  // List<d
}
