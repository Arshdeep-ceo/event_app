import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/theme.dart';

class UnderlinedInputWidget extends StatelessWidget {
  const UnderlinedInputWidget({
    this.controller,
    this.hintText,
    this.validator,
    super.key,
  });

  final String? Function(String?)? validator;
  final String? hintText;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: Get.textTheme.bodyLarge!.copyWith(color: kwhite),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Get.textTheme.bodyMedium!.copyWith(color: Colors.white70),
        focusColor: kwhite,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kprimaryColor),
        ),
        border: const UnderlineInputBorder(
          // borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: kwhite, width: 1),
        ),
      ),
    );
  }
}
