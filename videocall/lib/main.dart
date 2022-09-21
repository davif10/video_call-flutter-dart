import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_call/routes/pages.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: Pages.INITIAL,
    getPages: Pages.routes,
    debugShowCheckedModeBanner: false,
  ));
}
