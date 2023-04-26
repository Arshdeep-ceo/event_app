import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/services/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationModel extends GetxController {
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed(Routes.signinScreen);
  }

  Future<void> addUser(
      {required String email,
      required String name,
      required String password,
      required String username}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add({
      "email": email,
      "name": name,
      "password": password,
      "username": username,
    }).catchError(
      (error) => Get.showSnackbar(
        GetSnackBar(message: error.toString()),
      ),
    );
  }

  // Future<void> updateUserDetails(
  //     {required String email,
  //     required String name,
  //     required String password,
  //     required String username}) async {
  //   users = FirebaseFirestore.instance
  //       .collection('users')
  //       .where('email', isEqualTo: _auth.currentUser!.email);
  //   await users.update({
  //     "email": email,
  //     "name": name,
  //     "password": password,
  //     "username": username,
  //   }).catchError(
  //     (error) => Get.showSnackbar(
  //       GetSnackBar(message: error.toString()),
  //     ),
  //   );
  // }
}
