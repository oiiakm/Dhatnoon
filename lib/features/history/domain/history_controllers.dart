import 'package:dhatnoon/features/history/data/history_data_source.dart';
import 'package:dhatnoon/features/history/data/history_repository.dart';
import 'package:dhatnoon/features/history/domain/history_message_entity.dart';

import 'package:get/get.dart';

class HistoryController extends GetxController {
  RxList<HistoryMessage> historyMessages = <HistoryMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHistoryMessages();
  }

  void fetchHistoryMessages() {
    final historyRepository = HistoryRepository(HistoryDataSource());
    final historyMessageData = historyRepository.getDummyHistoryMessages();

    final historyMessagesList = historyMessageData.map((data) {
      return HistoryMessage(
        text: data['text'],
        isUserMessage: data['isUserMessage'],
        timestamp: data['timestamp'],
        userAvatarUrl: data['userAvatarUrl'],
      );
    }).toList();

    historyMessages.assignAll(historyMessagesList);
  }
}
