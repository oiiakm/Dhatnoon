import 'package:dhatnoon/features/history/domain/history_controllers.dart';
import 'package:dhatnoon/features/home/data/all_user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInformationWidget extends StatelessWidget {
  final BuildContext context;
  final String userName;
  final String imageUrl;
  final String actionText;
  final String user2;

  UserInformationWidget({
    Key? key,
    required this.userName,
    required this.imageUrl,
    required this.actionText,
    required this.context,
    required this.user2,
  }) : super(key: key);

  final HistoryController historyController = Get.put(HistoryController());
  final AllUserData _allUserData = AllUserData();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD9D9D9),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(imageUrl),
              ),
              const SizedBox(
                width: 10,
                height: 2,
              ),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const Spacer(),
          _buildButton(actionText),
          const SizedBox(width: 10),
          _buildButton('Activity Log'),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    Color buttonColor = Colors.black;
    if (text.startsWith("Send")) {
      buttonColor = const Color(0xFF232D36);
    } else if (text.startsWith("Hurray")) {
      buttonColor = const Color(0xFF013A00);
    } else if (text.startsWith("Requested")) {
      buttonColor = const Color(0xE08A7C00);
    } else if (text.startsWith("Declined")) {
      buttonColor = const Color(0xFF4B0000);
    } else if (text.startsWith("Still")) {
      buttonColor = const Color(0xE04B4B4B);
    } else if (text.startsWith("Approved")) {
      buttonColor = const Color(0xFF013403);
    }

    return GestureDetector(
      onTap: () async {
        if (text.startsWith('Send Request')) {
          Get.toNamed(
            '/requestWheel',
            arguments: {
              'userName': userName,
              'imageUrl': imageUrl,
              'user2': user2,
            },
          );
        } else if (text.startsWith('Activity')) {
          String? user1 = FirebaseAuth.instance.currentUser?.uid;
          String? image1 = await _allUserData.getImageUrlForCurrentUser(user1!);
          await historyController.fetchHistoryMessages(
              user1, user2, image1!, imageUrl);

          print(user1);
          print(user2);
          Get.toNamed(
            '/history',
          );
        }
      },
      child: Container(
        width: 190,
        height: 50,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: SizedBox(
            width: 190,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1.0,
                  softWrap: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
