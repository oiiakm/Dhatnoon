import 'package:dhatnoon/features/history/domain/history_message_entity.dart';
import 'package:flutter/material.dart';

class HistoryMessageWidget extends StatelessWidget {
  final HistoryMessage message;

  const HistoryMessageWidget({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          message.isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isUserMessage)
              CircleAvatar(
                backgroundImage: NetworkImage(message.userAvatarUrl),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: message.isUserMessage
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: message.isUserMessage ? Colors.blue : Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      message.text,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.timestamp,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            if (message.isUserMessage)
              CircleAvatar(
                backgroundImage: NetworkImage(message.userAvatarUrl),
              ),
          ],
        ),
      ),
    );
  }
}
