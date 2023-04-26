import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';

import '../constants/theme.dart';
import '../models/home_model.dart';
import '../services/routes.dart';
import '../widgets/home_screen/home_weekdays_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var homeModel = Get.put(HomeModel());
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
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: const Icon(FontAwesome.gear),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                homeModel.signOut();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(LineAwesome.bell),
              ),
            ),
          ],
          title: Text(
            'Events',
            style: GoogleFonts.satisfy(color: kwhite, fontSize: 22),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 70.0),
          child: SpeedDialFabWidget(
            secondaryElevation: 20,
            primaryBackgroundColor: Colors.white24,
            primaryForegroundColor: kwhite,
            secondaryBackgroundColor: Colors.white12,
            secondaryForegroundColor: kwhite,
            secondaryIconsList: const [
              LineAwesome.arrow_right_solid,
            ],
            secondaryIconsText: const [
              "Create an event",
            ],
            secondaryIconsOnPress: [
              () => {Get.toNamed(Routes.createEventScreen)},
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        body: HomeWeekdaysWidget(),
      ),
    );
  }
}
