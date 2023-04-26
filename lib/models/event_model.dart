import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/models/home_model.dart';
import 'package:event_app/services/image_picker_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constants/constants.dart';

class EventModel extends GetxController {
  var homeModel = Get.put(HomeModel());
  var imageModel = Get.put(ImagePickerService());
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _dateOfEvent = Timestamp(0, 0).obs;
  final _eventPostedDate = Timestamp(0, 0).obs;
  final _eventEmail = "".obs;
  final _eventDescription = "".obs;
  final _eventPictureUrl = "".obs;
  final _eventThumbnailUrl = "".obs;
  final _eventTitle = "".obs;
  final _eventOrganizer = "".obs;
  final _username = "".obs;

  get dateOfEvent => _dateOfEvent.value;
  get eventPostedDate => _eventPostedDate.value;
  get eventEmail => _eventEmail.value;
  get eventDescription => _eventDescription.value;
  get eventPictureUrl => _eventPictureUrl.value;
  get eventThumbnailUrl => _eventThumbnailUrl.value;
  get eventTitle => _eventTitle.value;
  get eventOrganizer => _eventOrganizer.value;
  get username => _username.value;

  final _eventDay = 1.obs;
  final _eventWeekday = 1.obs;

  int get eventDay => _eventDay.value;
  int get eventWeekday => _eventWeekday.value;

  set setEventDay(int day) => _eventDay.value = day;
  set setEventWeekday(int date) => _eventWeekday.value = date;

  Future<QuerySnapshot> getEventDetails() async {
    final docRef = await firestore
        .collection("events")
        .where('eventPictureUrl', isEqualTo: homeModel.eventPictureUrl)
        .get();
    var eventDetails = docRef.docs.single;

    _eventTitle.value = eventDetails['eventTitle'];
    _eventPictureUrl.value = eventDetails['eventPictureUrl'];
    _eventEmail.value = eventDetails['email'];
    _eventOrganizer.value = eventDetails['organizer'];
    _username.value = eventDetails['username'];
    _dateOfEvent.value = eventDetails['dateOfEvent'];
    _eventPostedDate.value = eventDetails['datePosted'];
    _eventDescription.value = eventDetails['eventDescription'];

    return docRef;
  }

  void currentWeek() {
    String date = DateFormat.yMMMMEEEEd().format(DateTime.now());
    print(date);
    // return 0;
  }

  List<int> monthsList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  Stream<QuerySnapshot> getEvents(int monthsIndex) {
    // currentWeek();
    if (monthsIndex == 11) {
      final docRef = firestore
          .collection("events")
          .where('dateOfEvent',
              isGreaterThanOrEqualTo: DateTime(2021, monthsList[monthsIndex]))
          .where('dateOfEvent', isLessThan: DateTime(2024))
          .orderBy('dateOfEvent')
          .snapshots();
      return docRef;
    } else {
      final docRef = firestore
          .collection("events")
          .where('dateOfEvent',
              isGreaterThanOrEqualTo: DateTime(2021, monthsList[monthsIndex]))
          .where('dateOfEvent',
              isLessThan: DateTime(2021, monthsList[monthsIndex + 1]))
          .orderBy('dateOfEvent')
          .snapshots();
      // events = docRef.elementAt(eventIndex);
      return docRef;
    }
  }
}
