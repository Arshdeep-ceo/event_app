import 'package:event_app/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:icons_animate/icons_animate.dart';
import '../../constants/theme.dart';
import '../../models/event_model.dart';
import '../../models/profile_model.dart';

class AnimatedIconWidget extends StatefulWidget {
  const AnimatedIconWidget({super.key});

  @override
  State<AnimatedIconWidget> createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<AnimatedIconWidget> {
  late AnimateIconController c1;
  final eventModel = Get.put(EventModel());
  final profileModel = Get.put(ProfileModel());

  @override
  void initState() {
    c1 = AnimateIconController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var user in eventModel.likedBy) {
        if (user == profileModel.currentUserEmail) {
          c1.animateToEnd();
        }
      }
    });
  }

  bool onEndIconPress(BuildContext context) {
    return true;
  }

  bool onStartIconPress(BuildContext context) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AnimateIcons(
      duration: const Duration(milliseconds: 350),
      startIconColor: Colors.white,
      endIconColor: kprimaryColor,
      size: 30,
      startIcon: LineAwesome.heart,
      endIcon: LineAwesome.heart_solid,
      controller: c1,
      onStartIconPress: () {
        eventModel.setLike = true;
        eventModel.onEventLiked();
        return onStartIconPress(context);
      },
      onEndIconPress: () {
        eventModel.setLike = false;
        eventModel.onEventLiked();
        return onEndIconPress(context);
      },
    );
  }
}
