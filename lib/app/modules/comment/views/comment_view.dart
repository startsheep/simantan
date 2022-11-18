import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/modules/comment/widgets/comment_widget.dart';
import 'package:simantan/app/services/auth_services.dart';
import 'package:simantan/app/theme/colors.dart';

import '../controllers/comment_controller.dart';

class CommentView extends GetView<CommentController> {
  const CommentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // controller.onInit();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black, size: 20),
        backgroundColor: Colors.white,
        title: const Text(
          "Komentar",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 15, 25, 34)),
        ),
      ),
      body: SafeArea(
        child: Column(
          // make comment like instagram
          children: [
            // list comments
            Expanded(
              child: Obx(() {
                // return make condition like instagram
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.commentsByPost.isEmpty) {
                  return const Center(
                    child: Text("Belum ada komentar"),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () => controller.getCommentsByPost(),
                    semanticsLabel: controller.commentsByPost.length.toString(),
                    semanticsValue: controller.commentsByPost.length.toString(),
                    child: ListView.builder(
                      reverse: false,
                      itemCount: controller.commentsByPost.length,
                      itemBuilder: (context, index) {
                        final comment = controller.commentsByPost[index];
                        return CommentWidget(
                          comment: comment,
                        );
                      },
                    ),
                  );
                }
              }),
            ),

            Container(
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
                      backgroundImage:
                          NetworkImage(AuthServices.getUser['image']),
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
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  SchemaColor.primary),
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
            ),
          ],
        ),
      ),
    );
  }

  bool canDeletePost(String userId) {
    return AuthServices.getUser['id'] == userId;
  }

  bool isMyComment(String userId) {
    return AuthServices.getUser['id'] == userId;
  }

  bool isMyPost(String userId) {
    return AuthServices.getUser['id'] == userId;
  }
}
