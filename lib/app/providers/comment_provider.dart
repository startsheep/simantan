import 'package:get/get.dart';
import 'package:simantan/app/models/lazy_loading_filter.dart';
import 'package:simantan/app/services/auth_services.dart';

class CommentProvider extends GetConnect {
  @override
  void onInit() {
    // httpClient.defaultDecoder = (map) => Comment.fromJson(map);
    httpClient.baseUrl = 'http://simantan.nataysa.com/api/';
  }

  Future<Response> storeComment({
    String? message,
    String? postId,
  }) async {
    final response = await post(
      'comment',
      {
        'message': message,
        'post_id': postId,
        'user_id': AuthServices.getUserId,
      },
      headers: {
        'Authorization': 'Bearer ' + AuthServices.getToken,
      },
    );
    return response;
  }

  Future<Response> getComments(LazyLoadingFilter filter) async {
    final response = await get(
      'comment',
      headers: {
        'Authorization': 'Bearer ' + AuthServices.getToken,
      },
      query: {
        'page': filter.page.toString(),
        'per_page': filter.limit.toString(),
      },
    );
    return response;
  }

  Future<Response> getCommentsByPost(
      String postId, LazyLoadingFilter filter) async {
    final response = await get(
      'comment',
      headers: {
        'Authorization': 'Bearer ' + AuthServices.getToken,
      },
      query: {
        'post': postId,
        'page': filter.page.toString(),
        'per_page': filter.limit.toString(),
      },
    );
    return response;
  }
}
