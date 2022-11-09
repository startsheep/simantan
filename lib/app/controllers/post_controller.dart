import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simantan/app/controllers/image_picker_controller.dart';
import 'package:simantan/app/models/lazy_loading_filter.dart';
import 'package:simantan/app/modules/home/providers/post_provider.dart';

class PostController extends GetxController {
  //TODO: Implement PostControllerController
  RxList posts = [].obs;
  RxList _myPosts = [].obs;
  RxList flags = [].obs;
  RxBool isLoading = true.obs;
  RxBool isUploading = false.obs;
  RxInt flagId = 0.obs;
  Rx<XFile> image = XFile('').obs;
  final Rx<TextEditingController> descriptionController =
      TextEditingController().obs;
  final Rx<TextEditingController> searchFlag = TextEditingController().obs;
  late ImagePickerController pickerController;

  final _lastPage = false.obs;
  int get _limit => _paginationFilter.value.limit!;
  int get _page => _paginationFilter.value.page!;
  bool get lastPage => _lastPage.value;
  List get myPosts => _myPosts.toList();
  final _paginationFilter = LazyLoadingFilter().obs;
  get paginationFilter => _paginationFilter.value;

  @override
  void onInit() {
    Get.lazyPut<PostProvider>(() => PostProvider());
    Get.lazyPut<ImagePickerController>(() => ImagePickerController());
    pickerController = Get.find<ImagePickerController>();
    ever(_paginationFilter, (_) => getMyPosts());
    changePaginationFilter(1, 15);
    super.onInit();
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
    if (response.statusCode == 200) {
      isLoading.value = false;
      posts.value = json.decode(json.encode(response.body['data']));
    } else {
      isLoading.value = false;
      posts.value = [];
    }
  }

  void getMyPosts() async {
    print('getMyPosts');
    final response =
        await Get.find<PostProvider>().getPostsByUser(_paginationFilter.value);
    if (response.statusCode == 200) {
      if (response.body['data'].length < _limit) {
        _lastPage.value = true;
      }
      _myPosts.addAll(response.body['data']);
    }

    //   myPosts.value = [];
  }

  void storePost() async {
    isUploading.value = true;
    final response = await Get.find<PostProvider>().storePost(
      description: descriptionController.value.text,
      hashtagId: flagId.value,
      file: File(image.value.path),
    );
    if (response.statusCode == 201) {
      isUploading.value = false;
      fetchPosts();
    }
  }

  void storeFlag() async {
    final response =
        await Get.find<PostProvider>().storeFlag(searchFlag.value.text);
    if (response.statusCode == 201) {
      fetchFlags(searchFlag.value.text);
    }
  }

  void deletePost(int id) async {
    final response = await Get.find<PostProvider>().deletePost(id);
    if (response.statusCode == 200) {
      fetchPosts();
    }
  }

  void downloadImage(String path) async {
    final response = await Get.find<PostProvider>().downloadImage(path);
  }

  void changePaginationFilter(int page, int limit) {
    _paginationFilter.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }

  void changeTotalPerPage(int limitVal) {
    _myPosts.clear();
    _lastPage.value = false;
    changePaginationFilter(1, limitVal);
  }

  void loadNextPage() => changePaginationFilter(_page + 1, _limit);

  String randomStringWord() {
    var random = Random();
    //make random word
    var word = List.generate(random.nextInt(10) + 5, (index) {
      return String.fromCharCode(random.nextInt(26) + 97);
    });
    return word.join();
  }
}
