import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/modules/post/views/widget_upload..dart';
import 'package:simantan/app/theme/colors.dart';
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
            child: Column(
              children: [
                WidgetUpload(),
                const Divider(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ReuseTextField(
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
                      MultiSelectDialogField(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                        items: ['Lebaran', '17Gustur', 'Kemahasiswaan']
                            .map((e) => MultiSelectItem(e, e))
                            .toList(),
                        listType: MultiSelectListType.CHIP,
                        onConfirm: (values) {
                          // _selectedAnimals = values;
                        },
                      ),
                      // Button Unggah
                      const Divider(),
                      Container(
                        width: Get.width,
                        height: 50,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller.storePost();
                            }
                          },
                          child: const Text(
                            "Unggah",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SchemaColor.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
