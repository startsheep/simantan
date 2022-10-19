import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:simantan/app/modules/home/providers/post_provider.dart';

class PostController extends GetxController {
  //TODO: Implement PostControllerController
  RxList posts = [].obs;
  RxBool isLoading = true.obs;
  RxBool isLoadMore = false.obs;
  RxBool isExpanded = false.obs;
  Rx<File> image = new File('').obs;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<PostProvider>(() => PostProvider());
    fetchPosts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void fetchPosts() async {
    final response = await Get.find<PostProvider>().getPosts();

    if (response.statusCode == 200) {
      final data = json.encode(response.body);
      posts.value = json.decode(data);
      isLoading.value = false;
    }
  }
}
