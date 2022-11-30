// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:get/get.dart';
import 'package:simantan/app/services/auth_services.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://simantan.startsheep.my.id/api/';
  }

  Future<Response> login(String username, String password) async {
    return await post('auth/login', {
      'nip': username,
      'password': password,
    });
  }

  Future<Response> logout() async {
    return await post('auth/logout', {}, headers: {
      'Authorization': 'Bearer ' + AuthServices.getToken,
    });
  }

  Future<Response> changePassword(
      {String? oldPass, String? newPass, String? confirmPass}) {
    return put(
      'user/change-password/${AuthServices.getUserId}',
      {
        'old_password': oldPass,
        'new_password': newPass,
        'confirm_password': confirmPass,
      },
      headers: {
        'Authorization': 'Bearer ' + AuthServices.getToken,
      },
    );
  }
}
