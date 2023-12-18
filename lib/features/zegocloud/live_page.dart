import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class CustomHostConfig extends ZegoUIKitPrebuiltLiveStreamingConfig {
  CustomHostConfig({List<IZegoUIKitPlugin>? plugins})
      : super.host(plugins: plugins) {
    turnOnCameraWhenJoining = true;
    turnOnMicrophoneWhenJoining = true;
    useSpeakerWhenJoining = true;

    previewConfig = ZegoLiveStreamingPreviewConfig(
      showPreviewForHost: false,
    );
    inRoomMessageConfig = ZegoInRoomMessageConfig(
      visible: false,
      showAvatar: false,
      showName: false,
    );
  }
}

class CutomAudienceConfig extends ZegoUIKitPrebuiltLiveStreamingConfig {
  CutomAudienceConfig({List<IZegoUIKitPlugin>? plugins})
      : super.audience(plugins: plugins) {
    turnOnCameraWhenJoining = true;
    turnOnMicrophoneWhenJoining = false;
    useSpeakerWhenJoining = false;

    previewConfig = ZegoLiveStreamingPreviewConfig(
      showPreviewForHost: false,
    );
    inRoomMessageConfig = ZegoInRoomMessageConfig(
        visible: false, showAvatar: false, showName: false);
  }
}

// ignore: must_be_immutable
class LivePage extends StatelessWidget {
  LivePage(
      {super.key,
      required this.liveID,
      required this.isHost,
      required this.userId});

  final bool isHost;
  String liveID;
  String userId;
  @override
  Widget build(BuildContext context) {
    List<IZegoUIKitPlugin>? yourPluginsList = [];

    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: 25763206,
        appSign:
            'c1e45600db33c7358d03a860277faa4c4ae6c846e8d036aa003261cd7a23539a',
        userID: userId,
        userName: 'user$userId',
        liveID: liveID,
        config: isHost
            ? CustomHostConfig(plugins: yourPluginsList)
            : CutomAudienceConfig(plugins: yourPluginsList),
      ),
    );
  }
}
