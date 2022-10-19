import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/theme/typhography.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: Get.height,
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image
              Image.asset(
                'assets/logo-brand.png',
                width: 200,
              ),
              SizedBox(
                height: 20,
              ),
              const Text(
                "SIMANTAN",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 15, 25, 34)),
              ),
              SizedBox(
                height: 10,
              ),
              const Text(
                "Sistem Informasi Dokumentasi Kegiatan",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 15, 25, 34)),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Masuk",
                    style: TypoGraphy.h5,
                    // textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller.usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller.passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  // make full width button
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: () {
                          controller.login();
                        },
                        child: Text(
                            controller.isSubmit.value ? 'Loading...' : 'Masuk'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              const Text('v1.0.0'),
            ],
          ),
        ),
      )),
    );
  }
}
