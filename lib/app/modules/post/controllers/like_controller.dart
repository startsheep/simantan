import 'package:get/get.dart';
import 'package:simantan/app/modules/home/providers/post_provider.dart';

class LikeController extends GetxController {
  //TODO: Implement LikeController
  RxBool isLiked = false.obs;
  RxString countLike = ''.obs;

  @override
  void onInit() {
    Get.lazyPut<PostProvider>(() => PostProvider());
    Get.find<PostProvider>().onInit();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // likePost();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<bool> likePost(int postId) async {
    final response = await Get.find<PostProvider>().likePost(postId);
    if (response.statusCode == 200) {
      getCountLike(postId);
      return checkLike(postId);
    }
    return checkLike(postId);
  }

  Future<bool> checkLike(int postId) async {
    final response = await Get.find<PostProvider>().getLike(postId);
    if (response.statusCode == 200) {
      isLiked.value = response.body['data'];
    }
    return isLiked.value;
  }

  Future<String> getCountLike(int postId) async {
    final response = await Get.find<PostProvider>().getCountLike(postId);
    if (response.statusCode == 200) {
      countLike.value = response.body['data'].toString();
    }
    return countLike.value;
  }
}
