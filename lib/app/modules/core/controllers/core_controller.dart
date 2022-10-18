import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/modules/home/controllers/home_controller.dart';
import 'package:simantan/app/modules/home/controllers/post_controller.dart';
import 'package:simantan/app/modules/home/views/home_view.dart';

class CoreController extends GetxController {
  //TODO: Implement CoreController

  RxInt currentPage = 0.obs;
  List<Widget> views = [
    HomeView(),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.blue,
    ),
  ];

  // run controller per page
  void removeController() {
    if (currentPage.value != 0) {
      Get.delete<PostController>();
    }
  }

  void onChangePage(int index) {
    switch (index) {
      case 0:
        Get.lazyPut<HomeController>(() => HomeController());
        Get.find<HomeController>().onInit();
        Get.lazyPut<PostController>(() => PostController());
        Get.find<PostController>().onInit();
        break;
      case 1:
        break;
      case 2:
        break;
      default:
    }
  }

  @override
  void onInit() {
    super.onInit();
    ever(
      currentPage,
      (_) {
        onChangePage(currentPage.value);
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
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changePage(int newPage) {
    currentPage.value = newPage;
    update();
  }

  // create function date time from now
}
