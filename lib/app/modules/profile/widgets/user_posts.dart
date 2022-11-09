import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:simantan/app/modules/home/widgets/post_description.dart';
import 'package:simantan/app/modules/profile/controllers/profile_controller.dart';
import 'package:simantan/app/theme/colors.dart';

class UserPostsWidget extends GetView<ProfileController> {
  const UserPostsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        // make grid view like instagram
        () => LazyLoadScrollView(
          isLoading: controller.postController.lastPage,
          onEndOfPage: () => controller.postController.loadNextPage(),
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: controller.postController.myPosts.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // make dialog like instagram
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
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      Get.defaultDialog(
                                        title: 'Hapus',
                                        middleText:
                                            'Apakah anda yakin ingin menghapus?',
                                        textConfirm: 'Ya',
                                        textCancel: 'Tidak',
                                        confirmTextColor: Colors.white,
                                        cancelTextColor:
                                            Color.fromARGB(255, 23, 22, 22),
                                        buttonColor: SchemaColor.primary,
                                        onConfirm: () {
                                          Get.back();
                                        },
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      // make dialog edit post
                                      Get.defaultDialog(
                                        title: 'Edit Post',
                                        content: Container(
                                          height: 200,
                                          child: Column(
                                            children: [
                                              TextField(
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Caption Post',
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      SchemaColor.primary,
                                                ),
                                                onPressed: () {},
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  width: Get.width,
                                                  child: const Text(
                                                    'Update',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              // padding: EdgeInsets.all(10),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Image.network(
                                controller.postController.myPosts[index]
                                    ['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                                child: PostDescription(
                              username: controller.postController.myPosts[index]
                                  ['user']['name'],
                              description: controller
                                  .postController.myPosts[index]['description'],
                              hastag: controller.postController.myPosts[index]
                                  ['flag']['name'],
                              time: controller.postController.myPosts[index]
                                  ['created_at'],
                            )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(
                          controller.postController.myPosts[index]['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
