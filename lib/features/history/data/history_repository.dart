import 'package:dhatnoon/features/history/data/history_data_source.dart';
import 'package:dhatnoon/features/history/domain/history_message_entity.dart';

class HistoryRepository {
  final HistoryDataSource historyDataSource;

  HistoryRepository(this.historyDataSource);

  Future<List<HistoryMessage>> getHistoryMessages() async {
    // Replace this with actual data retrieval
    // final historyMessagesData = await historyDataSource.getHistoryMessagesFromFirestore();
    final historyMessagesData = getDummyHistoryMessages();

    return historyMessagesData
        .map((data) => HistoryMessage.fromMap(data))
        .toList();
  }

  List<Map<String, dynamic>> getDummyHistoryMessages() {
    return [
      {
        'text': 'Hi there!',
        'isUserMessage': true,
        'timestamp': '1:30 PM, 30/09/2023',
        'userAvatarUrl':
            'https://upload.wikimedia.org/wikipedia/commons/9/99/Elon_Musk_Colorado_2022_%28cropped2%29.jpg',
      },
      {
        'text': 'Hello!',
        'isUserMessage': false,
        'timestamp': '1:32 PM, 30/09/2023',
        'userAvatarUrl':
            'https://upload.wikimedia.org/wikipedia/commons/6/6c/Priyanka-chopra-gesf-2018-7565.jpg'
      },
    ];
  }
}