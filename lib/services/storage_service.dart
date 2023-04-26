import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final storage = FirebaseStorage.instance;

  void getPicture() {
    storage.ref();
  }
}
