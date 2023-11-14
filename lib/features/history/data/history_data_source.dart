// history_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryDataSource {
  final FirebaseFirestore firestore;

  HistoryDataSource({required this.firestore});

  Future<List<Map<String, dynamic>>?> getHistoryMessagesFromFirestore() async {
    final querySnapshot = await firestore.collection('activity_log').get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs
          .map((doc) => doc.data())
          .toList();
    }

    return null;
  }
}
