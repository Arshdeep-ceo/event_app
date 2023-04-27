import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../constants/constants.dart';
import '../../constants/theme.dart';
import '../../models/home_model.dart';
import '../../screens/event_details_screen.dart';
import 'package:intl/intl.dart';

class HomeWeekdaysWidget extends StatelessWidget {
  const HomeWeekdaysWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var homeModel = Get.put(HomeModel());
    var eventModel = Get.put(EventModel());
    PageController pageController =
        PageController(initialPage: DateTime.now().month - 1);
    CarouselController carouselController = CarouselController();
    var eventStream =
        FirebaseFirestore.instance.collection('events').snapshots();
    var deviceSize = MediaQuery.of(context).size;
    var snapshotV;

    return RawScrollbar(
      crossAxisMargin: 10,
      thumbColor: Colors.white38,
      controller: pageController,
      interactive: true,
      thickness: 20,
      radius: const Radius.circular(20),
      child: PageView.builder(
        controller: pageController,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 12,
        onPageChanged: (index) {
          // pageIndex = index;
          // homeModel.setEventPictureUrl(
          //                     snapshotV.data!.docs[index]['eventPictureUrl']);
          eventModel.setEventWeekday =
              (snapshotV.data!.docs[0]['dateOfEvent'] as Timestamp)
                  .toDate()
                  .weekday;
          eventModel.setEventDay =
              (snapshotV.data!.docs[0]['dateOfEvent'] as Timestamp)
                  .toDate()
                  .day;
        },
        itemBuilder: ((context, pageIndex) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 35, right: 35, bottom: 15, top: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      months[pageIndex],
                      style: Get.textTheme.headlineMedium!
                          .copyWith(color: kwhite, fontWeight: FontWeight.bold),
                    ),
                    Obx(() {
                      return Text(
                        "${weekdays[eventModel.eventWeekday - 1]} ${eventModel.eventDay}",
                        style: Get.textTheme.bodyMedium!
                            .copyWith(color: Colors.white60),
                      );
                    }),
                    // Text(
                    //   'Tuesday',
                    //   style: Get.textTheme.bodyMedium!
                    //       .copyWith(color: Colors.white60),
                    // ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => const EventDetailsScreen(),
                  );
                },
                child: StreamBuilder<QuerySnapshot>(
                    stream: eventModel.getEvents(pageIndex),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('An Error Occured');
                      }
                      if (!snapshot.hasData) {
                        return const Text('No Data');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.data!.docs.isEmpty) {
                        return SizedBox(
                            height: deviceSize.height * .64,
                            // width: deviceSize.width * 0.83,
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: Text(
                                'No Events Yet',
                                style: Get.textTheme.titleLarge!
                                    .copyWith(color: Colors.white38),
                              ),
                            )));
                      }

                      snapshotV = snapshot;

                      homeModel.setEventPictureUrl(
                          snapshot.data!.docs[0]['eventPictureUrl']);

                      return CarouselSlider.builder(
                        carouselController: carouselController,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index, realIndex) {
                          // var event = snapshot.data!.docs[index];
                          // var eventDateTime =
                          //     (event['dateOfEvent'] as Timestamp).toDate().day;
                          // print(DateFormat.yMMMMEEEEd().format(
                          //     (event['dateOfEvent'] as Timestamp).toDate()));

                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Card(
                                      color: Colors.white24,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: kborderRadius),
                                      elevation: 20,
                                      shadowColor: Colors.black54,
                                      child: ClipRRect(
                                        borderRadius: kborderRadius,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            SizedBox(
                                              height: deviceSize.height / 2.3,
                                              width: deviceSize.width * 0.83,
                                              // child: Image.network(
                                              //   event['eventPictureUrl'].toString(),
                                              //   fit: BoxFit.cover,
                                              // ),
                                              child: Hero(
                                                tag: Text('eventImage'),
                                                child: CachedNetworkImage(
                                                  fadeInDuration:
                                                      const Duration(
                                                          milliseconds: 100),
                                                  fit: BoxFit.cover,
                                                  imageUrl: snapshot
                                                      .data!
                                                      .docs[index]
                                                          ['eventPictureUrl']
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                            ['eventTitle']
                                                        .toString(),
                                                    style: Get
                                                        .textTheme.labelLarge!
                                                        .copyWith(
                                                            color: kwhite,
                                                            fontSize: 18),
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                            ['organizer']
                                                        .toString(),
                                                    style: Get
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            color:
                                                                Colors.white54),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: CircleAvatar(
                                          radius: 28,
                                          backgroundColor: Colors.black45,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                DateFormat.jm().format(
                                                    (snapshot.data!.docs[index]
                                                                ['dateOfEvent']
                                                            as Timestamp)
                                                        .toDate()),
                                                style: Get.textTheme.bodySmall!
                                                    .copyWith(color: kwhite),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        options: CarouselOptions(
                          onPageChanged: ((index, reason) {
                            // eventIndex = index;
                            homeModel.setEventPictureUrl(
                                snapshot.data!.docs[index]['eventPictureUrl']);
                            eventModel.setEventWeekday = (snapshot.data!
                                    .docs[index]['dateOfEvent'] as Timestamp)
                                .toDate()
                                .weekday;
                            eventModel.setEventDay = (snapshot.data!.docs[index]
                                    ['dateOfEvent'] as Timestamp)
                                .toDate()
                                .day;
                          }),
                          height: deviceSize.height / 1.5,
                          viewportFraction: 0.9,
                          initialPage: 0,
                          reverse: false,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                          scrollDirection: Axis.horizontal,
                        ),
                      );
                    }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
