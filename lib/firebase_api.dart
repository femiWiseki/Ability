import 'dart:convert';

import 'package:ability/globals.dart';
import 'package:ability/src/features/agent/home/presentation/providers/home_providers.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/agent_home/agt_notifications.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
  print(message.data);

  print("Handling a background message: ${message.messageId}");
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // navigate to the Notification screen
  navigatorKey.currentState!
      .push(CupertinoPageRoute(builder: (context) => const AgtNotifications()));
}

class FirebaseApi {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'High important channel',
    'High important notification',
    description: 'This notifications are important',
    importance: Importance.defaultImportance,
  );
  final _localNotification = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // navigate to the Notification screen
    navigatorKey.currentState!.push(
        CupertinoPageRoute(builder: (context) => const AgtNotifications()));
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotification.initialize(
      settings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        // navigate to the Notification screen
        navigatorKey.currentState!.push(
            CupertinoPageRoute(builder: (context) => const AgtNotifications()));
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    final platform = _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
          )),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future<void> initNotifications() async {
    await messaging.requestPermission();
    final fCMToken = await messaging.getToken();
    print(fCMToken);
    await AgentPreference.setFCMToken(fCMToken ?? '');
    initPushNotifications();
    initLocalNotifications();
  }
}
