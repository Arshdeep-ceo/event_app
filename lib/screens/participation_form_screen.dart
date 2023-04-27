import 'package:flutter/material.dart';

import '../constants/theme.dart';

class ParticipationFormScreen extends StatelessWidget {
  const ParticipationFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kscaffoldGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Participation Form'),
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
