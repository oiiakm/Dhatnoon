import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRequest {
  final CollectionReference _actionCollection =
      FirebaseFirestore.instance.collection('action');

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

      await _actionCollection.add(dataToInsert);
      print('Data inserted successfully');
    } catch (e) {
      print('Error inserting data: $e');
    }
  }
}
