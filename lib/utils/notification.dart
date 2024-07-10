import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  '24fsc geotrack',
  '24fsc geotrack',
  description: '24fsc geotrack app notification',
  importance: Importance.max,
  playSound: true,
  enableLights: true,
  enableVibration: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationplugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Handling a background message : ${message.messageId}");
}

class FirebaseNotifcation {
  initialize() async {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyD-yyKSEHCxTnszn2wASaPklTxoCU0U5oQ',
          appId: '1:734068954892:android:dd7d9d64ad3260cd0e5b29',
          messagingSenderId: '734068954892',
          projectId: 'fscgeotrack-9bf44',)
    );
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    debugPrint(await FirebaseMessaging.instance.getToken());

    var intializationSettingsAndroid =
    const AndroidInitializationSettings('mipmap/launcher_icon');

    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    var initializationSettings = InitializationSettings(
        android: intializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationplugin.initialize(initializationSettings);

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await flutterLocalNotificationplugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(message.toString());
      notify(message);
    });
  }

  notify(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      AndroidNotificationDetails notificationDetails =
      AndroidNotificationDetails(channel.id, channel.name,
          channelDescription: channel.description,
          styleInformation:
          BigTextStyleInformation(notification.body ?? ''),
          importance: Importance.max,
          priority: Priority.high,
          groupKey: channel.id);
      NotificationDetails notificationDetailsPlatformSpefics =
      NotificationDetails(android: notificationDetails);
      flutterLocalNotificationplugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          notificationDetailsPlatformSpefics);
    }

    List<ActiveNotification>? activeNotifications =
    await flutterLocalNotificationplugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();
    if (activeNotifications != null && activeNotifications.isNotEmpty) {
      List<String> lines =
      activeNotifications.map((e) => e.title.toString()).toList();
      InboxStyleInformation inboxStyleInformation = InboxStyleInformation(lines,
          contentTitle: "${activeNotifications.length - 1} messages",
          summaryText: "${activeNotifications.length - 1} messages");
      AndroidNotificationDetails groupNotificationDetails =
      AndroidNotificationDetails(channel.id, channel.name,
          channelDescription: channel.description,
          styleInformation: inboxStyleInformation,
          setAsGroupSummary: true,
          groupKey: channel.id);

      NotificationDetails groupNotificationDetailsPlatformSpefics =
      NotificationDetails(android: groupNotificationDetails);
      await flutterLocalNotificationplugin.show(
          0, '', '', groupNotificationDetailsPlatformSpefics);
    }
  }
}
