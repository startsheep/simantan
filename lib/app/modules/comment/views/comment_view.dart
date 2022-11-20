import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/modules/comment/widgets/comment_actions.dart';
import 'package:simantan/app/modules/comment/widgets/comment_field.dart';
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
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          // hide toolbar when slide left is
          onHorizontalDragStart: (details) {
            print(details.globalPosition);
            if (details.globalPosition.dx < 50) {
              // FocusScope.of(context).unfocus();
              if (controller.showToolbar.value == true) {
                controller.showToolbar.value = !controller.showToolbar.value;
              } else {
                Get.back();
              }
            }
          },
//
          child: Column(
            // make comment like instagram
            children: [
              Expanded(
                child: Obx(() {
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
                      semanticsLabel:
                          controller.commentsByPost.length.toString(),
                      semanticsValue:
                          controller.commentsByPost.length.toString(),
                      child: ListView.builder(
                        itemCount: controller.commentsByPost.length,
                        itemBuilder: (context, index) {
                          final comment = controller.commentsByPost[index];

                          return InkWell(
                            onLongPress: () {
                              final _isMyComment = comment['user']['id'];
                              final _isMyPost =
                                  int.parse(comment['post']['user_id']);
                              if (canDeletePost(_isMyComment, _isMyPost)) {
                                controller.showToolbar.value =
                                    !controller.showToolbar.value;
                                controller.selectedCommentId =
                                    comment['id'].toString();
                              }
                            },
                            child: Column(
                              children: [
                                //bmake background when selected
                                Obx(() {
                                  if (controller.showToolbar.value == true &&
                                      controller.selectedCommentId ==
                                          comment['id'].toString()) {
                                    return Container(
                                      color: Colors.grey.shade200,
                                      child: CommentWidget(
                                        comment: comment,
                                      ),
                                    );
                                  } else {
                                    return CommentWidget(
                                      comment: comment,
                                    );
                                  }
                                }),
                                // make comment action show by per comment id
                                Obx(() {
                                  if (controller.showToolbar.value &&
                                      controller.selectedCommentId ==
                                          comment['id'].toString()) {
                                    return CommentActions();
                                  } else {
                                    return const SizedBox();
                                  }
                                }),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
              ),
              const CommentField(),
            ],
          ),
        ),
      ),
    );
  }

  bool canDeletePost(int userId, userPost) {
    return isMyComment(userId) || isMyPost(userPost);
  }

  bool isMyComment(int userId) {
    return AuthServices.getUser['id'] == userId;
  }

  bool isMyPost(int userId) {
    return AuthServices.getUser['id'] == userId;
  }
}
