import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AllUserData {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;

  AllUserData() {
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
  }

  Future<String?> getCurrentUserId() async {
    User? user = _auth.currentUser;

    if (user != null) {
      String userId = user.uid;
      return userId;
    } else {
      return null;
    }
  }

  Future<List<Map<String, String?>>> getAllUsersExceptLoggedIn() async {
    String? loggedInUserId = await getCurrentUserId();

    if (loggedInUserId != null) {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();

      List<Map<String, String?>> userDataList = [];

      for (var user in querySnapshot.docs) {
        if (user.id != loggedInUserId) {
          Map<String, String?> userData = {
            'userName': user['name'] ?? '',
            'imageUrl': user['profile_picture'] ?? '',
            'user2': user['user_id'] ?? '',
            'actionText': 'Send Request',
            
          };

          userDataList.add(userData);
        }
      }

      return userDataList;
    } else {
      return [];
    }
  }
}
