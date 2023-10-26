import 'package:dhatnoon/common/snackbar.dart';
import 'package:dhatnoon/features/request/domain/request_controller.dart';
import 'package:dhatnoon/features/request/presentation/widgets/request_alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestWidget extends StatefulWidget {
  final String name;
  final Icon icon;
  final RequestController controller;

  const RequestWidget({
    super.key,
    required this.name,
    required this.icon,
    required this.controller,
  });

  @override
  State<RequestWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<RequestWidget> {
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final userName = arguments['userName'];
    final imageUrl = arguments['imageUrl'];
    return GestureDetector(
      onTap: () {
        if (widget.controller.startTime.value != null &&
            widget.controller.endTime.value != null) {
          print(widget.name);
          print(widget.controller.startTime.value!);
          print(widget.controller.endTime.value!);

          showRequestDialog(
              context,
              imageUrl,
              userName,
              widget.name,
              widget.controller.startTime.value!,
              widget.controller.endTime.value!);
        } else {
          showSnackbar("Select Time", "Start and end times are not selected.");
        }
      },
      child: Container(
        width: 345,
        height: 54,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 100, 94, 94),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Row(
              children: [
                Icon(
                  widget.icon.icon,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  _showTimePicker(context, true);
                },
                child: Obx(() => Text(
                      widget.controller.startTime.value != null
                          ? 'Start Time: ${widget.controller.startTime.value!.format(context)}'
                          : 'Select Start Time',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    )),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  _showTimePicker(context, false);
                },
                child: Obx(() => Text(
                      widget.controller.endTime.value != null
                          ? 'End Time: ${widget.controller.endTime.value!.format(context)}'
                          : 'Select End Time',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTimePicker(BuildContext context, bool isStartTime) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? widget.controller.startTime.value ?? TimeOfDay.now()
          : widget.controller.endTime.value ?? TimeOfDay.now(),
    );

    if (selectedTime != null) {
      if (isStartTime) {
        widget.controller.startTime(selectedTime);
      } else {
        widget.controller.endTime(selectedTime);
      }
    }
  }

  showRequestDialog(BuildContext context, String imageUrl, String userName,
      String requestType, TimeOfDay startTime, TimeOfDay endTime) {
    showDialog(
      context: context,
      builder: (context) {
        return RequestAlertDialogue(
          imageUrl: imageUrl,
          name: userName,
          requestType: requestType,
          startTime: startTime,
          endTime: endTime,
        );
      },
    );
  }
}
