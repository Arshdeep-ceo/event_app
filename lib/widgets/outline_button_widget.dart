import 'package:flutter/material.dart';

class OutlinedButtonWidget extends StatelessWidget {
  const OutlinedButtonWidget(
      {Key? key, required this.buttonText, this.onPressed, this.color})
      : super(key: key);

  final String buttonText;
  final void Function()? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: OutlinedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(width: 2, color: color!),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}
