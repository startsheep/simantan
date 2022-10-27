import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/services/auth_services.dart';
import 'package:sp_util/sp_util.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await SpUtil.getInstance();
  await Get.putAsync(() => SpUtil.getInstance());
  runApp(
    GetMaterialApp(
      title: "SIMANTAN",
      initialRoute: AuthServices.getAuth ? Routes.CORE : Routes.AUTH,
      getPages: AppPages.routes,
    ),
  );
}
