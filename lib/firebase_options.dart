// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBqBxfF-xLn0BRX_3XW_GcFkCAsqVQv-oI',
    appId: '1:519939462674:web:a9c7d1a9b420b4374aeacb',
    messagingSenderId: '519939462674',
    projectId: 'event-app-d6105',
    authDomain: 'event-app-d6105.firebaseapp.com',
    storageBucket: 'event-app-d6105.appspot.com',
    measurementId: 'G-6B78YLE60W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8Sk4c2gNpyOanTJCvwDcuGqNjw0FD4e8',
    appId: '1:519939462674:android:1b6c5c4e6e8dd9974aeacb',
    messagingSenderId: '519939462674',
    projectId: 'event-app-d6105',
    storageBucket: 'event-app-d6105.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBn7PBdob0NglU5VbRuGvCoVNDGScTB9XE',
    appId: '1:519939462674:ios:c9313c67c61cd29e4aeacb',
    messagingSenderId: '519939462674',
    projectId: 'event-app-d6105',
    storageBucket: 'event-app-d6105.appspot.com',
    iosClientId: '519939462674-6hr2vmb09b5vcnumrn63bim0slkkkj0a.apps.googleusercontent.com',
    iosBundleId: 'com.example.eventApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBn7PBdob0NglU5VbRuGvCoVNDGScTB9XE',
    appId: '1:519939462674:ios:c9313c67c61cd29e4aeacb',
    messagingSenderId: '519939462674',
    projectId: 'event-app-d6105',
    storageBucket: 'event-app-d6105.appspot.com',
    iosClientId: '519939462674-6hr2vmb09b5vcnumrn63bim0slkkkj0a.apps.googleusercontent.com',
    iosBundleId: 'com.example.eventApp',
  );
}
