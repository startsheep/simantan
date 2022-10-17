import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/modules/home/controllers/post_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  // post controller
  // final PostController postController = Get.lazyPut<PostController>(()=obs>PostController());
  @override
  Widget build(BuildContext context) {
    final postController = Get.put(PostController());
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => postController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: postController.posts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              postController.posts[index]['avatar']),
                        ),
                        title: Text(postController.posts[index]['name']),
                        subtitle: Text(postController.posts[index]['avatar']),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
