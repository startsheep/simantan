import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  String formatDateTime(dateTime) {
    // parse to datetime to Datetime
    DateTime date = DateTime.parse(dateTime);
    return date.day.toString() +
        " " +
        date.month.toString() +
        " " +
        date.year.toString();
  }

  // List<d
}
