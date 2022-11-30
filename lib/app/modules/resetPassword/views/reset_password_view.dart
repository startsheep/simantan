import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/widgets/button_primary.dart';
import 'package:simantan/app/widgets/reuse_textfield.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('Ganti Password',
              style: TextStyle(color: Colors.black, fontSize: 20)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReuseTextField(
                    controller: controller.oldPassControl.value,
                    hintText: 'Password Lama',
                    obscureText: !controller.isShowPass.value,
                    maxLines: 1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  Divider(),
                  ReuseTextField(
                    controller: controller.newPassControl.value,
                    hintText: 'Password Baru',
                    maxLines: 1,
                    obscureText: !controller.isShowPass.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  Divider(),
                  ReuseTextField(
                    controller: controller.confirmPassControl.value,
                    hintText: 'Konfirmasi Password',
                    maxLines: 1,
                    obscureText: !controller.isShowPass.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password tidak boleh kosong';
                      } else if (value !=
                          controller.newPassControl.value.text) {
                        return 'Password tidak sama';
                      }
                      return null;
                    },
                  ),
                  Divider(),
                  ElevatedButton(
                    onPressed: () {
                      controller.isShowPass.value =
                          !controller.isShowPass.value;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.isShowPass.value
                              ? 'Sembunyikan'
                              : 'Tampilkan',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          controller.isShowPass.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeIn,
                    child: controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ButtonPrimary(
                            label: 'Ganti Password',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                controller.changePassword();
                              }
                            },
                          ),
                  ),
                ],
              );
            }),
          ),
        ));
  }
}
