import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videocall/routes/pages.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: Pages.INITIAL,
    getPages: Pages.routes,
    debugShowCheckedModeBanner: false,
  ));
}
