import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:simantan/app/modules/comment/controllers/comment_controller.dart';
import 'package:simantan/app/routes/app_pages.dart';
import 'package:simantan/app/theme/colors.dart';

class PostDescription extends StatelessWidget {
  String? username;
  String? description;
  String? hastag;
  String? time;
  String? postId;
  String? countComment;
  String? countLike;
  PostDescription({
    Key? key,
    this.username,
    this.description,
    this.hastag,
    this.postId,
    this.countComment,
    this.countLike,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: username,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [],
            ),
          ),
          const SizedBox(height: 5),
          // ,ake description collapse when many text
          ExpandableText(
            description!,
            expandText: "Selengkapnya",
            collapseText: "Sembunyikan",
            linkStyle: TextStyle(
              color: SchemaColor.primary.withOpacity(0.5),
              fontWeight: FontWeight.bold,
            ),
            animation: true,
            animationDuration: const Duration(milliseconds: 500),
            maxLines: 2,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            // expanded: true,
          ),
          // make hastag clickable
          const SizedBox(height: 5),
          // see comment like instagram comment with gesture detector
          InkWell(
            onTap: () {
              Get.toNamed(Routes.COMMENT, parameters: {'postId': postId!});
            },
            child: Text(
              "Lihat $countComment komentar",
              style: const TextStyle(
                color: Color.fromARGB(255, 102, 102, 102),
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(height: 5),
          // see comment like instagram.com
          Row(
            children: [
              Text(
                parseToHashTag(hastag!),
                style: const TextStyle(
                    color: SchemaColor.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 5),
              Text(
                dateFromNow(time!),
                style: const TextStyle(
                    color: Color.fromARGB(255, 86, 86, 86),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String parseToHashTag(String text) {
    return "#" + text.replaceAll(" ", "");
  }

  String dateFromNow(String date) {
    final now = DateTime.now();
    final commentDate = DateTime.parse(date);
    final difference = now.difference(commentDate);

    if (difference.inDays > 0) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit yang lalu';
    } else {
      return 'Baru saja';
    }
  }
}
