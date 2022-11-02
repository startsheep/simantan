import 'package:flutter/material.dart';

class PostContent extends StatelessWidget {
  String? contentUrl;
  PostContent({
    Key? key,
    this.contentUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 215, 215, 215).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 2,
            blurStyle: BlurStyle.inner,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Image.network(contentUrl!),
    );
  }
}
