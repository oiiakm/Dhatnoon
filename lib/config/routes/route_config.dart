import 'package:dhatnoon/config/routes/route_name.dart';
import 'package:dhatnoon/features/auth/presentation/pages/authentication.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(name: RouteName.authRouteName, page: () => const AuthenticationPage()),
  ];
}
