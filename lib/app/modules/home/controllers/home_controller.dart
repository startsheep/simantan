import 'package:get/get.dart';
// import 'package:simantan/app/modules/comment/controllers/comment_controller.dart';
import 'package:simantan/app/controllers/post_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  late PostController postController;
  // late CommentController commentController;
  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<PostController>(() => PostController());
    // Get.lazyPut<CommentController>(() => CommentController());
    // commentController = Get.find<CommentController>();
    postController = Get.find<PostController>();
    postController.onInit();
    ever(postController.paginationFilter, (_) => postController.fetchPosts());
    postController.changePaginationFilter(1, 5);
  }

  @override
  void onReady() {
    // Get.lazyPut<CommentController>(() => CommentController());
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

  Future<void> refreshPage() async {
    postController.fetchPosts();
  }
  // List<d
}
