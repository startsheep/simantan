import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/modules/post/views/widget_upload..dart';
import 'package:simantan/app/widgets/button_primary.dart';
import 'package:simantan/app/widgets/reuse_dropdown_search.dart';
import 'package:simantan/app/widgets/reuse_textfield.dart';

class PostView extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Obx(() {
              return Column(
                children: [
                  const WidgetUpload(),
                  const Divider(),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                        // Drop
                        const Divider(),

                        // Button Unggah
                        const Divider(),
                        ReuseDropDownSearch(
                          title: "Tagar",
                          asyncItems: controller
                              .fetchFlags(controller.searchFlag.value.text),
                          onChange: (val) {
                            controller.flagId.value = val["id"];
                          },
                          itemAsString: (item) {
                            return item['name'].toString();
                          },
                          filterFn: (item, text) {
                            return item['name']
                                .toString()
                                .toLowerCase()
                                .contains(text.toLowerCase());
                          },
                        ),
                        // create dropdown manualy with search

                        const Divider(),
                        ButtonPrimary(
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
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
