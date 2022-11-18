import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/modules/comment/views/comment_view.dart';

import 'package:simantan/app/modules/home/controllers/home_controller.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/modules/home/views/home_view.dart';
import 'package:simantan/app/modules/post/views/post_view.dart';
import 'package:simantan/app/modules/profile/controllers/profile_controller.dart';
import 'package:simantan/app/modules/profile/views/profile_view.dart';
import 'package:simantan/app/modules/search/controllers/search_controller.dart';
import 'package:simantan/app/modules/search/views/search_view.dart';

class CoreController extends GetxController {
  //TODO: Implement CoreController

  RxInt currentPage = 0.obs;
  List<Widget> views = [
    HomeView(),
    PostView(),
    SearchView(),
    ProfileView(),
    CommentView()
  ];

  // run controller per page
  void removeController() {
    if (currentPage.value != 0) {
      Get.delete<HomeController>();
      Get.delete<PostController>();
      // Get.delete<CommentController>();
    }
    if (currentPage.value != 1) {
      Get.delete<PostController>();
    }
    if (currentPage.value != 2) {
      Get.delete<SearchController>();
    }
    if (currentPage.value != 3) {
      Get.delete<ProfileController>();
    }
  }

  void onChangePage(int index) {
    switch (index) {
      case 0:
        Get.lazyPut<HomeController>(() => HomeController());
        Get.find<HomeController>().onInit();

        break;
      case 1:
        Get.lazyPut<PostController>(() => PostController());
        break;
      case 2:
        Get.lazyPut<SearchController>(() => SearchController());
        // Get.find<AuthController>().onInit();
        break;
      case 3:
        Get.lazyPut<ProfileController>(() => ProfileController());
        Get.find<ProfileController>().onInit();
        break;
      default:
    }
  }

  @override
  void onInit() {
    super.onInit();
    ever(
      currentPage,
      (newVal) {
        onChangePage(newVal);
        removeController();
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
    ever(currentPage, (_) {
      onChangePage(currentPage.value);
    });
    print('onReady');
  }

  @override
  void onClose() {
    super.onClose();
    print('onClose');
  }

  void changePage(int newPage) {
    currentPage.value = newPage;
  }

  bool isWantPost() {
    final bool _isHasText =
        Get.find<PostController>().descriptionController.value.text.isNotEmpty;
    final bool _isHasImage = Get.find<PostController>().image.value.path != '';
    return (_isHasText || _isHasImage);
  }
  // create function date time from now
}
