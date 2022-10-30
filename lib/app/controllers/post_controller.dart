import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simantan/app/controllers/image_picker_controller.dart';
import 'package:simantan/app/modules/home/providers/post_provider.dart';

class PostController extends GetxController {
  //TODO: Implement PostControllerController
  RxList posts = [].obs;
  RxBool isLoading = true.obs;
  RxBool isLoadMore = false.obs;
  RxBool isExpanded = false.obs;
  Rx<XFile> image = XFile('').obs;
  late ImagePickerController pickerController;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<PostProvider>(() => PostProvider());
    Get.lazyPut<ImagePickerController>(() => ImagePickerController());
    pickerController = Get.find<ImagePickerController>();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  setImageFromGallery() async {
    image.value = await pickerController.getImageFromGallery()!;
  }

  void fetchPosts() async {
    final response = await Get.find<PostProvider>().getPosts();
    final _posts = json.encode(response.body['data']);
    posts.value = json.decode(_posts);
    print(_posts);
    if (response.statusCode == 200) {
      // final data = json.encode(response.body);
      // posts.value = json.decode(data);
      isLoading.value = false;
    }
  }

  void storePost() async {
    final response = await Get.find<PostProvider>().storePost(
      description: "title title",
      hashtag: "hastag",
      file: File(image.value.path),
    );

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      fetchPosts();
      isLoading.value = false;
    }
  }
}
