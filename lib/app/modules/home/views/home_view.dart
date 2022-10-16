import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () {
                    Get.toNamed('/home');
                  },
                  icon: const Icon(Icons.home),
                ),
              ],
            ),
            Center(
                child: ElevatedButton(
              onPressed: () {
                print(SpUtil.getBool('isAuth'));
                // print();
              },
              child: Text('tes'),
            )),
          ],
        ),
      ),
    );
  }
}
