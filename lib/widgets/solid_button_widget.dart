import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/theme.dart';

class SolidButtonWidget extends StatelessWidget {
  const SolidButtonWidget(
      {Key? key,
      this.onPressed,
      required this.buttonText,
      required this.color,
      this.iconData,
      this.borderRadius = 4,
      this.textColor = Colors.white})
      : super(key: key);

  final Function()? onPressed;
  final String buttonText;
  final Color? textColor;
  final Color? color;
  final IconData? iconData;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius))),
              elevation: MaterialStateProperty.all(12),
              backgroundColor: MaterialStateProperty.all(color)),
          onPressed: onPressed,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  buttonText,
                  style: Get.textTheme.bodyMedium!.copyWith(color: textColor),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  iconData,
                  color: kprimaryColor,
                ),
              ),
            ],
          )),
    );
  }
}
