import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:simantan/app/modules/home/widgets/post_actions.dart';
import 'package:simantan/app/modules/home/widgets/post_description.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(Get.parameters['username']!,
            style: const TextStyle(color: Colors.black)),
        // centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // make like profile and like instagram
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 50,
                foregroundImage: NetworkImage(Get.parameters['avatarUrl']!),
                backgroundImage: const AssetImage('assets/avatar.png'),
              ),
              const SizedBox(height: 10),
              Text(
                Get.parameters['username']!,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 15, 25, 34)),
              ),
              Divider(
                // color: Colors.black,
                thickness: 1,
                indent: 10,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Obx(
                  () => controller.isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.posts.length > 0
                          ? LazyLoadScrollView(
                              // scrollDirection: Axis.horizontal,
                              // scrollOffset: ,
                              isLoading: controller.lastPage,
                              onEndOfPage: () => controller.loadNextPage(),
                              child: RefreshIndicator(
                                onRefresh: () => controller.refreshPage(),
                                child: GridView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemCount: controller.posts.length,
                                  itemBuilder: (context, index) {
                                    final post = controller.posts[index];
                                    return InkWell(
                                      onTap: () {
                                        // make dialog like instagram
                                        showDetail(post);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          image: DecorationImage(
                                            image: NetworkImage(controller
                                                .posts[index]['image']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.photo_library,
                                    color: Colors.grey,
                                    size: 100,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Belum ada postingan',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActions(int postId, flagId) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  void showDetail(dynamic post) {
    Get.dialog(
      Dialog(
        // backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Container(
          color: Colors.transparent,
          width: Get.width,
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // action for close dialog or delete post or edit
              _buildActions(post['id'], post['flag']['id']),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      // padding: EdgeInsets.all(10),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Image.network(
                        post['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: PostActions(
                            postId: post['id'],
                            likeCount: post['countLike'],
                            pathImage: post['image'],
                          ),
                        ),
                        PostDescription(
                          postId: post['id'].toString(),
                          username: post['user']['name'],
                          description: post['description'],
                          hastag: post['flag']['name'],
                          countComment: post['countComment'].toString(),
                          time: post['created_at'],
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
