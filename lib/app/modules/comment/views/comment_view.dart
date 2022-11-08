import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:simantan/app/modules/comment/controllers/comment_controller.dart';
import 'package:simantan/app/theme/colors.dart';

class CommentView extends GetView<CommentController> {
  @override
  Widget build(BuildContext context) {
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
        // with dummy data for now like instagram
        child: Obx(() {
          return Column(
            children: [
              const Divider(),
              Expanded(
                child: GetBuilder(
                  init: controller,
                  builder: (controller) {
                    return LazyLoadScrollView(
                      // isLoading: controller.lastPage,
                      onEndOfPage: () => controller.loadNextPage(),
                      child: ListView.builder(
                        itemCount: controller.commentsByPost.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(controller
                                      .comments[index]['user']['image']),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/avatar.png'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        minLines: 1,
                        maxLines: 15,
                        controller: controller.message.value,
                        decoration: const InputDecoration(
                          hintText: "Tambahkan komentar...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                        onPressed: () {
                          controller.storeComment(
                            message: controller.message.value.text,
                            postId: Get.parameters['post_id'],
                          );
                        },
                        icon: const Icon(
                          Icons.send,
                          color: SchemaColor.primary,
                        )),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
