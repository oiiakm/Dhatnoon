import 'package:flutter/material.dart';

class RequestAlertDialogue extends StatelessWidget {
  final String imageUrl;
  final String name;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String requestType;

  const RequestAlertDialogue({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.requestType,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            'Start Time: $startTime',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            'End Time: $endTime',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {},
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
