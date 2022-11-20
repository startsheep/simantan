import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/modules/comment/controllers/comment_controller.dart';
import 'package:simantan/app/theme/colors.dart';

class CommentActions extends GetView<CommentController> {
  // bool? canUpdate = false;
  CommentActions({
    Key? key,
    // this.canUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: SchemaColor.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon Delet and edit
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              controller.showToolbar.value =
                  !controller.showToolbar.value; // close toolbar
            },
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {
                  controller.deleteComment(
                      controller.selectedCommentId); // delete comment
                },
              ),
              // icon update
            ],
          ),
        ],
      ),
    );
  }
}
