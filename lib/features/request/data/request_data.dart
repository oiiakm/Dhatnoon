import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhatnoon/features/request/data/models/log_model.dart';

class FirestoreRequest {
  final CollectionReference _activityLogCollection =
      FirebaseFirestore.instance.collection('activity_log');

  final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> insertData({
    required String startTime,
    required String endTime,
    required String action,
    required String? user1,
    required String user2,
  }) async {
    try {
      Map<String, dynamic> dataToInsert = {
        'startTime': startTime,
        'endTime': endTime,
        'action': action,
        'created_at': DateTime.now(),
        'user1': user1,
        'user2': user2,
      };
      await _activityLogCollection.doc('$user1+$user2').set(dataToInsert);

      // for log msgs
      Log logEntry = Log(
        currentTime: "${DateTime.now()}",
        text: "$user1 requested for $action",
      );
      Map<String, dynamic> logJson = logEntry.toJson();

      await _activityLogCollection
          .doc('$user1$user2')
          .collection('logs')
          .add(logJson);

      print('Data inserted successfully');
    } catch (e) {
      print('Error inserting data: $e');
    }
  }
}
