import 'package:get/get.dart';
import 'package:simantan/app/services/auth_services.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://simantan.nataysa.com/api/';
    httpClient.addAuthenticator<dynamic>((request) async {
      request.headers['Authorization'] = AuthServices.getToken;
      return request;
    });
    // set headers
    // httpClient.addAuthenticator((request) => request);
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
