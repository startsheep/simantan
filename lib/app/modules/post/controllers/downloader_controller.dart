import 'dart:io';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simantan/app/theme/colors.dart';

class DownloaderController extends GetxController {
  //TODO: Implement DownloaderController
  RxDouble progress = 0.0.obs;
  RxBool downloading = false.obs;
  RxString progressString = "".obs;
  RxString _path = "".obs;
  RxString _size = "".obs;
  RxString _mimeType = "".obs;
  RxString _message = "".obs;
  File? _imageFile;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> getStoragePremission() async {
    return await Permission.storage.request().isGranted;
  }

  Future<String> getDownloadFolderPath() async {
    return await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
  }

  Future downloadFIle(
    String? url,
    String? downloadDirectory,
    String fileName,
  ) async {
    // from getxcontroller not from unage_downloader
    Dio dio = Dio();
    var downloadPath = '$downloadDirectory/image.jpg';
    await dio.download(
      url!,
      downloadPath,
      options: Options(responseType: ResponseType.bytes),
      onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");
        progress.value = ((rec / total) * 100) / 100;
        progressString.value = progress.value.toString() + "%";
      },
    );
    // await Future.delayed(const Duration(seconds: 3));
    return downloadPath;
  }

  Future<void> doDownload(String? url, String? fileName) async {
    downloading.value = true;
    if (await getStoragePremission()) {
      String? downloadDirectory = await getDownloadFolderPath();
      await downloadFIle(url, downloadDirectory, fileName!).then((value) => {
            downloading.value = false,
            _message.value = "Downloaded successfully",
            _path.value = value,
            // print(_path.value),
            _imageFile = File(value),
            _size.value = (_imageFile!.lengthSync() / 1024 / 1024)
                .toStringAsFixed(2), // in MB
            _mimeType.value = _imageFile!.statSync().type.toString(),
            // show snackbar
            Get.snackbar(
              "Berhasil",
              "Bisa dilihat di folder unduhan",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Color.fromARGB(255, 209, 255, 209),
              colorText: Color.fromARGB(255, 66, 66, 66),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          });
    }
    //
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
