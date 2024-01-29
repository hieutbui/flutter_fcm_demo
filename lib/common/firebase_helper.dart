import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_fcm_demo/common/notification_helper.dart';
import 'package:flutter_fcm_demo/firebase_options.dart';
import 'dart:io';

class FirebaseHelper {
  static String fcmToken = "";

  static Future<void> initialized() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );

    if (Platform.isAndroid) {
      NotificationHelper.initialized();
    } else if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true
      );
    }

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    await getDeviceTokenToSenNotification();

    FirebaseMessaging.instance.getInitialMessage().then((value) {
      print('FirebaseMessaging.instance.getInitialMessage()');

      if (value != null) {
        print('new notification');
      }
    });

    // App in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('FirebaseMessaging.onMessage.listen()');

      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data);

        NotificationHelper.displayNotification(message);
      }
    });

    // App in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('FirebaseMessaging.onMessageOpenedApp.listen()');

      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data);
      }
    });
  }

  static Future<void> getDeviceTokenToSenNotification() async {
    fcmToken = (await FirebaseMessaging.instance.getToken()).toString();
    print('fcmToken: $fcmToken');
  }
}

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification?.title ?? "");
}
