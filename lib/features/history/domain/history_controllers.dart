import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhatnoon/features/history/data/history_data_source.dart';
import 'package:dhatnoon/features/history/data/history_repository.dart';
import 'package:dhatnoon/features/history/domain/history_message_entity.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  RxList<HistoryMessage> historyMessages = <HistoryMessage>[].obs;

  Future<void> fetchHistoryMessages(String user1, String user2,String image1,String image2) async {
    final historyRepository = HistoryRepository(
        HistoryDataSource(firestore: FirebaseFirestore.instance));
    final historyMessagesList =
        await historyRepository.getHistoryMessages(user1, user2,image1,image2);

    historyMessages.assignAll(historyMessagesList);
  }
}
