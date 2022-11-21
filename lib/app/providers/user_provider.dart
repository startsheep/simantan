import 'dart:io';

import 'package:get/get.dart';
import 'package:simantan/app/models/lazy_loading_filter.dart';
import 'package:simantan/app/services/auth_services.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://simantan.startsheep.my.id/api/';
  }

  Future<Response> getUsers(LazyLoadingFilter filter) {
    return get(
      'user',
      headers: {
        'Authorization': 'Bearer ' + AuthServices.getToken,
      },
      query: {
        // 'page': filter.page.toString(),
        // 'per_page': filter.limit.toString(),
      },
    );
  }

  Future<Response> getUser(String id) {
    return get(
      'user/$id',
      headers: {
        'Authorization': 'Bearer ' + AuthServices.getToken,
      },
    );
  }

  Future<Response> updateUser(
      {String? userId, String? name, String? nip, File? image}) {
    FormData _formData = FormData({
      'name': name,
      'nip': nip,
      'image': MultipartFile(
        image!,
        filename: image.path.split('/').last,
      ),
      '_method': 'PUT',
    });
    return post(
      'user/$userId',
      _formData,
      headers: {
        'Authorization': 'Bearer ' + AuthServices.getToken,
      },
    );
  }
}
