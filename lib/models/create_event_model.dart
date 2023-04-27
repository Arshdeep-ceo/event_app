import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/constants/constants.dart';
import 'package:event_app/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../constants/theme.dart';
import '../services/image_picker_service.dart';
import '../services/storage_service.dart';

class CreateEventModel extends GetxController {
  final _visibility = false.obs;
  var imageModel = Get.put(ImagePickerService());
  var storageModel = Get.put(StorageService());
  var profileModel = Get.put(ProfileModel());

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _selectedTime = const TimeOfDay(hour: 1, minute: 1).obs;
  final _selectedDate = DateTime(2021).obs;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController organizerController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _eventTitle = '';
  final _eventOrganizer = '';
  final _eventDescription = '';

  // get eventTitle => _eventTitle;
  // get eventOrganizer => _eventOrganizer;
  // get eventDescription => _eventDescription;

  TimeOfDay get selectedTime => _selectedTime.value;
  DateTime get selectedDate => _selectedDate.value.add(Duration(
      hours: _selectedTime.value.hour, minutes: _selectedTime.value.minute));

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
    EasyLoading.show(status: 'Creating Event');
    // print(selectedDate);
    var eventDocName =
        "${profileModel.currentUserEmail}${selectedDate.microsecondsSinceEpoch}";
    await storageModel.uploadImage();

    await firestore
        .collection('events')
        .doc(eventDocName)
        .set({
          'eventTitle': titleController.text.toString(),
          'eventDescription': descriptionController.text,
          'organizer': organizerController.text,
          'username': profileModel.username,
          'email': profileModel.currentUserEmail,
          'datePosted': DateTime.now(),
          'dateOfEvent': selectedDate,
          'eventWeek': weekdays[(_selectedDate.value).weekday - 1],
          'eventPictureUrl': storageModel.imageDownloadUrl,
          'imageStoragePath': storageModel.imageStoragePath,
          'likedBy': [],
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    EasyLoading.dismiss();
    EasyLoading.showSuccess('Event is Live');
    imageModel.resetImagePath();
    Get.back();
  }
}
