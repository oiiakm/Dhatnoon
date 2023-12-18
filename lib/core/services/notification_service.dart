// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class NotificationService {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   void requestNotificationPermissions() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print('User granted provisional permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }

//   Future<String?> getToken() async {
//     String? token = await messaging.getToken();
//     print('Token: $token');
//     return token;
//   }

//   void isTokenRefresh() {
//     messaging.onTokenRefresh.listen((event) {
//       event.toString();
//       print('Token Refreshed');
//     });
//   }

//   Future<void> saveToken(String token) async {
//     User? user = FirebaseAuth.instance.currentUser;
//     await FirebaseFirestore.instance.collection('users').doc(user!.uid).set(
//       {
//         'device_token': token,
//       },
//       SetOptions(merge: true),
//     );
//   }
// }
