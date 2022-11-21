import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/modules/post/controllers/like_controller.dart';
import 'package:simantan/app/theme/colors.dart';

class PostActions extends GetView<LikeController> {
  int? postId;
  int? likeCount;
  PostActions({
    this.postId,
    this.likeCount,
    Key? key,
  }) : super(key: key);
  // final controller = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    // var value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GetBuilder(
                init: LikeController(),
                initState: (state) {
                  controller.getCountLike(postId!);
                  controller.checkLike(postId!);
                },
                builder: (LikeController controller) {
                  return LikeButton(
                    size: 20,
                    circleColor: CircleColor(
                        start: Colors.redAccent, end: Colors.redAccent),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Colors.redAccent,
                      dotSecondaryColor: Colors.redAccent,
                    ),
                    isLiked: controller.isLiked.value,
                    likeBuilder: (bool isLiked) {
                      // isLiked = controller.isLiked.value;
                      return Obx(() {
                        return Icon(
                          Icons.favorite,
                          color: controller.isLiked.value
                              ? Colors.redAccent
                              : Colors.grey,
                          size: 20,
                        );
                      });
                    },
                    likeCount: controller.countLike.value == ''
                        ? 0
                        : int.parse(controller.countLike.value),
                    countBuilder: (int? count, bool isLiked, String text) {
                      var color = isLiked ? Colors.redAccent : Colors.grey;
                      return Obx(() {
                        return Text(
                          controller.countLike.value == ''
                              ? '0'
                              : controller.countLike.value,
                          style: TextStyle(color: color),
                        );
                      });
                    },
                    onTap: (bool isLiked) async {
                      Future.delayed(const Duration(milliseconds: 100), () {
                        controller.likePost(postId!);
                        // controller.getCountLike(postId!);
                        // controller.checkLike(postId!);
                      });
                      return !isLiked;
                    },
                  );
                }),
            IconButton(
              icon: const Icon(Icons.comment_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.download_outlined),
              onPressed: () {},
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.bookmark_border),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _isLiked(id) {
    return FutureBuilder(
      future: controller.checkLike(id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Icon(snapshot.data! ? Icons.favorite : Icons.favorite_border,
              color: snapshot.data! ? Colors.red : Colors.black);
        } else {
          return const Icon(Icons.favorite_border);
        }
      },
    );
  }
}
