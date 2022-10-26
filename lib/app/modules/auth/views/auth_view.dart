import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/theme/colors.dart';
import 'package:simantan/app/theme/typhography.dart';
import 'package:simantan/app/widgets/reuse_textfield.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
              Form(
                key: formKey,
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Masuk",
                        style: TypoGraphy.h5,
                        // textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 20),
                      ReuseTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Nip tidak boleh kosong";
                          }
                          return null;
                        },
                        hintText: "NIP",
                        prefixIcon: Icons.account_circle,
                        controller: controller.usernameController,
                      ),
                      const SizedBox(height: 20),
                      ReuseTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password tidak boleh kosong";
                          }
                          return null;
                        },
                        controller: controller.passwordController,
                        hintText: "Password",
                        prefixIcon: Icons.lock,
                        obscureText: controller.isPasswordvisible.value,
                        maxLines: 1,
                        onPressSuffix: () {
                          controller.isPasswordvisible.value =
                              !controller.isPasswordvisible.value;
                        },
                        suffixIcon: controller.isPasswordvisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      // make full width button
                      const SizedBox(height: 20),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: double.infinity,
                        child: controller.isSubmit.value == false
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: SchemaColor.primary,
                                  padding: EdgeInsets.all(12),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate())
                                    controller.login();
                                },
                                child: Text(
                                  'Masuk',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Center(
                                child: const CircularProgressIndicator(
                                color: SchemaColor.primary,
                              )),
                      ),
                    ],
                  ),
                ),
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
