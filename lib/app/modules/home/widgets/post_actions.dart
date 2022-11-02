import 'package:flutter/material.dart';

class PostActions extends StatelessWidget {
  const PostActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
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
}
