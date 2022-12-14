import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:simantan/app/modules/home/widgets/post_actions.dart';
import 'package:simantan/app/modules/home/widgets/post_content.dart';
import 'package:simantan/app/modules/home/widgets/post_description.dart';
import 'package:simantan/app/modules/home/widgets/post_user.dart';
import 'package:simantan/app/routes/app_pages.dart';
import 'package:simantan/app/services/auth_services.dart';
import 'package:simantan/app/theme/colors.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              Get.toNamed(Routes.SEARCH);
            },
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
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Obx(
            () => controller.postController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : LazyLoadScrollView(
                    // scrollOffset: ,
                    // scroll offset make the scrollview not scroll to the top when load more
                    // scrollOffset: 10,
                    isLoading: controller.postController.lastPage,
                    onEndOfPage: () => controller.postController.loadNextPage(),
                    child: RefreshIndicator(
                      onRefresh: () => controller.postController.refresh(),
                      child: ListView.builder(
                        key: const PageStorageKey('home'),
                        itemCount: controller.postController.posts.length,
                        itemBuilder: (context, index) {
                          final post = controller.postController.posts[index];
                          controller.commentsController
                              .add(TextEditingController());

                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 215, 215, 215)
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
                                  userId: post['user']['id'].toString(),
                                  avatarUrl: post['user']['image'],
                                  username: post['user']['name'],
                                  isActive: post['user']['is_active'] == 1
                                      ? true
                                      : false,
                                ),
                                PostContent(
                                  contentUrl: post['image'],
                                ),
                                PostActions(
                                  // key: UniqueKey(),
                                  key: ValueKey(post['id']),
                                  postId: post['id'],
                                  likeCount: post['countLike'],
                                  pathImage: post['image'],
                                  userName: post['user']['name'],
                                ),
                                PostDescription(
                                  username: post['user']['name'],
                                  description: post['description'],
                                  hastag: post['flag']['name'],
                                  time: post['created_at'],
                                  postId: post['id'].toString(),
                                  countComment: post['countComment'].toString(),
                                  countLike: post['countLike'].toString(),
                                ),

                                // PostComment(),
                                // make textfield for comments like instagram
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundImage: NetworkImage(
                                                AuthServices.getUser['image']
                                                        .toString() ??
                                                    'https://i.pravatar.cc/150?img=1'),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextField(
                                            // key:  ,
                                            controller: controller
                                                .commentsController[index],
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Berkomentar",
                                            ),
                                            minLines: 1,
                                            maxLines: 10,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            controller.storeComment(index,
                                                message: controller
                                                    .commentsController[index]
                                                    .text,
                                                postId: controller
                                                    .postController
                                                    .posts[index]['id']
                                                    .toString());
                                          },
                                          icon: const Icon(
                                            Icons.send_rounded,
                                            color: SchemaColor.primary,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
