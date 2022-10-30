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
      {String? description, String? hashtag, File? file}) async {
    // post with image file
    final _formData = FormData({
      'description': description,
      'flag_id': 2,
      'user_id': 1,
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
  Future<Response> getPost(id) => get('users/$id/posts');
  Future<Response> getPostComments(id) => get('posts/$id/comments');
}
