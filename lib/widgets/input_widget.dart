import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget(
      {Key? key,
      this.hintText,
      this.errorText,
      this.controller,
      this.hideText = false,
      this.validator,
      this.fillColor,
      this.textColor = Colors.white,
      this.hintColor = Colors.black54,
      this.enabled = true,
      this.textInputAction = TextInputAction.next,
      required this.focusedBorderColor,
      this.onChanged})
      : super(key: key);
  final String? hintText;
  final String? errorText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool hideText;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final Color focusedBorderColor;
  final Color? textColor;
  final TextInputAction textInputAction;
  final Color? hintColor;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        elevation: 12,
        color: Colors.transparent,
        child: TextFormField(
          enabled: enabled,
          style: TextStyle(color: textColor),
          obscureText: hideText,
          controller: controller,
          validator: validator,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            errorText: errorText,
            hintText: hintText,
            hintStyle: TextStyle(color: hintColor),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: focusedBorderColor, width: 2),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            filled: true,
            fillColor: fillColor,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
