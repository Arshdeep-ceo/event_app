import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../services/routes.dart';

class HomeModel extends GetxController {
  final _eventPictureUrl = "".obs;
  var eventTitle = "";
  var eventTime = "";
  var eventPlace = "";
  final eventIndex = 0.obs;

  final _currentDateTime = DateTime.now().obs;

  get currenDateTime => _currentDateTime.value;

  // get eventIndex => _eventIndex.value;

  void setIndex(int currentIndex) {
    eventIndex.value = currentIndex;
  }

  get eventPictureUrl => _eventPictureUrl.value;

  void setEventPictureUrl(String url) {
    _eventPictureUrl.value = url;
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.signinScreen);
  }
}
