import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/services/image_picker_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../models/profile_model.dart';

class StorageService {
  final storage = FirebaseStorage.instance;
  final imageModel = Get.put(ImagePickerService());
  final profileModel = Get.put(ProfileModel());
  final storageRef = FirebaseStorage.instance.ref();

  var _imageDownloadUrl = '';
  var _imageStoragePath = '';

  get imageDownloadUrl => _imageDownloadUrl;
  get imageStoragePath => _imageStoragePath;

  Future<void> uploadImage() async {
    var imagePath = imageModel.imagePath;
    _imageStoragePath =
        "eventImages/${profileModel.currentUserEmail}${Timestamp.now().microsecondsSinceEpoch}";
    Reference? imagesRef = storageRef.child(_imageStoragePath);

    File file = File(imagePath);
    try {
      await imagesRef.putFile(file);
      _imageDownloadUrl = await imagesRef.getDownloadURL();
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
