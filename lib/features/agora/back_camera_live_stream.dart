import 'package:agora_uikit/agora_uikit.dart';
import 'package:agora_uikit/controllers/rtc_buttons.dart';
import 'package:camera/camera.dart';
import 'package:dhatnoon/features/agora/agora_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackSendStream extends StatelessWidget {
  const BackSendStream({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackSendStreamIntermediate();
  }
}

class BackSendStreamIntermediate extends StatefulWidget {
  const BackSendStreamIntermediate({Key? key}) : super(key: key);

  @override
  State<BackSendStreamIntermediate> createState() =>
      _BackSendStreamIntermediateState();
}

class _BackSendStreamIntermediateState
    extends State<BackSendStreamIntermediate> {
  late final AgoraClient _client;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final AgoraController agoraController = Get.put(AgoraController());

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = startEverything();
    setClient();
    initAgora();
  }

  Future<void> startEverything() async {
    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back);

    _controller = CameraController(
      backCamera,
      ResolutionPreset.medium,
    );

    return _controller.initialize();
  }

  void setClient() async {
    _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: "183043269e90464d9e23e5348828dd2c",
        channelName: "test",
        tempToken: agoraController.token.value,
      ),
    );
  }

  void initAgora() async {
    await _client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      switchCamera(sessionController: _client.sessionController);
    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Back camera streaming',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              AgoraVideoViewer(
                client: _client,
                layoutType: Layout.floating,
                enableHostControls: true,
              ),
              AgoraVideoButtons(
                client: _client,
                autoHideButtons: false,
                enabledButtons: const [BuiltInButtons.callEnd],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackReceiveStream extends StatelessWidget {
  final String token;

  const BackReceiveStream({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackReceiveStreamIntermediate(token: token);
  }
}

class BackReceiveStreamIntermediate extends StatefulWidget {
  const BackReceiveStreamIntermediate({
    Key? key,
    required this.token,
  }) : super(key: key);

  final String token;

  @override
  State<BackReceiveStreamIntermediate> createState() =>
      _BackReceiveStreamIntermediateState();
}

class _BackReceiveStreamIntermediateState
    extends State<BackReceiveStreamIntermediate> {
  late final AgoraClient _client;

  @override
  void initState() {
    super.initState();
    setClient();
    initAgora();
  }

  void setClient() async {
    _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: "183043269e90464d9e23e5348828dd2c",
        channelName: "test",
        tempToken: widget.token,
      ),
    );
  }

  void initAgora() async {
    await _client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          Visibility(
            visible: true,
            maintainState: true,
            child: Scaffold(
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
            ),
          ),
        ],
      ),
    );
  }
}

class BackCameraLiveStream extends StatelessWidget {
  final AgoraController agoraController = Get.put(AgoraController());

  BackCameraLiveStream({super.key});

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
                Get.to(() => const BackSendStream());
              },
              child: const Text('Start Back Stream'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(() =>
                    BackReceiveStream(token: agoraController.token.value));
              },
              child: const Text('Join Back Stream'),
            ),
          ],
        ),
      ),
    );
  }
}
