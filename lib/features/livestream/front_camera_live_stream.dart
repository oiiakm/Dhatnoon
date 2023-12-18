import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhatnoon/features/zegocloud/zegocloud_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FrontCameraLiveStreamController extends GetxController {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _configureFirebaseMessaging();
  }

  void _configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");

      _handleReceivedMessage(message);
    });

    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }

  void _handleReceivedMessage(RemoteMessage message) {
    if (message.notification?.body != null) {
      print("Received a notification message: ${message.notification!.body}");
      _receivedMessage(
        message.data['userId'] ?? '',
        int.tryParse(message.data['duration']) ?? 0,
        message.data['liveId'] ?? '',
      );
    } else if (message.data.isNotEmpty) {
      print("Received a data payload: ${message.data}");
      _receivedMessage(
        message.data['userId'] ?? '',
        int.tryParse(message.data['duration']) ?? 0,
        message.data['liveId'] ?? '',
      );
    } else {
      print("Notification body is null, and data payload is empty");
    }
  }

  void _receivedMessage(String user2, int duration, String liveId) {
    print(user2);
    print(duration);
    print(liveId);
    ZegocloudController().startLive(
      liveId,
      isHost: false,
      durationInSeconds: duration,
      user2: user2,
    );
    print("Function executed when a user receives a notification");
  }

  Future<void> sendNotification(
      String recipientToken, String userId, int duration, String liveId) async {
    String serverKey =
        "AAAAhcOatOg:APA91bG7DM4zDrCjWn7Xz8eLlV3wbI9GUoInYa_fCaJH69Yx4wYrnJTvcw1FPCWf8CZSmGQwtK2SztkxteaGPCKmgaSoujj7ai2mf5vAgOvKtkO69D-ErwFRin0quWE01-MAAmzic4ys";

    String fcmEndpoint = "https://fcm.googleapis.com/fcm/send";

    // Construct the data payload
    Map<String, dynamic> data = {
      'userId': userId,
      'duration': duration,
      'liveId': liveId,
    };

    // Construct the request payload
    Map<String, dynamic> payload = {
      'data': data,
      'to': recipientToken,
    };

    await sendFcmRequest(serverKey, fcmEndpoint, payload);
  }

  Future<void> sendFcmRequest(String serverKey, String fcmEndpoint,
      Map<String, dynamic> payload) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    String body = json.encode(payload);

    var response =
        await http.post(Uri.parse(fcmEndpoint), headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Error: ${response.reasonPhrase}');
    }
  }

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    print("Handling background message: $message");
  }

  Future<String?> fetchToken(String userId) async {
    final DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (snapshot.exists) {
      return snapshot['device_token'];
    } else {
      print('User not found in Firestore');
      return null;
    }
  }
}
