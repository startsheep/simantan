import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/modules/home/widgets/post_description.dart';
import 'package:simantan/app/services/auth_services.dart';
import 'package:simantan/app/theme/colors.dart';
import 'package:sp_util/sp_util.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {
              Get.bottomSheet(
                Container(
                  height: 200,
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Logout'),
                        onTap: () {
                          // confirm dialog
                          Get.defaultDialog(
                            title: 'Logout',
                            middleText: 'Apakah anda yakin ingin logout?',
                            textConfirm: 'Ya',
                            textCancel: 'Tidak',
                            confirmTextColor: Colors.white,
                            cancelTextColor: Color.fromARGB(255, 23, 22, 22),
                            buttonColor: SchemaColor.primary,
                            onConfirm: () {
                              Get.back();
                              controller.authController.logout();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
        //
      ),
      // make like profile instagram
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Color.fromARGB(255, 111, 255, 116),
                      child: CircleAvatar(
                        radius: 43,
                        foregroundColor: SchemaColor.primary,
                        backgroundImage:
                            NetworkImage('https://placeimg.com/640/480/people'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AuthServices.getUser['name'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        AuthServices.getUser['nip'],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // const Divider(),

            // const Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SchemaColor.primary,
                ),
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: Get.width,
                  child: const Text(
                    'Edit Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: Obx(
                // make grid view like instagram
                () => GridView.builder(
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
                            backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.zero,
                            child: Container(
                              color: Colors.transparent,
                              width: Get.width,
                              height: Get.height,
                              child: Column(
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
                                              cancelTextColor: Color.fromARGB(
                                                  255, 23, 22, 22),
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
                                                        hintText:
                                                            'Caption Post',
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            SchemaColor.primary,
                                                      ),
                                                      onPressed: () {},
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        width: Get.width,
                                                        child: const Text(
                                                          'Update',
                                                          textAlign:
                                                              TextAlign.center,
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
                                    username: controller.postController
                                        .myPosts[index]['user']['name'],
                                    description: controller.postController
                                        .myPosts[index]['description'],
                                    hastag: controller.postController
                                        .myPosts[index]['flag']['name'],
                                    time: controller.postController
                                        .myPosts[index]['created_at'],
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
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          image: DecorationImage(
                            image: NetworkImage(controller
                                .postController.myPosts[index]['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
