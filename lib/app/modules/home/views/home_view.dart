import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final postController = Get.put(PostController());
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
          () => postController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: postController.posts.length,
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
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 224, 224, 224)
                                        .withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 2,
                                    blurStyle: BlurStyle.inner,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: postController.posts[index]
                                            ['userActive'] ==
                                        true
                                    ? Colors.green
                                    : Colors.grey,
                                child: CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(
                                      postController.posts[index]['avatar']),
                                ),
                              ),
                            ),
                            title: Text(
                              postController.posts[index]['username'],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              '#' + postController.posts[index]['hastag'],
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 215, 215, 215)
                                      .withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 2,
                                  blurStyle: BlurStyle.inner,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Image.network(
                                postController.posts[index]['content']),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.favorite_border),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.comment_outlined),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.download_outlined),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(Icons.bookmark_border),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          // render container with heigth fit image
                          // box description
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  postController.posts[index]['username'],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  postController.posts[index]['description'],
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '#' + postController.posts[index]['hastag'],
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 80, 94, 248),
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  controller.formatDateTime(
                                      postController.posts[index]['createdAt']),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 193, 193, 193),
                                      fontSize: 16),
                                ),
                              ],
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
