import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/models/authentication_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../services/routes.dart';

class SignUpModel extends GetxController {
  final TextEditingController _sponsorEditingController =
      TextEditingController();
  final TextEditingController _fullNameEditingController =
      TextEditingController();
  final TextEditingController _usernameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  final authenticationModel = Get.put(AuthenticationModel());

  get sponsorEditingController => _sponsorEditingController;
  get usernameEditingController => _usernameEditingController;
  get emailEditingController => _emailEditingController;
  get passwordEditingController => _passwordEditingController;
  get fullNameEditingController => _fullNameEditingController;

  bool usernameAlreadyTaken = false;

  String? validateEmail(value) {
    if (GetUtils.isEmail(value!)) {
      return null;
    } else {
      return 'Enter a valid email';
    }
  }

  String? validatePassword(String? value) {
    if (GetUtils.isLengthGreaterThan(value!, 5)) {
      return null;
    } else if (value.isEmpty) {
      return 'Password field can\'t be left empty';
    } else {
      return 'Password must be greater than 6 characters';
    }
  }

  String? validateFullName(value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return 'Can\'t be left empty';
    } else {
      return null;
    }
  }

  String? validateUsername(value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return 'Can\'t be left empty';
    } else if (usernameAlreadyTaken == true) {
      return 'Username already Taken';
    } else {
      return null;
    }
  }

  String? validateSponsor(value) {
    if (GetUtils.isNullOrBlank(value)!) {
      return 'Can\'t be left empty';
    } else {
      return null;
    }
  }

  Future<void> navigateToLogin() async {
    await Get.offAllNamed(Routes.signinScreen);
  }

  Future<void> checkUsername() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: _usernameEditingController.text)
          .get()
          .then((value) {
        if (value.size > 0) {
          usernameAlreadyTaken = true;
        } else {
          usernameAlreadyTaken = false;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signUp() async {
    try {
      EasyLoading.show(status: 'Signing Up...');
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailEditingController.text,
        password: _passwordEditingController.text,
      );
      await authenticationModel.addUser(
        email: _emailEditingController.text,
        password: _passwordEditingController.text,
        name: _fullNameEditingController.text,
        username: _usernameEditingController.text,
      );
      EasyLoading.dismiss();
      await Get.offAllNamed(Routes.navbar);
      _emailEditingController.clear();
      _passwordEditingController.clear();
      _fullNameEditingController.clear();
      _usernameEditingController.clear();
      _sponsorEditingController.clear();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      if (e.code == 'weak-password') {
        Get.showSnackbar(const GetSnackBar(
          message: 'Password is too weak.',
          // backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ));
      } else if (e.code == 'email-already-in-use') {
        Get.showSnackbar(const GetSnackBar(
          message: 'Email is already in use.',
          // backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      EasyLoading.dismiss();
    }
  }
}
