import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
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

    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    return image;
  }

  getImageFromCamera() async {
    isLoading.value = true;

    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    return image;
  }
}
