import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(String title, String message) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.blue,
    colorText: Colors.white,
    titleText: Text(
      title,
      style: const TextStyle(
        color: Colors.red,
        fontSize: 20,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  );
}
