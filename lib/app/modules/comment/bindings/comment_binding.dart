import 'package:get/get.dart';
import 'package:simantan/app/controllers/comment_controller.dart';

class CommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentController>(
      () => CommentController(),
    );
  }
}
