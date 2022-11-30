import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/comment/bindings/comment_binding.dart';
import '../modules/comment/views/comment_view.dart';
import '../modules/core/bindings/core_binding.dart';
import '../modules/core/views/core_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/post/bindings/post_binding.dart';
import '../modules/post/views/post_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile/views/update_profile_view.dart';
import '../modules/resetPassword/bindings/reset_password_binding.dart';
import '../modules/resetPassword/views/reset_password_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/test/bindings/test_binding.dart';
import '../modules/test/views/test_view.dart';
import '../modules/user/bindings/user_binding.dart';
import '../modules/user/views/user_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.CORE,
      page: () => CoreView(),
      binding: CoreBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.PROFILE_UPDATE,
      page: () => UpdateProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.POST,
      page: () => PostView(),
      binding: PostBinding(),
    ),
    GetPage(
      name: _Paths.TEST,
      page: () => const TestView(),
      binding: TestBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.COMMENT,
      page: () => const CommentView(),
      binding: CommentBinding(),
    ),
    GetPage(
      name: _Paths.USER,
      page: () => const UserView(),
      binding: UserBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
  ];
}
