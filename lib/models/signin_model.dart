import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../constants/theme.dart';
import '../services/routes.dart';

class SignInModel extends GetxController {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  get emailController => _emailController;
  get passwordController => _passwordController;

  void navigateToRegister() {
    Get.offAllNamed(Routes.signupScreen);
  }

  final validateEmail = ((String? value) {
    if (GetUtils.isEmail(value!)) {
      return null;
    } else {
      return 'Enter a valid email';
    }
  });

  final validatePassword = ((String? value) {
    if (GetUtils.isLengthGreaterThan(value!, 1)) {
      return null;
    } else {
      return 'Password isn\'t valid';
    }
  });

  Future<void> signIn() async {
    try {
      EasyLoading.show(
          status: 'Logging in...', maskType: EasyLoadingMaskType.none);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      EasyLoading.dismiss();
      _emailController.clear();
      _passwordController.clear();
      Get.offAllNamed('/navbar');
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Error',
          'No user found for that email.',
          titleText: Text(
            'Error',
            style: Get.textTheme.bodyLarge!.copyWith(color: kprimaryColor),
          ),
          colorText: kwhite,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Error',
          'Wrong email or password',
          titleText: Text(
            'Error',
            style: Get.textTheme.bodyLarge!.copyWith(color: kprimaryColor),
          ),
          colorText: kwhite,
        );
      }
    }
  }
}
