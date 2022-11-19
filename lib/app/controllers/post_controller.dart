import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simantan/app/controllers/image_picker_controller.dart';
import 'package:simantan/app/models/lazy_loading_filter.dart';
import 'package:simantan/app/modules/core/controllers/core_controller.dart';
import 'package:simantan/app/modules/home/providers/post_provider.dart';
import 'package:simantan/app/theme/colors.dart';

class PostController extends GetxController {
  //TODO: Implement PostControllerController
  RxList _posts = [].obs;
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
  final RxString searchFlagText = ''.obs;
  RxString flagName = ''.obs;
  RxList likedPosts = [].obs;
  RxList dislikedPosts = [].obs;
  RxBool isLiked = false.obs;

  final _lastPage = false.obs;
  int get _limit => paginationFilter.value.limit!;
  int get _page => paginationFilter.value.page!;
  bool get lastPage => _lastPage.value;
  List get myPosts => _myPosts.toList();
  List get posts => _posts.toList();
  final paginationFilter = LazyLoadingFilter().obs;

  // get paginationFilter => paginationFilter.value;

  @override
  void onInit() {
    Get.lazyPut<PostProvider>(() => PostProvider());
    Get.lazyPut<ImagePickerController>(() => ImagePickerController());
    pickerController = Get.find<ImagePickerController>();
    super.onInit();
  }

  @override
  void onClose() {}
  @override
  void onReady() {
    super.onReady();
    debounce(searchFlagText, (_) => fetchFlags(),
        time: Duration(milliseconds: 500));
  }

  Future<List> fetchFlags() async {
    isLoading.value = true;
    final response =
        await Get.find<PostProvider>().getFlags(search: searchFlagText.value);
    if (response.statusCode == 200) {
      isLoading.value = false;
      flags.assignAll(response.body['data']);
    } else {
      // flags.assignAll([]);
      isLoading.value = false;
    }
    return flags;
  }

  void fetchPosts() async {
    // isLoading.value = true;
    final response =
        await Get.find<PostProvider>().getPosts(paginationFilter.value);
    if (response.statusCode == 200) {
      isLoading.value = false;
      if (response.body['data'].length == 0) {
        _lastPage.value = true;
      } else {
        _lastPage.value = false;
        _posts.addAll(response.body['data']);
        _posts.forEach((element) {
          likedPosts.add(
            {
              'id': element['id'],
              'liked': isLiked.value,
            },
          );
        });
      }
    } else {
      isLoading.value = false;
    }
  }

  void refreshPage() async {
    // ignore: invalid_use_of_protected_member
    _posts.value = _posts.value;
  }

  void likePost(int idPost) async {
    final response = await Get.find<PostProvider>().likePost(idPost);
    if (response.statusCode == 200) {
      likedPosts.forEach((element) {
        if (element['id'] == idPost) {
          element['liked'] = !element['liked'];
        }
      });
    }
  }

  void isLikedPost(
    int postId,
  ) async {
    bool liked = false;
    final response = await Get.find<PostProvider>().getLike(postId);
    if (response.statusCode == 200) {
      liked = response.body['data'];
      isLiked.value = liked;
    }
  }

  void getMyPosts() async {
    print('getMyPosts');
    isLoading.value = true;
    final response =
        await Get.find<PostProvider>().getPostsByUser(paginationFilter.value);
    if (response.statusCode == 200) {
      isLoading.value = false;
      if (response.body['data'].length == 0) {
        _lastPage.value = true;
      } else {
        _lastPage.value = false;
        _myPosts.addAll(response.body['data']);
      }
    }
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
      // showSuccessSnackbar();
      Get.find<CoreController>().currentPage.value = 0;
      Get.snackbar('Berhasil', 'Sudah di posting yaa',
          backgroundColor: SchemaColor.success);

      fetchPosts();
    } else {
      isUploading.value = false;
    }
  }

  void storeFlag() async {
    print('storeFlag');
    final response =
        await Get.find<PostProvider>().storeFlag(searchFlag.value.text);
    print(response.statusCode);
    if (response.statusCode == 200) {
      fetchFlags();
      update();
    }
  }

  void deletePost(int id) async {
    final response = await Get.find<PostProvider>().deletePost(id);
    if (response.statusCode == 200) {
      getMyPosts();
    }
  }

  void changePaginationFilter(int page, int limit) {
    paginationFilter.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }

  void changeTotalPerPage(int limitVal) {
    _myPosts.clear();
    _posts.clear();
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

  void onSuccessPost() {
    // show
  }
  void countLikePost(String idPost) async {
    final response = await Get.find<PostProvider>().getCountLike(idPost);
    if (response.statusCode == 200) {
      print(response.body['data']);
      // return response.body['data'];
    }
  }
}
