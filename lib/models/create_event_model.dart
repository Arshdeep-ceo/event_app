import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/theme.dart';
import '../services/image_picker_service.dart';

class CreateEventModel extends GetxController {
  final _visibility = false.obs;
  var imageModel = Get.put(ImagePickerService());

  final _selectedTime = TimeOfDay.now().obs;
  final _selectedDate = DateTime.now().obs;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController organizerController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _eventTitle = '';
  final _eventOrganizer = '';
  final _eventDescription = '';

  get eventTitle => _eventTitle;
  get eventOrganizer => _eventOrganizer;
  get eventDescription => _eventDescription;

  TimeOfDay get selectedTime => _selectedTime.value;
  DateTime get selectedDate => _selectedDate.value;

  get visibility => _visibility.value;

  void toggleVisibility() {
    _visibility.value = !_visibility.value;
    // Future.delayed(const Duration(seconds: 2), () {
    //   _visibility.value = false;
    // });
  }

  final validateTitle = ((value) {
    if (GetUtils.isNull(value) || value == '') {
      return 'Title can\'t be left empty';
    } else {
      return null;
    }
  });
  final validateOrganizer = ((value) {
    if (GetUtils.isNull(value) || value == '') {
      return 'Organizer can\'t be left empty';
    } else {
      return null;
    }
  });
  final validateDescription = ((value) {
    if (GetUtils.isNull(value) || value == '') {
      return 'Description can\'t be left empty';
    } else {
      return null;
    }
  });

  void pickDate(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    _selectedDate.value = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
      builder: (context, child) {
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
          child: child!,
        );
      },
    ))!;
  }

  void pickTime(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    _selectedTime.value = (await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) => Theme(
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
              child: child!,
            )))!;
  }

  Future<void> createEvent() async {
    // imageModel.pickImageFromGallery();
  }
}
