import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/home_controller.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "Video Call",
            style: GoogleFonts.lobster(
                textStyle: TextStyle(color: Colors.white, fontSize: 35.sp)),
          ),
        ),
      ),
      body: Obx(() => _layoutParaExibir()),
    );
  }

  _layoutParaExibir(){
    switch(controller.layoutInicio.value){
      case "inicio": return _layoutInicio();
      case "exibirVideo": return _renderVideo();
      // case "erro": _layoutError();
      // break;
    }
  }

  _layoutInicio() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [
            Color(0xff0c1c32),
            Color(0xff2f5fa7),
            Color(0xff6e99ec),
            Color(0xff2f5fa7),
            Colors.black
          ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 24.0, left: 24, right: 24),
                child: Text(
                  "Para iniciar a chamada de vídeo, clique no botão abaixo!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22.sp, color: Colors.white),
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 15),
                    backgroundColor: Colors.black,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
                onPressed: () {
                  controller.initAgora();
                },
                child:  Icon(
                  Icons.videocam,
                  color: Colors.white,
                  size: 50.sp,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _renderVideo() {
    return Stack(
      children: [
        Container(
          child: (kIsWeb)
              ? RtcLocalView.SurfaceView(
                  zOrderMediaOverlay: true,
                  zOrderOnTop: true,
                )
              : RtcLocalView.TextureView(),
        ),

        Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              color: Color(0xAE787878),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    color: Colors.white,
                      onPressed: (){},
                      icon: Icon(Icons.camera_alt, color: Colors.black, size: 40.sp)),
                  IconButton(
                      color: Colors.red,
                      onPressed: ()=> _sair(),
                      icon: Icon(Icons.phone_disabled, color: Colors.white, size: 40.sp)),
                  IconButton(
                      color: Colors.white,
                      onPressed: (){},
                      icon: Icon(Icons.mic_off_rounded, color: Colors.black, size: 40.sp,)),
                ],
              ),
            )
        ),
        Positioned(
            top: 0,
            left: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.of(controller.remoteUid.value.map(
                  (e) => GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: 120.w,
                      height: 120.h,
                      child: (kIsWeb)
                          ? RtcRemoteView.SurfaceView(
                              uid: e,
                              channelId: controller.channel,
                            )
                          : RtcRemoteView.TextureView(
                              uid: e,
                              channelId: controller.channel,
                            ),
                    ),
                  ),
                )),
              ),
            )),

      ],
    );
  }

  _sair(){
    Get.defaultDialog(
        title: "Deseja sair da reunião?",
        titleStyle: TextStyle(color: Colors.red, fontSize: 18.sp),
        middleText: "",
        cancel: OutlinedButton(
          style: OutlinedButton.styleFrom(
              padding:  EdgeInsets.only(
                  left: 25.sp, right: 25.sp, top: 15.sp, bottom: 15.sp),
              backgroundColor: Colors.red
              ),
          onPressed: ()=> Get.back(),
          child: Text("Não", style: TextStyle(fontSize: 18.sp, color: Colors.white),),
        ),
      confirm: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding:  EdgeInsets.only(
              left: 25.sp, right: 25.sp, top: 15.sp, bottom: 15.sp),
          backgroundColor: Colors.blue
          ),
        onPressed: () {
          Get.back();
          controller.leaveChannel();
        },
        child: Text("Sim", style: TextStyle(fontSize: 18.sp, color: Colors.white)),
      ),
    );
  }

  // _layoutError(){
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text("Erro de conexão!", style: TextStyle(fontSize: 18, color: Colors.red)),
  //       Text("Verifique sua internet e tente novamente!", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
  //     ],
  //   );
  // }
}
