import 'package:event_app/screens/explore_screen.dart';
import 'package:event_app/screens/home_screen.dart';
import 'package:event_app/screens/likes_screen.dart';
import 'package:event_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:icons_plus/icons_plus.dart';

import 'constants/theme.dart';
import 'models/navbar_model.dart';

class NavbarScreen extends StatelessWidget {
  const NavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navModel = Get.put(NavbarModel());
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Obx(
        () => GNav(
          color: Colors.white,
          backgroundColor: Colors.black26,
          activeColor: kprimaryColor,
          onTabChange: (tappedIndex) => navModel.setIndex(tappedIndex),
          selectedIndex: navModel.index,
          duration: const Duration(milliseconds: 150),
          tabs: const [
            GButton(
              icon: LineAwesome.home_solid,
              text: 'Home',
            ),
            GButton(
              icon: LineAwesome.heart,
              text: 'Likes',
            ),
            GButton(
              icon: LineAwesome.search_solid,
              text: 'Search',
            ),
            GButton(
              icon: LineAwesome.user,
              text: 'Profile',
            )
          ],
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: navModel.index,
          children: const [
            HomeScreen(),
            LikesScreen(),
            ExploreScreen(),
            ProfileScreen()
          ],
        ),
      ),
    );
  }
}
