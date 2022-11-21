import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/modules/post/views/widget_upload..dart';
import 'package:simantan/app/theme/colors.dart';
import 'package:simantan/app/widgets/button_primary.dart';

import 'package:simantan/app/widgets/reuse_textfield.dart';

class PostView extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      // background gradient
      // make drawwer

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Obx(() {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    const WidgetUpload(),
                    const Divider(),
                    ReuseTextField(
                      controller: controller.descriptionController.value,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "deskripsi tidak boleh kosong";
                        }
                        return null;
                      },
                      labelText: "Deskripsi",
                      hintText: "Deskrpsi",
                      icon: Icons.title,
                      minLines: 1,
                      maxLines: 10,
                    ),
                    const Divider(),
                    ReuseDropdown(),
                    const Divider(),
                    controller.isUploading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                SchemaColor.primary,
                              ),
                            ),
                          )
                        : ButtonPrimary(
                            label: "Unggah",
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  controller.flagId.value != null &&
                                  controller.image.value != null &&
                                  controller.image.value.path.isNotEmpty) {
                                controller.storePost();
                              }
                            },
                          ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class ReuseDropdown extends GetView<PostController> {
  const ReuseDropdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedFlag = {};
    return InkWell(
      onTap: () {
        controller.fetchFlags();
        Get.bottomSheet(
          Container(
            height: Get.height,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.close)),
                    const Text(
                      "Tagar",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.tag,
                        color: SchemaColor.primary,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ReuseTextField(
                          controller: controller.searchFlag.value,
                          hintText: "Cari Tagar",
                          onChanged: (value) {
                            controller.searchFlagText.value = value;
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            controller.storeFlag();
                          },
                          icon: const Icon(Icons.add))
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => controller.fetchFlags(),
                    child: Obx(
                      () {
                        return controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    SchemaColor.primary,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: controller.flags.value.length,
                                itemBuilder: (context, index) {
                                  final flag = controller.flags.value[index];
                                  return ListTile(
                                    title: Text(parseToHashTag(flag["name"])),
                                    onTap: () {
                                      controller.flagId.value = flag["id"];
                                      controller.flagName.value = flag["name"];
                                      Get.back();
                                    },
                                  );
                                },
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // barrierColor: Color.fromARGB(255, 255, 47, 47).withOpacity(0.5),
          enableDrag: true,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            // for seledcted item
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Obx(() {
                return Text(
                  controller.flagName.value.length > 0
                      ? parseToHashTag(controller.flagName.value)
                      : "Pilih Tagar",
                  style: TextStyle(
                      color: controller.flagName.value.length > 0
                          ? Colors.black
                          : Colors.grey),
                );
              }),
            )),
            // for icon dropdown
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  String parseToHashTag(String text) {
    return "#" + text.replaceAll(" ", "");
  }
}
