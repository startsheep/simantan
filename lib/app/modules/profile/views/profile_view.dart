import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/theme/colors.dart';
import 'package:sp_util/sp_util.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {
              Get.bottomSheet(
                Container(
                  height: 200,
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Logout'),
                        onTap: () {
                          // confirm dialog
                          Get.defaultDialog(
                            title: 'Logout',
                            middleText: 'Apakah anda yakin ingin logout?',
                            textConfirm: 'Ya',
                            textCancel: 'Tidak',
                            confirmTextColor: Colors.white,
                            cancelTextColor: Color.fromARGB(255, 23, 22, 22),
                            buttonColor: SchemaColor.primary,
                            onConfirm: () {
                              Get.back();
                              controller.authController.logout();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
        //
      ),
      // make like profile instagram
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Color.fromARGB(255, 111, 255, 116),
                      child: CircleAvatar(
                        radius: 43,
                        foregroundColor: SchemaColor.primary,
                        backgroundImage:
                            NetworkImage('https://placeimg.com/640/480/people'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Full Name',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // const Divider(),

            // const Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SchemaColor.primary,
                ),
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: Get.width,
                  child: const Text(
                    'Edit Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://placeimg.com/640/480/nature${index * 1}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
