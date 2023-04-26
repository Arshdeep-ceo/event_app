import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../constants/theme.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    this.onBack,
    super.key,
  });

  final void Function()? onBack;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onBack,
      child: const CircleAvatar(
        backgroundColor: Colors.black12,
        child: Center(
          child: Icon(
            LineAwesome.arrow_left_solid,
            color: kwhite,
          ),
        ),
      ),
    );
  }
}
