import 'package:get/get.dart';
import 'package:simantan/app/modules/home/providers/post_provider.dart';

class SearchController extends GetxController {
  //TODO: Implement SearchController
  RxBool isLoading = false.obs;
  final selectedFlag = null.obs;
  final selectedCategory = null.obs;
  final RxInt selectedChip = 0.obs;
  final RxInt selectedChipCategory = 0.obs;
  final RxList flags = [].obs;
  final RxList posts = [].obs;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<PostProvider>(() => PostProvider());
    Get.find<PostProvider>().onInit();
    fetchFlags();
  }

  void fetchFlags() async {
    isLoading.value = true;
    final response = await Get.find<PostProvider>().getFlags();
    if (response.statusCode == 200) {
      isLoading.value = false;
      flags.assignAll(response.body['data']);
    }
  }

  void fetchPosts() async {
    isLoading.value = true;
    // final response = await Get.find<PostProvider>().getPosts(
    //     selectedFlag.value.toString(), selectedCategory.value.toString());
    // if (response.statusCode == 200) {
    //   isLoading.value = false;
    //   posts.assignAll(response.body['data']);
    // }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}