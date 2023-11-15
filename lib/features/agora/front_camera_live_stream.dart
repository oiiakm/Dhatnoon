import 'package:agora_uikit/agora_uikit.dart';
import 'package:dhatnoon/features/agora/agora_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FrontSendStream extends StatelessWidget {
  const FrontSendStream({super.key});

  @override
  Widget build(BuildContext context) {
    return FrontSendStreamIntermediate();
  }
}

class FrontSendStreamIntermediate extends StatelessWidget {
  final AgoraController agoraController = Get.find();
  late final AgoraClient _client;

  FrontSendStreamIntermediate({super.key}) {
    _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: "183043269e90464d9e23e5348828dd2c",
        channelName: "test",
        tempToken: agoraController.token.value,
      ),
    );
    initAgora();
  }

  void initAgora() async {
    await _client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Front camera streaming',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: _client,
              layoutType: Layout.floating,
              enableHostControls: true,
            ),
            AgoraVideoButtons(
              client: _client,
              autoHideButtons: false,
              enabledButtons: const [BuiltInButtons.callEnd],
            )
          ],
        ),
      ),
    );
  }
}

class FrontReceiveStream extends StatelessWidget {
  final String token;

  const FrontReceiveStream({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Front camera streaming',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: AgoraClient(
                agoraConnectionData: AgoraConnectionData(
                  appId: "183043269e90464d9e23e5348828dd2c",
                  channelName: "test",
                  tempToken: token,
                ),
              ),
              layoutType: Layout.floating,
              enableHostControls: false,
            ),
          ],
        ),
      ),
    );
  }
}

class FrontCameraLiveStreaming extends StatelessWidget {
  final AgoraController agoraController = Get.put(AgoraController());

  FrontCameraLiveStreaming({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to My App!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const FrontSendStream());
              },
              child: const Text('Start Live Streaming'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(() =>
                    FrontReceiveStream(token: agoraController.token.value));
              },
              child: const Text('Join Live Stream'),
            ),
          ],
        ),
      ),
    );
  }
}
