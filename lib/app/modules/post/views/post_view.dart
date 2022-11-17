import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/modules/post/views/widget_upload..dart';
import 'package:simantan/app/theme/colors.dart';
import 'package:simantan/app/widgets/button_primary.dart';
import 'package:simantan/app/widgets/reuse_dropdown_search.dart';
import 'package:simantan/app/widgets/reuse_textfield.dart';

class PostView extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      // background gradient
      // make drawwer

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
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
                    // Drop

                    // Button Unggah
                    const Divider(),
                    Obx(() {
                      return ReuseDropDownSearch(
                        title: "Tagar",
                        onChange: (val) {
                          controller.flagId.value = val["id"];
                        },
                        itemAsString: (item) {
                          return item['name'].toString();
                        },
                        items: controller.flags.value,
                        onSearch: (value) {
                          // print(value);
                          controller.searchFlagText.value = value;
                          print(controller.searchFlagText.value);
                        },
                      );
                    }),
                    // create dropdown manualy with search

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
