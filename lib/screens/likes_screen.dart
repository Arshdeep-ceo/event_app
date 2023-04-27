import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constants/constants.dart';
import '../constants/theme.dart';
import '../models/home_model.dart';
import '../models/likes_model.dart';
import '../services/routes.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final likesModel = Get.put(LikesModel());
    final homeModel = Get.put(HomeModel());
    var deviceSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff511911),
            Color(0xff140A08),
          ],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: const Text('Liked Events'),
          titleTextStyle: Get.textTheme.titleLarge!.copyWith(color: kwhite),
        ),
        backgroundColor: Colors.transparent,
        body: StreamBuilder<QuerySnapshot>(
            stream: likesModel.getLikedEvents(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('An Error Occured'));
              }
              if (!snapshot.hasData) {
                return const Center(child: Text('No Data'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.data!.docs.isEmpty) {
                return SizedBox(
                    height: deviceSize.height,
                    // width: deviceSize.width * 0.83,
                    child: Center(
                        child: Text(
                      'Nothi\'n Here',
                      style: Get.textTheme.titleLarge!
                          .copyWith(color: Colors.white38),
                    )));
              }
              homeModel.setEventPictureUrl(
                  snapshot.data!.docs[0]['eventPictureUrl']);
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.eventDetailsScreen);
                },
                child: CarouselSlider.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index, realIndex) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: deviceSize.height / 2.3,
                                    width: deviceSize.width * 0.83,
                                    // child: Image.network(
                                    //   event['eventPictureUrl'].toString(),
                                    //   fit: BoxFit.cover,
                                    // ),
                                    child: CachedNetworkImage(
                                      fadeInDuration:
                                          const Duration(milliseconds: 100),
                                      fit: BoxFit.cover,
                                      imageUrl: snapshot
                                          .data!.docs[index]['eventPictureUrl']
                                          .toString(),
                                      // imageUrl: imagesList[index],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          snapshot
                                              .data!.docs[index]['eventTitle']
                                              .toString(),
                                          style: Get.textTheme.labelLarge!
                                              .copyWith(
                                                  color: kwhite, fontSize: 18),
                                        ),
                                        Text(
                                          snapshot
                                              .data!.docs[index]['organizer']
                                              .toString(),
                                          style: Get.textTheme.bodyMedium!
                                              .copyWith(color: Colors.white54),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat.jm().format(
                                          (snapshot.data!.docs[index]
                                                  ['dateOfEvent'] as Timestamp)
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
                    );
                  },
                  options: CarouselOptions(
                    onPageChanged: ((index, reason) {
                      // eventIndex = index;
                      homeModel.setEventPictureUrl(
                          snapshot.data!.docs[index]['eventPictureUrl']);
                    }),
                    viewportFraction: 0.55,
                    height: deviceSize.height,
                    scrollDirection: Axis.vertical,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
