import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:simantan/app/modules/home/widgets/post_actions.dart';
import 'package:simantan/app/modules/home/widgets/post_description.dart';
import 'package:simantan/app/modules/profile/controllers/profile_controller.dart';
import 'package:simantan/app/modules/profile/controllers/user_post_controller.dart';
import 'package:simantan/app/theme/colors.dart';
import 'package:simantan/app/widgets/button_primary.dart';
import 'package:simantan/app/widgets/reuse_textfield.dart';

class UserPostsWidget extends GetView<UserPostController> {
  const UserPostsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading == true
          ? Center(child: CircularProgressIndicator())
          : controller.myPosts.length > 0
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
                      itemCount: controller.myPosts.length,
                      itemBuilder: (context, index) {
                        final post = controller.myPosts[index];
                        return InkWell(
                          onTap: () {
                            // make dialog like instagram
                            controller.descriptionController.value.text =
                                post['description'];
                            showDetail(post);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(post['image']),
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
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // confirm dialog
              confirmDelete(postId);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // make dialog edit post
              updateDialog(postId.toString(), flagId.toString());
            },
          ),
        ],
      ),
    );
  }

  void confirmDelete(int postId) {
    Get.defaultDialog(
      title: 'Hapus',
      middleText: 'Apakah anda yakin ingin menghapus?',
      textConfirm: 'Ya',
      textCancel: 'Tidak',
      confirmTextColor: Colors.white,
      cancelTextColor: Color.fromARGB(255, 23, 22, 22),
      buttonColor: SchemaColor.primary,
      onConfirm: () {
        controller.deletePost(postId);
      },
    );
  }

  void updateDialog(String idPost, String flagId) {
    Get.defaultDialog(
      title: 'Edit Postingan',
      content: Container(
        // height: 200,
        child: Column(
          children: [
            ReuseTextField(
              minLines: 1,
              maxLines: 10,
              controller: controller.descriptionController.value,
            ),
            const SizedBox(height: 10),
            ButtonPrimary(
              label: 'Simpan',
              onPressed: () {
                controller.updatePost(idPost, flagId);
              },
            ),
          ],
        ),
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
