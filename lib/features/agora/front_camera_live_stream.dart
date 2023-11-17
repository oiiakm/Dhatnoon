import 'package:agora_uikit/agora_uikit.dart';
import 'package:dhatnoon/features/agora/agora_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    try {
      checkAndStartOrEndLiveStream(task);
    } catch (e, stackTrace) {
      print('Error executing task: $e\n$stackTrace');
    }
    return Future.value(true);
  });
}

void checkAndStartOrEndLiveStream(String task) {
  DateTime currentTime = DateTime.now();

  // Set your desired start and end times here
  int startHour = 13;
  int startMinute = 5;
  int endHour = 13;
  int endMinute = 7;

  DateTime startTime = DateTime(
    currentTime.year,
    currentTime.month,
    currentTime.day,
    startHour,
    startMinute,
  );

  DateTime endTime = DateTime(
    currentTime.year,
    currentTime.month,
    currentTime.day,
    endHour,
    endMinute,
  );

  if (currentTime.isAfter(startTime) && currentTime.isBefore(endTime)) {
    if (task == 'startTask') {
      _startLiveStream();
    } else if (task == 'endTask') {
      _endLiveStream();
    }
  }
}

void _startLiveStream() {
  Get.to(() => const FrontSendStream());
}

void _endLiveStream() {
  // Add logic to end the live stream, e.g., navigate back or perform cleanup.
}

void startAndEndTasks(
    int startHour, int startMinute, int endHour, int endMinute) {
  Workmanager().registerPeriodicTask(
    "startTask",
    "startTask",
    initialDelay: Duration(
      hours: startHour - DateTime.now().hour,
      minutes: startMinute - DateTime.now().minute,
    ),
    frequency: Duration(milliseconds: 1), // Run once a day
  );

  Workmanager().registerPeriodicTask(
    "endTask",
    "endTask",
    initialDelay: Duration(
      hours: endHour - DateTime.now().hour,
      minutes: endMinute - DateTime.now().minute,
    ),
    frequency: Duration(milliseconds: 1), // Run once a day
  );
}

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
