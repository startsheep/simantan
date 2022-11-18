import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:simantan/app/theme/colors.dart';

class CommentWidget extends StatelessWidget {
  final dynamic comment;
  CommentWidget({super.key, this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // user image
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(comment['user']['image']),
            ),
          ),
          // comment
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // user name and comment
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      comment['user']['name'],
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dateFromNow(comment['created_at']),
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    ),
                  ],
                ),
                // comment
                ExpandableText(
                  comment['message'],
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
              ],
            ),
          ),
        ],
      ),
    );
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
