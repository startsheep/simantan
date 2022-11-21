import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/modules/home/providers/post_provider.dart';
import 'package:simantan/app/providers/user_provider.dart';

import '../../../models/lazy_loading_filter.dart';

class SearchController extends GetxController {
  //TODO: Implement SearchController
  RxBool isLoading = false.obs;
  final selectedFlag = null.obs;
  final selectedCategory = null.obs;
  final RxInt selectedChip = 0.obs;
  final RxString selectedFlagId = ''.obs;
  final RxInt selectedChipCategory = 0.obs;
  final RxList flags = [].obs;
  final RxList _posts = [].obs;
  final RxList _users = [].obs;
  final RxList tabs = [
    {'name': 'Tagar', 'value': 0},
    {'name': 'Postingan', 'value': 1},
    {'name': 'Pengguna', 'value': 2},
  ].obs;
  final RxInt selectedTab = 0.obs;
  final Rx<TextEditingController> searchController =
      TextEditingController().obs;
  RxString searchText = ' '.obs;
  final _lastPage = false.obs;
  int get _limit => paginationFilter.value.limit!;
  int get _page => paginationFilter.value.page!;
  bool get lastPage => _lastPage.value;
  List get posts => _posts.toList();
  List get users => _users.toList();
  final paginationFilter = LazyLoadingFilter().obs;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<PostProvider>(() => PostProvider());
    Get.find<PostProvider>().onInit();
    Get.lazyPut<UserProvider>(() => UserProvider());
    Get.find<UserProvider>().onInit();
    fetchFlags();
  }

  void fetchFlags() async {
    isLoading.value = true;
    final response = await Get.find<PostProvider>()
        .getFlags(search: searchController.value.text);
    if (response.statusCode == 200) {
      isLoading.value = false;
      flags.assignAll(response.body['data']);
    }
  }

  void fetchPosts() async {
    isLoading.value = true;
    print("fetchPosts");
    // refresh();
    update();
    final response = await Get.find<PostProvider>().getPosts(
      paginationFilter.value,
      search: searchText.value,
      flagId: selectedFlagId.value,
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      isLoading.value = false;
      if (response.body['data'].length == 0) {
        _lastPage.value = true;
      } else {
        _lastPage.value = false;
        _posts.assignAll(response.body['data']);
      }
    }
  }

  void fetchUsers() async {
    isLoading.value = true;
    print("fetchUsers");
    // refresh();
    update();
    final response = await Get.find<UserProvider>().getUsers(
      paginationFilter.value,
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      isLoading.value = false;
      if (response.body['data'].length == 0) {
        _lastPage.value = true;
      } else {
        _lastPage.value = false;
        _users.addAll(response.body['data']);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    fetchUsers();
    ever(selectedFlagId, ((callback) => fetchPosts()));
    debounce(searchText, (_) => fetchFlags(),
        time: Duration(milliseconds: 500));
    debounce(searchText, (_) => fetchPosts(),
        time: Duration(milliseconds: 500));
    if (_posts.length > 0) {
      ever(paginationFilter, (_) => fetchPosts());
    }
    if (_users.length > 0) {
      ever(paginationFilter, (_) => fetchUsers());
    }
    changePaginationFilter(1, 10);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changePaginationFilter(int page, int limit) {
    paginationFilter.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }

  void changeTotalPerPage(int limitVal) {
    _posts.clear();
    _lastPage.value = false;
    changePaginationFilter(1, limitVal);
  }

  void loadNextPage() => changePaginationFilter(_page + 1, _limit);
}
