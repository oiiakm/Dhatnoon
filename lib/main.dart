import 'package:dhatnoon/config/routes/route_config.dart';
import 'package:dhatnoon/config/routes/route_name.dart';
import 'package:dhatnoon/core/Errors/route_error.dart';
import 'package:dhatnoon/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Workmanager().initialize(callbackDispatcher);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ScreenUtil.init(
          context,
          designSize: const Size(428, 926),
        );

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteName.authRouteName,
          unknownRoute: GetPage(
              name: RouteName.errorRouteName, page: () => const ErrorPage()),
          getPages: AppRoutes.pages,
        );
      },
    );
  }
}
