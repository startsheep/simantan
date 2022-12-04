import 'package:get/get.dart';
import 'package:simantan/app/models/lazy_loading_filter.dart';
import 'package:simantan/app/modules/home/providers/post_provider.dart';
import 'package:simantan/app/providers/user_provider.dart';
import 'package:simantan/app/services/auth_services.dart';

class UserController extends GetxController {
  //TODO: Implement UserController

  final count = 0.obs;
  final _lastPage = false.obs;
  final RxList _posts = [].obs;
  List get posts => _posts.toList();
  int get _limit => paginationFilter.value.limit!;
  int get _page => paginationFilter.value.page!;
  bool get lastPage => _lastPage.value;
  RxInt countLike = 0.obs;
  RxInt countPost = 0.obs;

  RxBool isLoading = true.obs;
  final paginationFilter = LazyLoadingFilter().obs;

  @override
  void onInit() {
    Get.lazyPut<PostProvider>(() => PostProvider());
    Get.lazyPut<UserProvider>(() => UserProvider());
    Get.find<PostProvider>().onInit();
    Get.find<UserProvider>().onInit();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    ever(paginationFilter, (_) => getUserPosts());
    changePaginationFilter(1, 15);
    getCountLike();
    getCountPost();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> refreshPage() async {
    isLoading.value = true;
    _posts.clear();
    changePaginationFilter(1, 15);
  }

  Future<void> getUserPosts() async {
    print('getUserPosts');
    // isLoading.value = true;
    final response = await Get.find<PostProvider>()
        .getPostsByUser(paginationFilter.value, Get.parameters['userId']!);
    if (response.statusCode == 200) {
      isLoading.value = false;

      if (response.body['data'].length == 0) {
        _lastPage.value = true;
      } else {
        _lastPage.value = false;
        _posts.addAll(response.body['data']);
      }
    }
  }

  void changePaginationFilter(int page, int limit) {
    paginationFilter.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }

  void changeTotalPerPage(int limitVal) {
    _posts.clear();
    _lastPage.value = false;
    changePaginationFilter(1, limitVal);
  }

  void loadNextPage() => changePaginationFilter(_page + 1, _limit);
  void getCountPost() async {
    final response = await Get.find<UserProvider>()
        .getCountPost(int.parse(Get.parameters['userId']!));
    print(response.body);
    if (response.statusCode == 200) {
      countPost.value = response.body['data'];
    }
  }

  void getCountLike() async {
    final response = await Get.find<UserProvider>()
        .getCountLike(int.parse(Get.parameters['userId']!));
    print(response.body);
    if (response.statusCode == 200) {
      countLike.value = response.body['data'];
    }
  }
}
