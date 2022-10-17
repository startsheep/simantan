import 'dart:convert';

import 'package:get/get.dart';
import 'package:simantan/app/modules/home/providers/post_provider.dart';

class PostController extends GetxController {
  //TODO: Implement PostControllerController
  RxList posts = [].obs;
  RxBool isLoading = true.obs;
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
  // fetch post from postPrivider
  void fetchPosts() async {
    print('fetch post');
    final postsFromAPi = await Get.find<PostProvider>().getPosts();
    // print(post.statusCode);
    if (postsFromAPi.statusCode == 200) {
      final jsonResponse = json.encode(postsFromAPi.body);
      posts.value = json.decode(jsonResponse);
      // print(posts);

      // posts.assignAll(postsFromA);

      isLoading.value = false;
    }
  }
}
