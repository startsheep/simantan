import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/theme/colors.dart';

import '../controllers/core_controller.dart';

class CoreView extends GetView<CoreController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => controller.views[controller.currentPage.value],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (value) => controller.changePage(value),
            currentIndex: controller.currentPage.value,
            // selectedFontSize: 16,
            selectedItemColor: SchemaColor.primary,
            // backgroundColor: Colors.grey,P
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
                activeIcon: Icon(Icons.search_rounded),
                icon: Icon(Icons.search_off_outlined),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_outlined),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
