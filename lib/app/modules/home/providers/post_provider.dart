import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simantan/app/services/auth_services.dart';

class PostProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://simantan.nataysa.com/api/';
  }

  // get posts
  Future<Response> storePost(
      {String? description, int? hashtagId, File? file}) async {
    // post with image file
    final _formData = FormData({
      'description': description,
      'flag_id': hashtagId,
      'user_id': AuthServices.getUserId,
      'image': MultipartFile(
        file!,
        filename: file.path.split('/').last,
      ),

      // 'image': MultipartFile(File(image), filename: image!.name),
    });
    return await post('post', _formData, headers: {
      'Authorization': 'Bearer ' + AuthServices.getToken,
    });
  }

  Future<Response> getPosts() => get('post', headers: {
        'Authorization': 'Bearer ' + AuthServices.getToken,
      });

  Future<Response> storeFlag(String flag) {
    return post('flag', {
      "name": flag,
    }, headers: {
      'Authorization': 'Bearer ' + AuthServices.getToken,
    });
  }

  Future<Response> getFlags(String search) => get(
        'flag',
        headers: {
          'Authorization': 'Bearer ' + AuthServices.getToken,
        },
        query: {
          'search': search,
        },
      );
}
