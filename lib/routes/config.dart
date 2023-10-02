import 'package:dhatnoon/pages/home.dart';
import 'package:dhatnoon/routes/name.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(name: RouteName.homeRouteName, page: () => const HomePage()),
  ];
}
