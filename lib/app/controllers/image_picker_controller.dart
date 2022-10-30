import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  //TODO: Implement Controller
  // overide all method
  // File image = File(_).;
  Rx<File> image = File('').obs;
  RxBool isLoading = false.obs;
  late ImagePicker _picker;

  @override
  void onInit() {
    super.onInit();
    _picker = ImagePicker();
  }

  getImageFromGallery() async {
    isLoading.value = true;
    print("GetImage");
    final XFile? _image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    )!;
    print('image path: ${_image!.path}');
    return _image;
  }

  getImageFromCamera() async {
    isLoading.value = true;
    print("GetImage");
    final XFile? _image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    )!;
    print('image path: ${_image!.path}');
    return _image;
  }
}
