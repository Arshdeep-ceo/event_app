import 'package:get/get.dart';
// import 'package:image_picker_android/image_picker_android.dart';
// import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService extends GetxController {
  final ImagePicker picker = ImagePicker();

  final _imagePath = "".obs;

  String get imagePath => _imagePath.value;

  void resetImagePath() {
    _imagePath.value = "";
  }

  void pickImageFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    _imagePath.value = image!.path;
  }

  void pickImageFromCamera() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    _imagePath.value = image!.path;
  }
}
