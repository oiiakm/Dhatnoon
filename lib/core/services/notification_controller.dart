import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  Future<void> sendPushNotification(
      String? token, String title, String body) async {
    const String serverKey =
        'AAAAhcOatOg:APA91bG7DM4zDrCjWn7Xz8eLlV3wbI9GUoInYa_fCaJH69Yx4wYrnJTvcw1FPCWf8CZSmGQwtK2SztkxteaGPCKmgaSoujj7ai2mf5vAgOvKtkO69D-ErwFRin0quWE01-MAAmzic4ys';
    const String projectId = 'dhatnoon-b2bf5';
    const String fcmUrl =
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';

    print("Token: $token");
    print("Title: $title");
    print("Body: $body");

    try {
      await http.post(
        Uri.parse(fcmUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverKey',
        },
        body: jsonEncode({
          'message': {
            'token': token,
            'notification': {
              'body': body,
              'title': title,
            },
            'data': {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
            },
            'priority': 'high',
          },
        }),
      );
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}
