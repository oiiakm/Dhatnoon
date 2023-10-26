import 'package:get/get.dart';

class UserInformationController extends GetxController {
  RxString userName = ''.obs;
  RxString imageUrl = ''.obs;
  void userInformation(RxString userName, RxString imageUrl) {
    userName = this.userName;
    imageUrl = this.imageUrl;
    
  }
}
