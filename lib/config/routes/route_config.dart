import 'package:dhatnoon/config/routes/route_name.dart';
import 'package:dhatnoon/features/auth/presentation/pages/authentication.dart';
import 'package:dhatnoon/features/home/presentation/pages/home_page.dart';
import 'package:dhatnoon/features/home/presentation/pages/initial_home_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    // GetPage(name: RouteName.authRouteName, page: () => const AuthenticationPage()),
    GetPage(
        name: RouteName.initialHomeRouteName,
        page: () => const InitialHomePage()),
    GetPage(name: RouteName.homeRouteName, page: () => HomePage()),
  ];
}
