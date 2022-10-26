import 'package:get/get.dart';

class NetworkServices extends GetxService {
  // overide all method
  // File image = File(_).;
  RxBool isLoading = false.obs;
  RxBool isLoadMore = false.obs;
  RxBool isExpanded = false.obs;
  RxBool isRefresh = false.obs;
}
