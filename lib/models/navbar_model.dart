import 'package:get/get.dart';

class NavbarModel extends GetxController {
  final _index = 0.obs;

  get index => _index.value;

  void setIndex(int tappedIndex) {
    _index.value = tappedIndex;
  }
}
