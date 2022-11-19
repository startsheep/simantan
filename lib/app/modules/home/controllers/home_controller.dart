import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import 'package:simantan/app/modules/comment/controllers/comment_controller.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/modules/comment/controllers/comment_controller.dart';
import 'package:simantan/app/providers/comment_provider.dart';
import 'package:simantan/app/routes/app_pages.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  late PostController postController;
  late CommentController commentController;
  final List<TextEditingController> commentsController =
      <TextEditingController>[];
  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<PostController>(() => PostController());
    Get.lazyPut<CommentProvider>(() => CommentProvider());
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

  void storeComment(
    int index, {
    String? postId,
    String? message,
  }) async {
    final response = await Get.find<CommentProvider>()
        .storeComment(postId: postId, message: message);
    if (response.statusCode == 201) {
      commentsController[index].clear();
      Get.toNamed(Routes.COMMENT, parameters: {'postId': postId!});
    }
  }
  // List<d
}
