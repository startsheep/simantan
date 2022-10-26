import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/modules/home/controllers/home_controller.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/modules/home/views/home_view.dart';
import 'package:simantan/app/modules/post/views/post_view.dart';
import 'package:simantan/app/modules/profile/controllers/profile_controller.dart';
import 'package:simantan/app/modules/profile/views/profile_view.dart';

class CoreController extends GetxController {
  //TODO: Implement CoreController

  RxInt currentPage = 0.obs;
  List<Widget> views = [
    HomeView(),
    PostView(),
    ProfileView(),
    Container(
      color: Color.fromARGB(255, 0, 4, 8),
    ),
  ];

  // run controller per page
  void removeController() {
    if (currentPage.value != 0) {
      Get.delete<HomeController>();
    }
    if (currentPage.value != 1) {
      Get.delete<PostController>();
    }
    if (currentPage.value != 2) {
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
        // Get.find<PostController>().onInit();
        break;
      case 2:
        // Get.find<AuthController>().onInit();
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
    update();
  }

  // create function date time from now
}
