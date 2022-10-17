import 'package:get/get.dart';

class PostProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl =
        'https://634d2164f5d2cc648e9d4020.mockapi.io/simantan/';
  }

  // get posts
  Future<Response> getPosts() => get('users');
}
