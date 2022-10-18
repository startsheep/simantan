import 'package:get/get.dart';

class PostProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl =
        'https://634d2164f5d2cc648e9d4020.mockapi.io/simantan/';
  }

  // get posts
  Future<Response> getPosts() => get('posts');
  Future<Response> getPost(id) => get('users/$id/posts');
  Future<Response> getUsers() => get('users');
}
