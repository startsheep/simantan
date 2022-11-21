import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simantan/app/controllers/image_picker_controller.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/modules/auth/controllers/auth_controller.dart';
import 'package:simantan/app/providers/user_provider.dart';
import 'package:simantan/app/services/auth_services.dart';
import 'package:simantan/app/theme/colors.dart';
import 'package:sp_util/sp_util.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  late AuthController authController;
  late PostController postController;

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> nipController = TextEditingController().obs;
  RxString avatarUrl = ''.obs;
  TextEditingController emailController = TextEditingController();
  Map<String, dynamic> user = {};
  Rx<XFile> image = XFile('').obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<PostController>(() => PostController());
    Get.lazyPut<UserProvider>(() => UserProvider());
    postController = Get.find<PostController>();
    authController = Get.find<AuthController>();
    Get.lazyPut<ImagePickerController>(() => ImagePickerController());
    ever(postController.paginationFilter, (_) => postController.getMyPosts());
    postController.changePaginationFilter(1, 15);
  }

  void getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = XFile(pickedFile.path);
    }
  }

  void getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image.value = XFile(pickedFile.path);
    }
  }

  void getUser() async {
    print('get user');
    final response = await Get.find<UserProvider>()
        .getUser(AuthServices.getUserId.toString());

    if (response.statusCode == 200) {
      nameController.value.text = response.body['data']['name'];
      nipController.value.text = response.body['data']['nip'];
      avatarUrl.value = response.body['data']['image'];

      // AuthServices.setUser = json.encode(response.body['data']);
      isLoading.value = false;
    }
  }

  void updateUser() async {
    final response = await Get.find<UserProvider>().updateUser(
      userId: AuthServices.getUserId.toString(),
      name: nameController.value.text,
      nip: nipController.value.text,
      image: File(image.value.path),
    );
    print(response.body);
    if (response.statusCode == 200) {
      getUser();
      Get.back();
      Get.snackbar(
        'Success',
        'Sudah diupdate yaa',
        backgroundColor: SchemaColor.success,
        icon: Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
      );
    } else {
      Get.snackbar('Failed', 'Gagal update');
    }
  }

  @override
  void onReady() {
    super.onReady();
    getUser();
  }

  @override
  void onClose() {}
}
