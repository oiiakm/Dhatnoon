import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AgoraController extends GetxController {
  RxString token = generateToken().obs;
  Rx<DateTime?> startTime = Rx<DateTime?>(null);
  Rx<DateTime?> endTime = Rx<DateTime?>(null);
  Rx<int?> tokens = Rx<int?>(null);

  static String generateToken() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  Future<void> fetchTokenFromFirestore() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        var userDoc = await FirebaseFirestore.instance
            .collection('user_tokens')
            .doc(user.uid)
            .get();

        var userData = userDoc.data();
        if (userData != null) {
          token(userData['token'] ?? generateToken());
          startTime(userData['startTime']?.toDate());
          endTime(userData['endTime']?.toDate());
          tokens(userData['tokens']);

          print('Token fetched from Firestore: ${userData['token']}');
          print('StartTime: ${userData['startTime']}');
          print('EndTime: ${userData['endTime']}');
          print('Tokens: ${userData['tokens']}');
        }
      }
    } catch (e) {
      print('Error fetching token: $e');
    }
  }

  Future<void> insertTokenToFirestore() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('user_tokens')
            .doc(user.uid)
            .set({
          'token': token.value,
        });

        print('Token inserted into Firestore: ${token.value}');
      }
    } catch (e) {
      print('Error inserting token: $e');
    }
  }
}
