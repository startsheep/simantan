import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/theme/colors.dart';
import 'package:simantan/app/widgets/outline_button.dart';

class WidgetUpload extends GetView<PostController> {
  const WidgetUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Container(
            width: Get.width,
            height: Get.height / 3,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              image: controller.image.value.path.isNotEmpty
                  ? DecorationImage(
                      image:
                          Image.file(File(controller.image.value.path)).image,
                      fit: BoxFit.cover,
                    )
                  : null,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: const Color.fromARGB(255, 137, 126, 255),
                  style: BorderStyle.solid,
                  strokeAlign: StrokeAlign.outside),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(159, 202, 202, 202),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(1, 4),
                )
              ],
            ),
            child: controller.image.value.path.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 100,
                        onPressed: () async {
                          // print("Output" ;
                          await controller.pickerController
                              .getImageFromGallery()
                              .then((value) {
                            controller.image.value = value;
                          });
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          color: SchemaColor.primary,
                        ),
                      ),
                      const Text(
                        "Ayo unggah foto kegiatan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: SchemaColor.primary,
                        ),
                      ),
                      Text(
                        controller.image.value.path.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: SchemaColor.primary,
                        ),
                      )
                    ],
                  )
                : Container(),
          ),
          const Divider(),
          Row(
            children: [
              // make tow buttofor change image
              Expanded(
                child: OutlineButton(
                  label: "Galeri",
                  onPressed: () {
                    controller.pickerController.getImageFromGallery().then(
                          (value) => controller.image.value = value,
                        );
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: OutlineButton(
                  label: "Kamera",
                  onPressed: () {
                    controller.pickerController.getImageFromCamera().then(
                          (value) => controller.image.value = value,
                        );
                  },
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
