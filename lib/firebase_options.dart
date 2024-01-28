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
    apiKey: 'AIzaSyCF2TsxOTZ3T5AB8Bt8eAeabJsGyJiA3FU',
    appId: '1:694747704856:web:c765e332e3c0acc8f75d6d',
    messagingSenderId: '694747704856',
    projectId: 'fcm-demo-662cb',
    authDomain: 'fcm-demo-662cb.firebaseapp.com',
    storageBucket: 'fcm-demo-662cb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCr1UkSg_6VptJNJRVa7f0tdMdZHfvEWS8',
    appId: '1:694747704856:android:f5127e26340d3a4af75d6d',
    messagingSenderId: '694747704856',
    projectId: 'fcm-demo-662cb',
    storageBucket: 'fcm-demo-662cb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJr_vQ5gkIcrIh0VOqqyaQUfKDnoUXSo4',
    appId: '1:694747704856:ios:15361ea79ff49bc1f75d6d',
    messagingSenderId: '694747704856',
    projectId: 'fcm-demo-662cb',
    storageBucket: 'fcm-demo-662cb.appspot.com',
    iosBundleId: 'com.example.flutterFcmDemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJr_vQ5gkIcrIh0VOqqyaQUfKDnoUXSo4',
    appId: '1:694747704856:ios:547247f15f780437f75d6d',
    messagingSenderId: '694747704856',
    projectId: 'fcm-demo-662cb',
    storageBucket: 'fcm-demo-662cb.appspot.com',
    iosBundleId: 'com.example.flutterFcmDemo.RunnerTests',
  );
}