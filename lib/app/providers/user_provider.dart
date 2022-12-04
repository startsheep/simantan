import 'dart:io';

import 'package:get/get.dart';
import 'package:simantan/app/models/lazy_loading_filter.dart';
import 'package:simantan/app/services/auth_services.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://simantan.startsheep.my.id/api/';
  }

  Future<Response> getUsers(LazyLoadingFilter filter, {String? search}) {
    print('search: $search');

    return get(
      'user',
      headers: {
        'Authorization': 'Bearer ' + AuthServices.getToken,
      },
      query: {
        'search': search,
        'page': filter.page.toString(),
        'per_page': filter.limit.toString(),
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
      'image': image != null
          ? MultipartFile(
              image!,
              filename: image.path.split('/').last,
            )
          : null,
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

  Future<Response> getCountPost(int userId) {
    return get('user/count-post/$userId', headers: {
      'Authorization': 'Bearer ' + AuthServices.getToken,
    });
  }

  Future<Response> getCountLike(int userId) {
    return get('user/count-like/$userId', headers: {
      'Authorization': 'Bearer ' + AuthServices.getToken,
    });
  }
}
