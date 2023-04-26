import 'dart:io';

import 'package:event_app/firebase_options.dart';
import 'package:event_app/services/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final ImagePickerPlatform imagePickerImplementation =
      ImagePickerPlatform.instance;
  if (imagePickerImplementation is ImagePickerAndroid) {
    imagePickerImplementation.useAndroidPhotoPicker = true;
  }
  runApp(const MainApp());
}

String checkUser() {
  // Checking to see if user is already logged in
  if (FirebaseAuth.instance.currentUser != null) {
    return Routes.navbar;
  } else {
    return Routes.signinScreen;
  }
}

void changeRefreshRate() async {
  if (Platform.isAndroid) {
    try {
      await FlutterDisplayMode.setHighRefreshRate();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    changeRefreshRate();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: checkUser(),
      getPages: getPages,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              color: Colors.transparent,
              elevation: 0,
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: Colors.transparent)),
          textTheme:
              GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)),
      builder: EasyLoading.init(),
    );
  }
}
