import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/models/lazy_loading_filter.dart';
import 'package:simantan/app/providers/comment_provider.dart';

class CommentController extends GetxController {
  final Rx<TextEditingController> message = TextEditingController().obs;
  final List<TextEditingController> messagesController =
      <TextEditingController>[].obs;
  final RxList comments = [].obs;
  final RxList _commentsByPost = [].obs;
  final RxBool isLoading = true.obs;

  final _paginationFilter = LazyLoadingFilter().obs;
  final _lastPage = false.obs;
  int get _limit => _paginationFilter.value.limit!;
  int get _page => _paginationFilter.value.page!;
  bool get lastPage => _lastPage.value;
  List get commentsByPost => _commentsByPost.toList();

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<CommentProvider>(() => CommentProvider());
    Get.find<CommentProvider>().onInit();
    print("Comment Controller init");
    ever(_paginationFilter, (_) => getCommentsByPost());
    changePaginationFilter(1, 15);
  }

  @override
  void onReady() {
    super.onReady();
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

  void getCommentsByPost() async {
    final response = await Get.find<CommentProvider>().getCommentsByPost(
        Get.parameters['post_id'].toString(), _paginationFilter.value);
    if (response.body['data'].length < _limit) {
      if (response.body.isEmpty) {
        _lastPage.value = true;
      } else {
        _commentsByPost.addAll(response.body['data']);
      }
    }
  }

  void storeComment({
    String? postId,
    String? message,
  }) async {
    final response = await Get.find<CommentProvider>().storeComment(
      message: message,
      postId: postId,
    );
    if (response.status.hasError) {
      Get.snackbar('Error', response.statusText.toString());
    } else {
      Get.snackbar('Success', response.statusText.toString());
    }
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