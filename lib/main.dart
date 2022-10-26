import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await SpUtil.getInstance();
  await Get.putAsync(() => SpUtil.getInstance());
  runApp(
    GetMaterialApp(
      defaultTransition: Transition.downToUp,
      title: "SIMANTAN",
      initialRoute: SpUtil.getBool('isAuth')! ? Routes.CORE : Routes.AUTH,
      getPages: AppPages.routes,
    ),
  );
}
