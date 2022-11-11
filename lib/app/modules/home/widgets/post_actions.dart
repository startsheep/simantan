import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/controllers/post_controller.dart';

class PostActions extends StatelessWidget {
  int? postId;
  PostActions({
    this.postId,
    Key? key,
  }) : super(key: key);
  final controller = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: isLiked(postId),
              onPressed: () {
                controller.likePost(postId!);
              },
            ),
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

  Widget isLiked(id) {
    return FutureBuilder(
      future: controller.isLiked(id),
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
