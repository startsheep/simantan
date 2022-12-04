import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/modules/profile/widgets/user_posts.dart';
import 'package:simantan/app/routes/app_pages.dart';
import 'package:simantan/app/services/auth_services.dart';
import 'package:simantan/app/theme/colors.dart';
import 'package:simantan/app/widgets/button_primary.dart';
import 'package:simantan/app/widgets/count_widget.dart';
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
              _showBottomSheet();
            },
          ),
        ],
        //
      ),
      // make like profile instagram
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: CircleAvatar(
                radius: 45,
                backgroundColor: const Color.fromARGB(255, 111, 255, 116),
                child: CircleAvatar(
                  radius: 43,
                  // foregroundColor: SchemaColor.primary,
                  backgroundImage: AssetImage('assets/avatar_l.jpg'),
                  foregroundImage:
                      NetworkImage(AuthServices.getUser['image'].toString()),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AuthServices.getUser['name'],
                  style: const TextStyle(
                    fontSize: 20,
                    color: SchemaColor.dFontColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  AuthServices.getUser['nip'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Obx(() {
              return Container(
                width: Get.width / 2,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      // flex: 5,
                      child: CountWidget(
                        count: controller.countPost.value,
                        title: "Postingan",
                      ),
                    ),
                    Expanded(
                      // flex: 5,
                      child: CountWidget(
                        count: controller.countLike.value,
                        title: "Suka",
                      ),
                    ),
                  ],
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ButtonPrimary(
                label: "Edit Profil",
                onPressed: () {
                  Get.toNamed(Routes.PROFILE_UPDATE);
                },
              ),
            ),
            Expanded(child: const UserPostsWidget())
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showBottomSheet() {
    return Get.bottomSheet(
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
                _confirmLogout();
              },
            ),
            // change password
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Ganti Password'),
              onTap: () {
                Get.back();
                Get.toNamed(Routes.RESET_PASSWORD);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _confirmLogout() {
    return Get.defaultDialog(
      title: 'Keluar',
      middleText: 'Apakah anda yakin ingin keluar?',
      textConfirm: 'Ya',
      textCancel: 'Tidak',
      confirmTextColor: Colors.white,
      cancelTextColor: const Color.fromARGB(255, 23, 22, 22),
      buttonColor: SchemaColor.primary,
      onConfirm: () {
        Get.back();
        controller.authController.logout();
      },
    );
  }
}
