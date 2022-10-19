import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/widgets/reuse_textfield.dart';

class PostView extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height / 3,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 100,
                        onPressed: () async {
                          await ImagesPicker.pick(
                            count: 3,
                            pickType: PickType.image,
                          );
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          color: Color.fromARGB(255, 137, 126, 255),
                        ),
                      ),
                      Text(
                        "Ayo unggah foto kegiatan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 137, 126, 255),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Color.fromARGB(255, 137, 126, 255),
                        style: BorderStyle.solid,
                        strokeAlign: StrokeAlign.outside),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(160, 116, 115, 115),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(1, 4),
                      )
                    ],
                  ),
                ),
                Divider(),
                ReuseTextField(
                    hintText: "Judul",
                    icon: Icons.title,
                    minLines: 1,
                    maxLines: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
