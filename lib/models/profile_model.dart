import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileModel extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var currentUserEmail = FirebaseAuth.instance.currentUser!.email;

  final _name = "".obs;
  final _department = "".obs;
  final _profilePictureUrl = "".obs;
  final _bio = "".obs;
  final _username = "".obs;

  get name => _name.value;
  get profilePictureUrl => _profilePictureUrl.value;
  get bio => _bio.value;
  get username => _username.value;
  get department => _department.value;

  Future<QuerySnapshot> getUserDetails() async {
    final userDetails = await firestore
        .collection('users')
        .where('email', isEqualTo: currentUserEmail)
        .get();
    var user = userDetails.docs.single;
    _name.value = user['name'];
    _username.value = user['username'];
    _profilePictureUrl.value = user['profilePicture'];
    _bio.value = user['bio'];
    _department.value = user['department'];
    return userDetails;
  }
}
