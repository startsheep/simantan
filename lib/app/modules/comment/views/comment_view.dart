import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:simantan/app/controllers/comment_controller.dart';

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
                    initState: (state) {
                      controller.getComments();
                    },
                    autoRemove: true,
                    init: controller,
                    builder: (CommentController controller) {
                      return Obx(() {
                        return LazyLoadScrollView(
                          onEndOfPage: () => controller.loadNextPage(),
                          isLoading: controller.lastPage,
                          child: ListView.builder(
                            itemCount: controller.comments.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(controller
                                      .comments[index]['user']['image']),
                                ),
                                title: Text(
                                    controller.comments[index]['user']['name']),
                                subtitle:
                                    Text(controller.comments[index]['message']),
                              );
                            },
                          ),
                        );
                      });
                    }),
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
                            postId: Get.parameters['postId'],
                          );
                        },
                        icon: Icon(Icons.send)),
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
