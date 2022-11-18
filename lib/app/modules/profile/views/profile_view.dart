import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/modules/profile/widgets/user_posts.dart';
import 'package:simantan/app/services/auth_services.dart';
import 'package:simantan/app/theme/colors.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
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
                            cancelTextColor:
                                const Color.fromARGB(255, 23, 22, 22),
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
                      backgroundColor: const Color.fromARGB(255, 111, 255, 116),
                      child: CircleAvatar(
                        radius: 43,
                        foregroundColor: SchemaColor.primary,
                        backgroundImage: NetworkImage(
                            AuthServices.getUser['image'] ??
                                ' https://placeimg.com/640/480/people'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AuthServices.getUser['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        AuthServices.getUser['nip'],
                        style: const TextStyle(
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
                  padding: const EdgeInsets.all(10),
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
            Obx(() {
              if (controller.postController.isLoading.value) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (controller.postController.myPosts.isEmpty) {
                return const Expanded(
                  child: Center(
                    child: Text('Belum ada postingan nih'),
                  ),
                );
              } else {
                return const UserPostsWidget();
              }
            })
          ],
        ),
      ),
    );
  }
}
