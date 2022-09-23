import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_call/modules/login/controllers/login_controller.dart';

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),//Pixel XL
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          body: Obx(() => AnimatedContainer(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      controller.status.value
                          ? Color(0xff0d47a1)
                          : Color(0xff8175f8),
                      controller.status.value
                          ? Colors.blue[200]!
                          : Color(0xFFA494CD),
                      Colors.white,
                    ])),
                curve: Curves.easeIn,
                duration: Duration(seconds: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.duo,
                          color: Colors.white,
                          size: 70.sp,
                        ),
                        Text(
                          "Video Call",
                          style: GoogleFonts.lobster(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 50.sp)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24, left: 32, right: 32),
                      child: TextField(
                          //controller: controller.mensagemController,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              labelText: "Usuário",
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white60)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              border: OutlineInputBorder()),
                          style: TextStyle(fontSize: 16.sp)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 8, left: 32, right: 32, bottom: 8),
                      child: TextField(
                          //controller: controller.mensagemController,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              labelText: "Senha",
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white60)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              border: OutlineInputBorder()),
                          style: TextStyle(fontSize: 16.sp)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 8, right: 8, bottom: 16),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding:  EdgeInsets.only(
                              left: 50.sp, right: 50.sp, top: 15.sp, bottom: 15.sp),
                          backgroundColor: Color(0xff487acb),
                        ),
                        onPressed: () => controller.irParaHome(),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
