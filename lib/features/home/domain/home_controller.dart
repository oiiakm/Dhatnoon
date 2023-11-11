import 'package:get/get.dart';

class UserInformationController extends GetxController {
  RxString userName = ''.obs;
  RxString imageUrl = ''.obs;
  RxString user2 = ''.obs;
  void userInformation(RxString userName, RxString imageUrl, RxString user2) {
    userName = this.userName;
    imageUrl = this.imageUrl;
    user2 = this.user2;
  }
}
