import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialized() {
    const AndroidInitializationSettings initializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: initializationSettings
      ),
      onDidReceiveNotificationResponse: (details) {
        print(details.toString());
        print("localBackgroundHandler :");
        print(details.notificationResponseType ==
                NotificationResponseType.selectedNotification
            ? "selectedNotification"
            : "selectedNotificationAction");
        print(details.payload);
      },
      onDidReceiveBackgroundNotificationResponse: localBackgroundHandler
    );
  }

  static void displayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "flutter_fcm_demo",
          "flutter_fcm_demo_channel",
          importance: Importance.max,
          priority: Priority.high
        )
      );

      await flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'] ?? ""
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}

Future<void> localBackgroundHandler(NotificationResponse response) async {
  print(response.toString());
}