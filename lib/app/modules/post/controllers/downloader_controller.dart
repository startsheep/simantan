import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';

class DownloaderController extends GetxController {
  //TODO: Implement DownloaderController
  RxInt _progress = 0.obs;
  RxString _path = "".obs;
  RxString _size = "".obs;
  RxString _mimeType = "".obs;
  RxString _message = "".obs;
  File? _imageFile;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    ImageDownloader.callback(onProgressUpdate: (String? imageId, int progress) {
      _progress.value = progress;
    });
  }

  // Future<void> downloadImage(
  //   String url, {
  //   AndroidDestinationType? destination,
  //   bool whenError = false,
  //   String? outputMimeType,
  // }) async {
  //   String? fileName;
  //   String? path;
  //   int? size;
  //   String? mimeType;
  //   try {
  //     final imageId = await ImageDownloader.downloadImage(
  //       url,
  //       destination: destination,
  //     );
  //     if (imageId == null) {
  //       return;
  //     }
  //     fileName = await ImageDownloader.findName(imageId);
  //     path = await ImageDownloader.findPath(imageId);
  //     size = await ImageDownloader.findByteSize(imageId);
  //     mimeType = await ImageDownloader.findMimeType(imageId);
  //   } on PlatformException catch (error) {
  //     print(error);
  //   }
  // }

  Future<void> downloadImage(
    String url, {
    AndroidDestinationType? destination,
    bool whenError = false,
    String? outputMimeType,
  }) async {
    String? fileName;
    String? path;
    int? size;
    String? mimeType;
    try {
      String? imageId;

      if (whenError) {
        imageId = await ImageDownloader.downloadImage(url,
                outputMimeType: outputMimeType)
            .catchError((error) {
          if (error is PlatformException) {
            String? path = "";
            if (error.code == "404") {
              print("Not Found Error.");
            } else if (error.code == "unsupported_file") {
              print("UnSupported FIle Error.");
              path = error.details["unsupported_file_path"];
            }
            // setState(() {
            _message.value = error.toString();
            _path.value = path ?? '';
            // });
          }

          print(error);
        }).timeout(Duration(seconds: 10), onTimeout: () {
          print("timeout");
          return;
        });
      } else {
        if (destination == null) {
          imageId = await ImageDownloader.downloadImage(
            url,
            outputMimeType: outputMimeType,
          );
        } else {
          imageId = await ImageDownloader.downloadImage(
            url,
            destination: destination,
            outputMimeType: outputMimeType,
          );
        }
      }

      if (imageId == null) {
        return;
      }
      fileName = await ImageDownloader.findName(imageId);
      path = await ImageDownloader.findPath(imageId);
      size = await ImageDownloader.findByteSize(imageId);
      mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      // setState(() {
      _message.value = error.message ?? '';
      // });
      return;
    }
    // chnage mounted to getx

    // if (!mounted) return;

    // setState(() {
    var location = Platform.isAndroid ? "Directory" : "Photo Library";
    _message.value = 'Saved as "$fileName" in $location.\n';
    _size.value = 'size:     $size';
    _mimeType.value = 'mimeType: $mimeType';
    _path.value = path ?? '';

    if (!_mimeType.contains("video")) {
      _imageFile = File(path!);
    }
    return;
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
