import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/services/auth_services.dart';

import '../controllers/comment_controller.dart';

class CommentView extends GetView<CommentController> {
  const CommentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black, size: 20),
        backgroundColor: Colors.white,
        title: Text(
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
              child: ListView.builder(
                itemCount: controller.commentsByPost.length,
                itemBuilder: (context, index) {
                  final comment = controller.commentsByPost[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // user image
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(comment['user']['image']),
                          ),
                        ),
                        // comment
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // user name and comment
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    comment['user']['name'],
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    dateFromNow(comment['created_at']),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade500),
                                  ),
                                ],
                              ),
                              // comment
                              Text(
                                comment['message'],
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // field comment
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // user image
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage(AuthServices.getUser['image']),
                    ),
                  ),
                  // comment
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        minLines: 1,
                        maxLines: 10,
                        controller: controller.message.value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Tambahkan Komentar",
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        controller.storeComment(
                          postId: Get.parameters['postId'],
                        );
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            ),
          ],
        ),
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
