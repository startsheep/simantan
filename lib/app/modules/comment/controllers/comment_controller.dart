import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/models/lazy_loading_filter.dart';
import 'package:simantan/app/providers/comment_provider.dart';
import 'package:simantan/app/theme/colors.dart';

class CommentController extends GetxController {
  final Rx<TextEditingController> message = TextEditingController().obs;
  final List<TextEditingController> messagesController =
      <TextEditingController>[].obs;
  final RxList comments = [].obs;
  final RxList _commentsByPost = [].obs;
  final RxBool isLoading = true.obs;
  final RxBool isSubmit = false.obs;
  String selectedCommentId = '';
  final showToolbar = false.obs;

  final _paginationFilter = LazyLoadingFilter().obs;
  final _lastPage = false.obs;
  int get _limit => _paginationFilter.value.limit!;
  int get _page => _paginationFilter.value.page!;
  bool get lastPage => _lastPage.value;
  List get commentsByPost => _commentsByPost.toList().obs;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<CommentProvider>(() => CommentProvider());
    Get.find<CommentProvider>().onInit();
    print("Comment Controller init");
  }

  @override
  void onReady() {
    super.onReady();
    getCommentsByPost();
  }

  @override
  void onClose() {}

  void getComments() async {
    print("getComments");
    final response =
        await Get.find<CommentProvider>().getComments(_paginationFilter.value);

    if (response.statusCode == 200) {
      isLoading.value = false;
      final _comments = json.encode(response.body['data']);
      comments.value = json.decode(_comments);
    }
  }

  Future<void> getCommentsByPost() async {
    print("getCommentsByPost");
    // isLoading.value = true;
    final response = await Get.find<CommentProvider>()
        .getCommentsByPost(Get.parameters['postId'].toString());
    if (response.statusCode == 200) {
      isLoading.value = false;
      _commentsByPost.assignAll(response.body['data']);
    }
  }

  void storeComment({
    String? postId,
  }) async {
    print("storeComment");
    isSubmit.value = true;
    final response = await Get.find<CommentProvider>().storeComment(
      message: message.value.text,
      postId: postId,
    );
    print(response.status);
    if (response.status.hasError) {
      Get.snackbar('Error', response.statusText.toString());
      isSubmit.value = false;
    } else {
      Get.snackbar('Success', response.statusText.toString());
      isSubmit.value = false;
      refresh();
      getCommentsByPost();
      message.value.clear();
    }
  }

  void deleteComment(String id) async {
    print("deleteComment");
    final response = await Get.find<CommentProvider>().deleteComment(id);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // show snackgr
      Get.snackbar(
        'Success',
        'Comment deleted successfully',
        // snackStyle: SnackStyle.GROUNDED,
        backgroundColor: SchemaColor.success,
        shouldIconPulse: true,
        icon: Icon(
          Icons.check_circle,
          color: Colors.white,
          size: 50,
        ),
      );
      getCommentsByPost();
    }
    ;
  }

  void changePaginationFilter(int page, int limit) {
    _paginationFilter.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }

  void changeTotalPerPage(int limitval) {
    _commentsByPost.clear();
    _lastPage.value = false;
    changePaginationFilter(1, limitval);
  }

  void loadNextPage() => changePaginationFilter(_page + 1, _limit);
}
