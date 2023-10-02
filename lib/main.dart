import 'package:dhatnoon/routes/config.dart';
import 'package:dhatnoon/routes/error.dart';
import 'package:dhatnoon/routes/name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteName.homeRouteName,
          unknownRoute: GetPage(
              name: RouteName.errorRouteName, page: () => const ErrorPage()),
          getPages: AppRoutes.pages,
        );
      },
    );
  }
}
