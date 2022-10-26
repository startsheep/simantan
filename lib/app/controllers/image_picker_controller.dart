import 'dart:io';

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

  getImageFromGallery() {
    isLoading.value = true;
    _picker.getImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        image.value = File(value.path);
        isLoading.value = false;
      }
    });
  }
}
