import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhatnoon/features/zegocloud/live_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZegocloudController extends GetxController {
  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> _subscription;

  @override
  void onInit() {
    getDocumentData();
    super.onInit();
  }

  Future<Map<String, dynamic>> getDocumentData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore
                .instance
                .collection('activity_log')
                .doc(
                    'HlrHpgwWErbWyNM8TFOKvKVBMtl2+VS5RVk0JVhS1T0GvpYHok5jnkmn2')
                .get();

        if (snapshot.exists) {
          return snapshot.data() ?? {};
        } else {
          throw Exception("Document not found");
        }
      } catch (e) {
        print("Error retrieving document: $e");
        throw Exception("Error retrieving document");
      }
    } else {
      throw Exception("User not logged in");
    }
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }

  void startLive(String liveID,
      {required bool isHost, required int durationInSeconds,required String user2}) {
    Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => LivePage(liveID: liveID, isHost: isHost,userId: user2,),
      ),
    );

    Future.delayed(Duration(seconds: durationInSeconds), () {
      Navigator.pop(Get.context!);
    });
  }

  void watchLive(String liveID,
      {required bool isHost, required int durationInSeconds,required String user1}) {
    Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => LivePage(liveID: liveID, isHost: isHost, userId: user1,),
      ),
    );

    Future.delayed(Duration(seconds: durationInSeconds), () {
      Navigator.pop(Get.context!);
    });
  }
}
