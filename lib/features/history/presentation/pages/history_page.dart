import 'package:dhatnoon/features/history/domain/history_controllers.dart';
import 'package:dhatnoon/features/history/presentation/widgets/history_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HistoryController historyController = Get.put(HistoryController());

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF232D36),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF232D36),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Request History'),
      ),
      body: Obx(() {
        final historyMessages = historyController.historyMessages;
        

        if (historyMessages.isEmpty) {
          return const Center(child: Text('No request history available.'));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: historyMessages.length,
                itemBuilder: (context, index) {
                  final message = historyMessages[index];
                  return HistoryMessageWidget(
                    message: message,
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
