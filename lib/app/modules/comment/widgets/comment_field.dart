import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/modules/comment/controllers/comment_controller.dart';
import 'package:simantan/app/services/auth_services.dart';
import 'package:simantan/app/theme/colors.dart';

class CommentField extends GetView<CommentController> {
  const CommentField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // user image
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(AuthServices.getUser['image']),
            ),
          ),
          // comment
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                minLines: 1,
                maxLines: 10,
                controller: controller.message.value,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Tambahkan Komentar",
                ),
              ),
            ),
          ),
          Obx(
            () => controller.isSubmit.value
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      // animation with primary
                      valueColor:
                          AlwaysStoppedAnimation<Color>(SchemaColor.primary),
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      controller.storeComment(
                        postId: Get.parameters['postId'],
                      );
                    },
                    icon: const Icon(
                      Icons.send,
                      color: SchemaColor.primary,
                    )),
          )
        ],
      ),
    );
  }
}
