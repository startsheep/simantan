import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simantan/app/models/lazy_loading_filter.dart';
import 'package:simantan/app/modules/home/providers/post_provider.dart';
import 'package:simantan/app/services/auth_services.dart';

class UserPostController extends GetxController {
  //TODO: Implement UserPostController

  final _lastPage = false.obs;
  final RxList _myPosts = [].obs;
  int get _limit => paginationFilter.value.limit!;
  int get _page => paginationFilter.value.page!;
  bool get lastPage => _lastPage.value;
  List get myPosts => _myPosts.toList();
  Rx<TextEditingController> descriptionController = TextEditingController().obs;
  RxBool isLoading = true.obs;
  final paginationFilter = LazyLoadingFilter().obs;

  @override
  void onInit() {
    Get.lazyPut<PostProvider>(() => PostProvider());
    super.onInit();
    ever(paginationFilter, (_) => getMyPosts());
    changePaginationFilter(1, 15);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getMyPosts() async {
    print('getMyPosts');
    // isLoading.value = true;
    final response = await Get.find<PostProvider>().getPostsByUser(
        paginationFilter.value, AuthServices.getUserId.toString());
    if (response.statusCode == 200) {
      isLoading.value = false;
      if (response.body['data'].length == 0) {
        _lastPage.value = true;
      } else {
        _lastPage.value = false;
        _myPosts.addAll(response.body['data']);
      }
    }
  }

  void deletePost(int id) async {
    isLoading.value = true;
    final response = await Get.find<PostProvider>().deletePost(id);
    if (response.statusCode == 200) {
      Get.back();
      isLoading.value = false;
      Get.back();
      Get.delete<UserPostController>();
      Get.lazyPut<UserPostController>(() => UserPostController());
      getMyPosts();
      // refresh();
    }
  }

  void updatePost(String? id, flagId) async {
    isLoading.value = true;
    final response = await Get.find<PostProvider>().updatePost(id!,
        description: descriptionController.value.text, flagId: flagId);
    print(response.body);
    if (response.statusCode == 200) {
      Get.back();
      isLoading.value = false;
      Get.back();
      Get.delete<UserPostController>();
      Get.lazyPut<UserPostController>(() => UserPostController());
      getMyPosts();
      // refresh();
    }
  }

  Future<void> refreshPage() async {
    isLoading.value = true;
    _myPosts.clear();
    // getMyPosts();
    changePaginationFilter(1, 15);
  }

  void changePaginationFilter(int page, int limit) {
    paginationFilter.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }

  void changeTotalPerPage(int limitVal) {
    _myPosts.clear();
    _lastPage.value = false;
    changePaginationFilter(1, limitVal);
  }

  void loadNextPage() => changePaginationFilter(_page + 1, _limit);
}
