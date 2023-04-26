import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../widgets/back_button_widget.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kscaffoldGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.only(left: 15),
            child: BackButtonWidget(),
          ),
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
