import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/theme/typhography.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "SIMANTAN",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 15, 25, 34)),
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
            const Text('v1.0.0'),
          ],
        ),
      )),
    );
  }
}
