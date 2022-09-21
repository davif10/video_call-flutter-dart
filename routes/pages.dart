import 'package:get/get.dart';
import 'package:video_call/modules/home/bindings/home_binding.dart';
import 'package:video_call/modules/home/views/home.dart';
import 'package:video_call/modules/login/bindings/login_binding.dart';
import 'package:video_call/modules/login/views/login.dart';

part 'routes.dart';

class Pages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
        name: _Paths.LOGIN,
        page: () => const Login(),
        bindings: [LoginBinding()],
        transition: Transition.zoom,
        preventDuplicates: true
    ),

    GetPage(
        name: _Paths.HOME,
        page: () => const Home(),
        bindings: [HomeBinding()],
        transition: Transition.zoom,
        preventDuplicates: true
    ),
  ];
}