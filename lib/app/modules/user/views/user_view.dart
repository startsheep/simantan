import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

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
                                onRefresh: () => controller.getUserPosts(),
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
                                    return InkWell(
                                      onTap: () {
                                        // make dialog like instagram
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
}
