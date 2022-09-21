import 'dart:math';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController{
  RxList<int> remoteUid = [0].obs;
  RxBool isJoined = false.obs;
  RtcEngine? _engine;
  RxString layoutInicio = "inicio".obs;
  // const appId = "<-- Insert App Id -->";
  // const token = "<-- Insert Token -->";
  // const channel = "<-- Insert Channel Name -->";
  static const appId = "9a1cffd1463447df8074c4ea2fd65148";
  final String channel = "123";
  static const token = "007eJxTYDgsYS8peL99xd9n7WrqkW1rGs0LNklOXrg2+8r013caQq4pMFgmGianpaUYmpgZm5iYp6RZGJibJJukJhqlpZiZGppYvJDWTs7I1UluTrjKzMgAgSA+M4OhkTEDAwB7+yBq";

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onInit() {
    super.onInit();
    remoteUid.value = [];
  }
  @override
  void dispose() {
    super.dispose();
    _engine?.destroy();
  }


  Future<void> initAgora() async {
    if (GetPlatform.isAndroid) {
      await [Permission.microphone, Permission.camera].request();
    }
    layoutInicio.value = "exibirVideo";
    _engine ??= await RtcEngine.createWithContext(RtcEngineContext(appId));
    _addListeners();
    await _engine!.enableVideo();
    await _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine!.setClientRole(ClientRole.Broadcaster);
    await _engine!.joinChannel(token, channel, null, _gerarUid());
  }

  _addListeners() {
    _engine!.setEventHandler(
      RtcEngineEventHandler(
        warning: (warningCode) {
          print("Analise Warning: $warningCode");
        },
        error: (errorCode) {
          print("Analise Error: $errorCode");
        },
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print("local user $uid joined");
          isJoined.value = true;
        },
        userJoined: (int uid, int elapsed) {
          print("remote user $uid joined");
          remoteUid.add(uid);
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          remoteUid.removeWhere((element) => element == uid);
        },
        leaveChannel: (stats) {
          isJoined.value = false;
          remoteUid.clear();
          print("Analise leaveChannel:  ${stats.toJson()}" );
        },
      ),
    );
  }
  
  _gerarUid(){
    return Random(1).nextInt(10);
  }


  leaveChannel() async {
    if(_engine != null){
      await _engine!.leaveChannel();
    }
    layoutInicio.value = "inicio";
  }

  // statusMicrofone(bool microfoneLigado){
  //   if(microfoneLigado){
  //     microfoneLigado = false;
  //   }else{
  //     microfoneLigado = true;
  //   }
  // }
}