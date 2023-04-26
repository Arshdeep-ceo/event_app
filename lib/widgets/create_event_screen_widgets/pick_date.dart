import 'package:flutter/material.dart';

import '../../constants/theme.dart';

class PickDateWidget extends StatelessWidget {
  const PickDateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(
          primary: kprimaryColor2,
          onPrimary: Colors.white,
          onSurface: Colors.black,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: kprimaryColor, // button text color
          ),
        ),
      ),
      child: DatePickerDialog(
          helpText: 'Select Event Date',
          initialEntryMode: DatePickerEntryMode.input,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2023, 12)),
    );
  }
}
