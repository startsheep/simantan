import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simantan/app/controllers/image_picker_controller.dart';
import 'package:simantan/app/modules/home/providers/post_provider.dart';

class PostController extends GetxController {
  //TODO: Implement PostControllerController
  RxList posts = [].obs;
  RxList flags = [].obs;
  RxBool isLoading = true.obs;
  RxBool isUploading = false.obs;
  RxBool isLoadMore = false.obs;
  RxBool isExpanded = false.obs;
  RxInt flagId = 0.obs;
  Rx<XFile> image = XFile('').obs;
  final Rx<TextEditingController> descriptionController =
      TextEditingController().obs;
  final Rx<TextEditingController> searchFlag = TextEditingController().obs;
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

  Future<List> fetchFlags(String search) async {
    final response =
        await Get.find<PostProvider>().getFlags(searchFlag.value.text);
    if (response.statusCode == 200) {
      flags.assignAll(response.body['data']);
    }
    return flags;
  }

  void fetchPosts() async {
    final response = await Get.find<PostProvider>().getPosts();
    final _posts = json.encode(response.body['data']);
    posts.value = json.decode(_posts);

    if (response.statusCode == 200) {
      isLoading.value = false;
    }
  }

  void storePost() async {
    isUploading.value = true;
    ;
    final response = await Get.find<PostProvider>().storePost(
      description: descriptionController.value.text,
      hashtagId: flagId.value,
      file: File(image.value.path),
    );
    print(response.body);
    if (response.statusCode == 201) {
      isUploading.value = false;
      fetchPosts();
    }
  }

  void storeFlag() async {
    print("store flag");
    final response =
        await Get.find<PostProvider>().storeFlag(searchFlag.value.text);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      fetchFlags(searchFlag.value.text);
    }
  }

  void downloadImage(String path) async {
    final response = await Get.find<PostProvider>().downloadImage(path);
    print(response.statusCode);
    print(response.body);
  }

  String randomStringWord() {
    var random = Random();
    //make random word
    var word = List.generate(random.nextInt(10) + 5, (index) {
      return String.fromCharCode(random.nextInt(26) + 97);
    });
    return word.join();
  }
}
