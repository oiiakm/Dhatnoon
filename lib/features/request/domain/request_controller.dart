import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  final startTime = Rx<TimeOfDay?>(null);
  final endTime = Rx<TimeOfDay?>(null);
}
