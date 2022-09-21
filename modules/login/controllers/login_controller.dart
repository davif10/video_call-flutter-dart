import 'dart:async';

import 'package:get/get.dart';
import 'package:video_call/routes/pages.dart';

class LoginController extends GetxController{
  RxBool status = false.obs;

  @override
  void onReady() {
    super.onReady();
    _mudandoStatus();
  }
  irParaHome()=> Get.offAndToNamed(Routes.HOME);

  _mudandoStatus() async{
    await Future.delayed(Duration(seconds: 1)).then((_) => status.value  = true);
  }
}