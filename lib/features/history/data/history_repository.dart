import 'package:dhatnoon/features/history/data/history_data_source.dart';
import 'package:dhatnoon/features/history/domain/history_message_entity.dart';

class HistoryRepository {
  final HistoryDataSource historyDataSource;

  HistoryRepository(this.historyDataSource);

  Future<List<HistoryMessage>> getHistoryMessages(
      String user1, String user2 ,String user1ImageUrl,String user2ImageUrl) async {
    print('Fetching history messages for $user1 and $user2');

    final logsQuerySnapshot = await historyDataSource.firestore
        .collection('activity_log')
        .doc('$user1$user2')
        .collection('logs')
        .get();

    if (logsQuerySnapshot.docs.isNotEmpty) {
      print('Received ${logsQuerySnapshot.docs.length} history messages');

      final historyMessages = logsQuerySnapshot.docs
          .map((doc) => HistoryMessage.fromMap(doc.data(), user1,user1ImageUrl, user2ImageUrl))
          .toList();

      // Print the messages for verification
      historyMessages.forEach((message) {
        print(
            'Message: ${message.text}, isUserMessage: ${message.isUserMessage} time: ${message.timestamp}');
      });

      return historyMessages;
    }

    print('No history messages found');
    print('$user1$user2');
    return [];
  }
  
}
