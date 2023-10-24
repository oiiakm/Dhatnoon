import 'package:dhatnoon/config/routes/route_config.dart';
import 'package:dhatnoon/config/routes/route_name.dart';
import 'package:dhatnoon/core/Errors/route_error.dart';
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
          initialRoute: RouteName.initialHomeRouteName,
          unknownRoute: GetPage(
              name: RouteName.errorRouteName, page: () => const ErrorPage()),
          getPages: AppRoutes.pages,
        );
      },
    );
  }
}
