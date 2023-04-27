import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../constants/constants.dart';
import '../constants/theme.dart';
import '../models/event_model.dart';
import '../services/routes.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/event_details_screen_widgets/animated_icon_widget.dart';
import '../widgets/solid_button_widget.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var eventModel = Get.put(EventModel());
    var homeModel = Get.put(HomeModel());
    var eventPictureUrl = homeModel.eventIndex.value;
    var deviceSize = MediaQuery.of(context).size;

    return Container(
      decoration: kscaffoldGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: BackButtonWidget(
              onBack: () {
                Get.back();
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {},
                child: const CircleAvatar(
                  backgroundColor: Colors.white12,
                  child: Center(
                    child: Icon(
                      LineAwesome.share_alt_solid,
                      color: kwhite,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          color: kwhite,
          backgroundColor: Colors.black26,
          onRefresh: () async {
            await eventModel.getEventDetails(homeModel.eventPictureUrl);
          },
          child: Stack(
            children: [
              Card(
                margin: EdgeInsets.zero,
                elevation: 10,
                shadowColor: Colors.white38,
                child: SizedBox(
                  height: deviceSize.height * 0.5,
                  width: double.infinity,
                  child: Hero(
                    tag: const Text('eventImage'),
                    child: CachedNetworkImage(
                      imageUrl: homeModel.eventPictureUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              FutureBuilder<QuerySnapshot>(
                  future: eventModel.getEventDetails(homeModel.eventPictureUrl),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: kprimaryColor,
                        )),
                      );
                    }

                    if (!snapshot.hasData) {
                      // print('No data');
                      return Container();
                    }
                    var eventDateTime =
                        (eventModel.dateOfEvent as Timestamp).toDate();
                    return Stack(
                      // alignment: Alignment.bottomCenter,
                      children: [
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                height: deviceSize.height * 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, top: 10),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      eventModel.eventTitle,
                                      style: Get.textTheme.headlineSmall!
                                          .copyWith(color: kwhite),
                                    ),
                                    Text(
                                      eventModel.eventOrganizer,
                                      style: Get.textTheme.bodyLarge!
                                          .copyWith(color: Colors.white60),
                                    ),
                                    Divider(
                                      endIndent: deviceSize.width * 0.7,
                                      thickness: 2,
                                      color: Colors.white70,
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (eventDateTime.day).toString(),
                                              style: Get.textTheme.bodyLarge!
                                                  .copyWith(color: kwhite),
                                            ),
                                            Text(
                                              months[eventDateTime.month - 1],
                                              style: Get.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.white38),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              weekdays[
                                                  eventDateTime.weekday - 1],
                                              style: Get.textTheme.bodyLarge!
                                                  .copyWith(color: kwhite),
                                            ),
                                            Text(
                                              DateFormat.jm()
                                                  .format(eventDateTime),
                                              style: Get.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.white38),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Description',
                                      style: Get.textTheme.bodyLarge!
                                          .copyWith(color: kwhite),
                                    ),
                                    Text(
                                      eventModel.eventDescription,
                                      // 'asdadsfjlasdflkajsdkl;ajdfkl;ajdkl;ajdfakl;djfklajdfkl;ajdfkl;jadkljadfkl;ajdfkljadfkl;jasdvdfl;kasdjca;ldfadvcvm,xcnvjaxdfadfgnzxcvm,nfkljacv,m.nxzcvjkldfhgm,nxcvjndfgjkladvfmnadfjkgnhafvnafrgjkafndvjklanvfrjkadnfvjk',
                                      style: Get.textTheme.bodyLarge!
                                          .copyWith(color: Colors.white38),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Posted By',
                                      style: Get.textTheme.bodyLarge!
                                          .copyWith(color: kwhite),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        eventModel.openProfile();
                                      },
                                      child: Text(
                                        '- ${eventModel.username}',
                                        style: Get.textTheme.bodyLarge!
                                            .copyWith(color: kprimaryColor),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 100,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              IgnorePointer(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      // stops: [0.2, 0.45, 0.9],
                                      colors: [
                                        Colors.transparent,
                                        Colors.black54,
                                        Colors.black87,
                                        // Color(0xff511911)
                                      ],
                                    ),
                                  ),
                                  width: double.infinity,
                                  height: 150,
                                  // color:
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: CircleAvatar(
                                        radius: 28,
                                        backgroundColor: Colors.white12,
                                        child: AnimatedIconWidget(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: SolidButtonWidget(
                                          onPressed: () {
                                            Get.toNamed(
                                                Routes.participationFormScreen);
                                          },
                                          borderRadius: 30,
                                          buttonText: 'Participate',
                                          color: kprimaryColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
