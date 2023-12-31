import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _configureFirebaseMessaging();
    _configureLocalNotifications();
    requestPermissions();
  }

  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    print('Token: $token');
    return token;
  }
  Future<void> saveToken(String token) async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set(
      {
        'device_token': token,
      },
      SetOptions(merge: true),
    );
  }
  void _configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
      _handleReceivedMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
      _handleNotificationClick(message.data);
    });

    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }

  void _configureLocalNotifications() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> requestPermissions() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'dhatnoon',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      styleInformation: BigTextStyleInformation(''),
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'custom_payload',
    );
  }

  void _handleReceivedMessage(RemoteMessage message) {
    if (message.notification?.body != null) {
      print("Received a notification message: ${message.notification!.body}");
      _receivedMessage();
    } else if (message.data.isNotEmpty) {
      print("Received a data payload: ${message.data}");
      _receivedMessage();
    } else {
      print("Notification body is null, and data payload is empty");
    }
  }

  void _receivedMessage() {
    print("Function executed when a user receives a notification");
  }

  Future<void> sendNotification(String recipientToken, String title, String body) async {
    String serverKey =
        "AAAAhcOatOg:APA91bG7DM4zDrCjWn7Xz8eLlV3wbI9GUoInYa_fCaJH69Yx4wYrnJTvcw1FPCWf8CZSmGQwtK2SztkxteaGPCKmgaSoujj7ai2mf5vAgOvKtkO69D-ErwFRin0quWE01-MAAmzic4ys";

    String fcmEndpoint = "https://fcm.googleapis.com/fcm/send";

    // Construct the data payload
    Map<String, dynamic> data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'message': 'Hello from Device 1',
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

  void _handleNotificationClick(Map<String, dynamic>? data) {
    if (data != null && data['click_action'] == 'FLUTTER_NOTIFICATION_CLICK') {
      print('Handling notification click');
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
