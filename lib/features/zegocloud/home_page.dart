import 'dart:async';
import 'package:dhatnoon/features/zegocloud/live_page.dart';
import 'package:flutter/material.dart';

class LiveHomePage extends StatelessWidget {
  const LiveHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String liveID = 'user1user2';
    var duration = 10;
    var isFetch = true;
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Start a live'),
                onPressed: () {
                  _startLive(context, liveID,
                      isHost: true, durationInSeconds: duration);
                },
              ),
              ElevatedButton(
                child: const Text('Watch a live'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LivePage(liveID: liveID, isHost: false),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startLive(BuildContext context, String liveID,
      {required bool isHost, required int durationInSeconds}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivePage(liveID: liveID, isHost: isHost),
      ),
    );

    Future.delayed(Duration(seconds: durationInSeconds), () {
      Navigator.pop(context);
    });
  }
}
 