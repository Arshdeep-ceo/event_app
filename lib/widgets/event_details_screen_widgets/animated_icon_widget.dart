import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:icons_animate/icons_animate.dart';

import '../../constants/theme.dart';

class AnimatedIconWidget extends StatefulWidget {
  const AnimatedIconWidget({super.key});

  @override
  State<AnimatedIconWidget> createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<AnimatedIconWidget> {
  late AnimationController _favoriteController;
  late AnimateIconController c1;
  // final AnimateIconController

  @override
  void initState() {
    // _favoriteController = AnimationController(
    //     vsync: this,
    //     duration: const Duration(
    //       milliseconds: 450,
    //     ));
    c1 = AnimateIconController();
    super.initState();
  }

  bool onEndIconPress(BuildContext context) {
    return true;
  }

  bool onStartIconPress(BuildContext context) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // return IconButton(
    //   splashRadius: 28,
    //   iconSize: 20,
    //   onPressed: () {
    //     if (_favoriteController.status == AnimationStatus.dismissed) {
    //       _favoriteController.reset();
    //       _favoriteController.animateTo(0.6);
    //     } else {
    //       _favoriteController.reverse();
    //     }
    //   },
    //   icon: Lottie.asset(
    //     Icons8.heart_color,
    //     controller: _favoriteController,
    //     delegates: LottieDelegates(
    //       values: [
    //         ValueDelegate.color(
    //           const ['Shape Layer 1', 'Rectangle', 'Fill 1'],
    //           value: Colors.red,
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return AnimateIcons(
      duration: const Duration(milliseconds: 350),
      startIconColor: Colors.white,
      endIconColor: kprimaryColor,
      size: 30,
      startIcon: LineAwesome.heart,
      endIcon: LineAwesome.heart_solid,
      controller: c1,
      onStartIconPress: () => onStartIconPress(context),
      onEndIconPress: () => onEndIconPress(context),
    );
  }
}
