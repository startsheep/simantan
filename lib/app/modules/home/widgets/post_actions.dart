import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/theme/colors.dart';

class PostActions extends StatelessWidget {
  int? postId;
  int? likeCount;
  PostActions({
    this.postId,
    this.likeCount,
    Key? key,
  }) : super(key: key);
  final controller = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    // var value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            LikeButton(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                onTap: (bool isLiked) async {
                  if (isLiked) {
                    controller.likePost(postId!);
                    // controller.unlikePost(postId!);
                  } else {
                    controller.likePost(postId!);
                  }
                  return !isLiked;
                },
                // size: 25,
                circleColor: CircleColor(
                    start: SchemaColor.primary.withOpacity(0.5),
                    end: SchemaColor.primary),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: SchemaColor.primary.withOpacity(0.5),
                  dotSecondaryColor: SchemaColor.primary,
                ),
                // isLiked: controller.isLiked.value,
                // isLiked: Future.value(controller.isLiked.value),
                likeBuilder: (bool isLiked) {
                  return FutureBuilder(
                    initialData: isLiked,
                    future: controller.isLikedPost(postId!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Icon(
                            snapshot.data!
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: snapshot.data!
                                ? SchemaColor.primary
                                : Colors.black);
                      } else {
                        return const Icon(Icons.favorite_border);
                      }
                    },
                  );
                },
                likeCount: likeCount,
                countBuilder: (int? count, bool isLiked, String text) {
                  // future builder
                  return FutureBuilder(
                    // initialData: co,
                    future: controller.countLike(postId!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.toString(),
                          style: TextStyle(color: Colors.grey),
                        );
                      } else {
                        return const Text(
                          '0',
                          style: TextStyle(color: Colors.grey),
                        );
                      }
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
      future: controller.isLikedPost(id),
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
