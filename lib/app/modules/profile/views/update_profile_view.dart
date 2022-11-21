import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/modules/profile/controllers/profile_controller.dart';
import 'package:simantan/app/theme/colors.dart';
import 'package:simantan/app/widgets/button_primary.dart';
import 'package:simantan/app/widgets/reuse_textfield.dart';

class UpdateProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: SchemaColor.primary,
        title: const Text(
          'Edit Profil',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () {
              // Get.back();
              controller.updateUser();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog();
                      },
                      child: CircleAvatar(
                        radius: 50,
                        // foregroundImage: AssetImage('assets/avatar_l.jpg'),
                        foregroundImage: controller.image.value == null
                            ? Image.network(controller.avatarUrl.value).image
                            : Image.file(File(controller.image.value.path))
                                .image,
                        backgroundImage: AssetImage('assets/avatar_l.jpg'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Ubah Foto Profil',
                      style: TextStyle(
                        color: SchemaColor.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() {
                  return ReuseTextField(
                    controller: controller.nameController.value,
                    labelText: 'Nama',
                    hintText: 'Masukkan Nama',
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                Obx(() {
                  return ReuseTextField(
                    controller: controller.nipController.value,
                    labelText: 'Nip',
                    hintText: 'Masukkan nip',
                  );
                })
              ],
            );
          }),
        ),
      ),
    );
  }

  void showDialog() {
    // show dialog for select get image from galery or get image from camera
    Get.bottomSheet(
      Container(
        height: 200,
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonIcon(
              iconData: Icons.camera_alt,
              label: 'Ambil Foto',
              onTap: () {
                controller.getImageFromCamera();
                // close the bottom sheet
                Get.back();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonIcon(
              iconData: Icons.photo,
              label: 'Pilih Foto',
              onTap: () {
                controller.getImageFromGallery();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonIcon extends StatelessWidget {
  VoidCallback? onTap;
  String? label;
  IconData? iconData;
  ButtonIcon({
    Key? key,
    this.onTap,
    this.label,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // icon and text
            Icon(
              iconData!,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              label ?? 'laebl',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: SchemaColor.primary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
