import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhatnoon/features/home/domain/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AllUserData {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  UserInformationController controller = Get.put(UserInformationController());
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

    print('Logged In User ID: $loggedInUserId');

    if (loggedInUserId != null) {
      QuerySnapshot usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      print('Number of Users: ${usersSnapshot.docs.length}');

      QuerySnapshot activityLogSnapshot =
          await FirebaseFirestore.instance.collection('activity_log').get();

      List<Map<String, String?>> userDataList = [];

      for (var userDoc in usersSnapshot.docs) {
        String userId = userDoc['user_id'] ?? '';

        if (userId == loggedInUserId) {
          continue;
        }

        QueryDocumentSnapshot<Map<String, dynamic>>? activityLog =
            activityLogSnapshot.docs
                .cast<QueryDocumentSnapshot<Map<String, dynamic>>>()
                .firstWhereOrNull((doc) =>
                    (doc['user1'] == loggedInUserId &&
                        doc['user2'] == userId) ||
                    (doc['user2'] == loggedInUserId && doc['user1'] == userId));

        print('User ID: $userId');
        print('Activity Log Exists: ${activityLog != null}');

        String actionText = 'Send Request';
        String requestText = 'Activity Log';

        if (activityLog != null) {
          bool acceptStatus = activityLog['acceptStatus'] ?? false;
          bool requestStatus = activityLog['requestStatus'] ?? false;
          print('acceptStatus: $acceptStatus, requestStatus: $requestStatus');

          if (!acceptStatus) {
            if (loggedInUserId == activityLog['user2']) {
              actionText = 'Accept';
              requestText = 'Decline';
            } else {
              actionText = 'Pending';
              // Don't update requestText in the database
            }
          } else {
            if (requestStatus) {
              if (loggedInUserId == activityLog['user1']) {
                actionText = 'Fetch Now';
              } else {
                actionText = 'Approved';
              }
            } else {
              actionText = 'Send Request';
              requestText = 'Activity Log';
            }
          }
        } else {
          print('Activity log does not exist for user: $userId');
        }

        Map<String, String?> userData = {
          'userName': userDoc['name'] ?? '',
          'imageUrl': userDoc['profile_picture'] ?? '',
          'user2': userId,
          'actionText': actionText,
          'requestText': requestText,
        };

        print('User Data: $userData');
        userDataList.add(userData);
      }

      return userDataList;
    } else {
      print('Logged In User ID is null');
      return [];
    }
  }

  Future<String?> getImageUrlForCurrentUser(String user1) async {
    final userDoc = await _firestore.collection('users').doc(user1).get();

    if (userDoc.exists) {
      return userDoc.data()?['profile_picture'];
    }
    return null;
  }
}
