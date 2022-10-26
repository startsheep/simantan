import 'package:get/get.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://simantan.nataysa.com/api/';
    // model
    // httpClient.defaultDecoder = (map) => User.fromJson(map);
  }

  Future<Response> login(String username, String password) async {
    return await post('auth/login', {
      'nip': username,
      'password': password,
    });
  }

  Future<Response> logout() async {
    return await post('auth/logout', {});
  }
}
