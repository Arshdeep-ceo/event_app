import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/models/home_model.dart';
import 'package:event_app/models/profile_model.dart';
import 'package:event_app/services/image_picker_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';

import '../services/routes.dart';

class EventModel extends GetxController {
  var homeModel = Get.put(HomeModel());
  var imageModel = Get.put(ImagePickerService());
  final _profileModel = Get.put(ProfileModel());
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
  final likedBy = [].obs;
  final _isLiked = false.obs;

  get isLiked => _isLiked.value;
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

  set setLike(bool like) => _isLiked.value = like;

  set setEventDay(int day) => _eventDay.value = day;
  set setEventWeekday(int date) => _eventWeekday.value = date;

  Future<QuerySnapshot> getEventDetails(String eventPictureUrl) async {
    final docRef = await firestore
        .collection("events")
        .where('eventPictureUrl', isEqualTo: eventPictureUrl)
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
    likedBy.value = eventDetails['likedBy'];

    return docRef;
  }

  // void currentWeek() {
  //   String date = DateFormat.yMMMMEEEEd().format(DateTime.now());
  //   print(date);
  //   // return 0;
  // }

  List<int> monthsList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  void openProfile() {
    if (username == _profileModel.username) {
      print('object');
      Get.toNamed(Routes.profileScreen);
    } else {
      // _profileModel.getUserDetails();
    }
  }

  Stream<QuerySnapshot> getEvents(int monthsIndex) {
    // currentWeek();
    if (monthsIndex == 11) {
      final docRef = firestore
          .collection("events")
          .where('dateOfEvent',
              isGreaterThanOrEqualTo: DateTime(2023, monthsList[monthsIndex]))
          .where('dateOfEvent', isLessThan: DateTime(2024))
          .orderBy('dateOfEvent')
          .snapshots();
      return docRef;
    } else {
      final docRef = firestore
          .collection("events")
          .where('dateOfEvent',
              isGreaterThanOrEqualTo: DateTime(2023, monthsList[monthsIndex]))
          .where('dateOfEvent',
              isLessThan: DateTime(2023, monthsList[monthsIndex + 1]))
          .orderBy('dateOfEvent')
          .snapshots();
      // events = docRef.elementAt(eventIndex);
      return docRef;
    }
  }

  void onEventLiked() async {
    if (_isLiked.value == true) {
      try {
        var docRef = await firestore
            .collection('events')
            .where('eventPictureUrl', isEqualTo: homeModel.eventPictureUrl)
            .limit(1)
            .get()
            .then((snapshot) => snapshot.docs[0].reference);

        var batch = firestore.batch();
        batch.update(docRef, {
          'likedBy': FieldValue.arrayUnion([_profileModel.currentUserEmail])
        });
        await batch.commit();
        Get.snackbar('Success', 'Event added to likes');
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      try {
        var docRef = await firestore
            .collection('events')
            .where('eventPictureUrl', isEqualTo: homeModel.eventPictureUrl)
            .limit(1)
            .get()
            .then((snapshot) => snapshot.docs[0].reference);

        var batch = firestore.batch();
        batch.update(docRef, {
          'likedBy': FieldValue.arrayRemove([_profileModel.currentUserEmail])
        });
        await batch.commit();
        Get.snackbar('Success', 'Event removed from likes',
            snackStyle: SnackStyle.GROUNDED);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
}
