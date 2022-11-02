import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/modules/home/widgets/post_actions.dart';
import 'package:simantan/app/modules/home/widgets/post_content.dart';
import 'package:simantan/app/modules/home/widgets/post_description.dart';
import 'package:simantan/app/modules/home/widgets/post_user.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // make like instagram
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: const [
            Image(image: AssetImage('assets/logo-brand.png'), width: 50),
            SizedBox(width: 10),
            // dropdown
            Text(
              "SIMANTAN",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 15, 25, 34)),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => controller.postController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: controller.postController.posts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 215, 215, 215)
                                .withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 2,
                            blurStyle: BlurStyle.inner,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      // height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PostUser(
                            avatarUrl: controller.postController.posts[index]
                                ['user']['image'],
                            username: controller.postController.posts[index]
                                ['user']['name'],
                            isActive: controller.postController.posts[index]
                                        ['user']['is_active'] ==
                                    1
                                ? true
                                : false,
                          ),
                          PostContent(
                            contentUrl: controller.postController.posts[index]
                                ['image'],
                          ),
                          PostActions(),
                          PostDescription(
                            username: controller.postController.posts[index]
                                ['user']['name'],
                            description: controller.postController.posts[index]
                                ['description'],
                            hastag: controller.postController.posts[index]
                                ['flag']['name'],
                            time: controller.formatDateTime(
                              controller.postController.posts[index]
                                  ['created_at'],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
