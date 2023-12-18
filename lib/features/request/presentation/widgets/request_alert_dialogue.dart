import 'package:dhatnoon/core/services/notification_controller.dart';
import 'package:dhatnoon/features/request/data/request_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestAlertDialogue extends StatelessWidget {
  final String imageUrl;
  final String name;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String requestType;
  final String user2;

  const RequestAlertDialogue({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.requestType,
    required this.startTime,
    required this.endTime,
    required this.user2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirestoreRequest firestoreRequest = FirestoreRequest();
    final NotificationController notificationController =
        Get.put(NotificationController());

    String formattedStartTime = '${startTime.hour}:${startTime.minute}';
    String formattedEndTime = '${endTime.hour}:${endTime.minute}';

    return AlertDialog(
      backgroundColor: const Color(0xFF232D36),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Request Type: $requestType',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            'Start Time: $formattedStartTime',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            'End Time: $formattedEndTime',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () async {
              notificationController.requestPermissions();
              String? uid = FirebaseAuth.instance.currentUser?.uid;
              String? token = await notificationController.getToken();
              await notificationController.saveToken(token!);
              firestoreRequest.insertData(
                startTime: formattedStartTime,
                endTime: formattedEndTime,
                action: requestType,
                user1: uid,
                user2: user2,
                
              );
              String? user2Token =
                  await notificationController.fetchToken(user2);
              String title = 'Title';
              String body = 'This the body of the notification';
              await notificationController.sendNotification(
                  user2Token!, title, body);
            },
            child: Container(
              width: 190,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  "Send Request",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
