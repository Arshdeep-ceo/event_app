import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/models/profile_model.dart';
import 'package:get/get.dart';

class LikesModel extends GetxController {
  final _isLiked = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _profileModel = Get.put(ProfileModel());
  final _selectedEventImageUrl = ''.obs;

  get selectedEventImageUrl => _selectedEventImageUrl;

  Stream<QuerySnapshot> getLikedEvents() {
    final docRef = firestore
        .collection("events")
        .where('likedBy', arrayContainsAny: [_profileModel.currentUserEmail])
        .orderBy('dateOfEvent')
        .snapshots();
    // events = docRef.elementAt(eventIndex);
    return docRef;
  }
}
