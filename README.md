# flutter_fcm_demo

A Flutter project for FCM configuration demo.

## Configuration steps

1. Create a project in Firebase console
2. Using Firebase CLI to connect to the created project
3. Add needed flutter packages:
  - [firebase_core](https://pub.dev/packages/firebase_core)
  - [firebase_messaging](https://pub.dev/packages/firebase_messaging)
  - [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
4. Enable `Cloud Messaging` API in google cloud console:
  ***For IOS: Also update APN certificate in Firebase console***
5. Create a class for firebase handling
   ```dart
    class FirebaseHelper {
      // Store token
      static String fcmToken = "";

      // Initialization
      static Future<void> initialized() async {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform
        );

        if (Platform.isAndroid) {
          // Initialize notification handling
          NotificationHelper.initialized();
        } else if (Platform.isIOS) {
          // Request notifications permission
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

        // Handling when app in background
        FirebaseMessaging.onBackgroundMessage(backgroundHandler);

        // Get fcm token
        await getDeviceTokenToSenNotification();

        // Check if the app opened from click on notification or not
        FirebaseMessaging.instance.getInitialMessage().then((value) {
          print('FirebaseMessaging.instance.getInitialMessage()');

          if (value != null) {
            print('new notification');
          }
        });

        // Handling received message when app in foreground
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          print('FirebaseMessaging.onMessage.listen()');

          if (message.notification != null) {
            print(message.notification!.title);
            print(message.notification!.body);
            print(message.data);

            // Show notification on status bar
            NotificationHelper.displayNotification(message);
          }
        });

        // Handling received message when app in background
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          print('FirebaseMessaging.onMessageOpenedApp.listen()');

          if (message.notification != null) {
            print(message.notification!.title);
            print(message.notification!.body);
            print(message.data);
          }
        });
      }

      // Get fcm token
      static Future<void> getDeviceTokenToSenNotification() async {
        fcmToken = (await FirebaseMessaging.instance.getToken()).toString();
        print('fcmToken: $fcmToken');
      }
    }

    // background handler function
    Future<void> backgroundHandler(RemoteMessage message) async {
      print(message.data.toString());
      print(message.notification?.title ?? "");
    }
   ```
7. Create a class for notification handling
  ```dart
  class NotificationHelper {
    // Create instance of flutter_local_notification
    static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Initialization
    static void initialized() {
      // Initialize for android with default icon @mipmap/ic_launcher
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

    // Show notification
    static void displayNotification(RemoteMessage message) async {
      try {
        final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        const notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "channel_id",
            "channel_name",
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

  // Background handler function
  Future<void> localBackgroundHandler(NotificationResponse response) async {
    print(response.toString());
  }
  ```
8. Initialize Firebase in main:
  ```dart
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FirebaseHelper.initialized();
    runApp(const MyApp());
  }
  ```

### Testing
- Get an authorization key from Firebase console for sending messages
- Send a request from server with body:
  ```json
  {
    "registration_ids": [
        "<fcmToken>"
    ],
    "notification": {
        "title": "test",
        "body": "Text message",
        "android_channel_id": "channel_id",
        "sound": true
    },
    "data": {
        "_id": 1
    }
  }
  ```

#### Demo


https://github.com/hieutbui/flutter_fcm_demo/assets/80142234/c1085cfc-01b9-4d3d-8e11-75b0123e4c0f


