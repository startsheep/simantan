import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/core_controller.dart';

class CoreView extends GetView<CoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Obx(
            () => controller.views[controller.currentPage.value],
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (value) => controller.changePage(value),
            currentIndex: controller.currentPage.value,
            // backgroundColor: Color.fromARGB(255, 215, 215, 215),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_a_photo_outlined),
                activeIcon: Icon(Icons.add_a_photo_rounded),
                label: 'Posting',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_outlined),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ));
  }
}
