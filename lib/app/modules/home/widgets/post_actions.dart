import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:like_button/like_button.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/modules/post/controllers/downloader_controller.dart';
import 'package:simantan/app/modules/post/controllers/like_controller.dart';
import 'package:simantan/app/routes/app_pages.dart';
import 'package:simantan/app/theme/colors.dart';

class PostActions extends GetView<LikeController> {
  int? postId;
  int? likeCount;
  String? pathImage;
  String? userName;
  PostActions({
    this.postId,
    this.likeCount,
    this.pathImage,
    this.userName,
    Key? key,
  }) : super(key: key);
  // final controller = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<DownloaderController>(() => DownloaderController());
    // final downloadController = Get.;
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
              onPressed: () {
                Get.toNamed(Routes.COMMENT,
                    parameters: {'postId': postId.toString()!});
              },
            ),
            Obx(() {
              return Get.find<DownloaderController>().downloading.value
                  ? CircularProgressIndicator(
                      // key: valu,
                      value: Get.find<DownloaderController>().progress.value,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        SchemaColor.primary,
                      ),
                      strokeWidth: 3,
                    )
                  : IconButton(
                      icon: const Icon(Icons.download_outlined),
                      onPressed: () {
                        Get.find<DownloaderController>().doDownload(
                            pathImage, (userName! + postId.toString()));
                      },
                    );
            }),

            // Text(controller..value),
          ],
        ),
        // IconButton(
        //   icon: const Icon(Icons.bookmark_border),
        //   onPressed: () {},
        // ),
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

  void save(String url) async {
    // File file = await Get.find<DownloaderController>().downloadFIle(url);
    // bool res = await ImagesPicker.saveImageToAlbum(file, albumName: "");
    // print(res);
  }
  void showDialogLoading() {
    // get loafin dialog and value from download controller
    String progress = Get.find<DownloaderController>().progressString.value;
    bool isLoading = Get.find<DownloaderController>().downloading.value;
    // show dialog
    Get.defaultDialog(
      title: "Downloading",
      content: Column(
        children: [
          CircularProgressIndicator(),
          Text(progress),
        ],
      ),
      barrierDismissible: false,
      onWillPop: () async {
        return false;
      },
    );
  }
}
