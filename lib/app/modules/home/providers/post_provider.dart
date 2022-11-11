// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simantan/app/models/lazy_loading_filter.dart';
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
  Future<Response> getPostsByUser(LazyLoadingFilter filter) =>
      get('post', headers: {
        'Authorization': 'Bearer ' + AuthServices.getToken,
      }, query: {
        'user': AuthServices.getUserId.toString(),
        'per_page': filter.limit.toString(),
        'page': filter.page.toString()
      });
  Future<Response> storeFlag(String flag) {
    return post('flag', {
      "name": flag,
    }, headers: {
      'Authorization': 'Bearer ' + AuthServices.getToken,
    });
  }

  Future<Response> deletePost(int id) {
    return delete('post/$id', headers: {
      'Authorization': 'Bearer ' + AuthServices.getToken,
    });
  }

  Future<Response> getFlags({String? search}) => get(
        'flag',
        headers: {
          'Authorization': 'Bearer ' + AuthServices.getToken,
        },
        query: {
          'search': search,
          'per_page': '',
        },
      );

  // create function for downloadImage
  Future<Response> downloadImage(String path) async {
    final response = await get(path);
    return response;
  }

  Future<Response> likePost(int id) {
    return post('like/$id', {}, headers: {
      'Authorization': 'Bearer ' + AuthServices.getToken,
    });
  }

  Future<Response> getLike(int id) {
    return get('like/$id', headers: {
      'Authorization': 'Bearer ' + AuthServices.getToken,
    });
  }
}
