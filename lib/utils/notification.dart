import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/custom_dialog.dart';

class LocalNotification {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationDetails androidSettings = AndroidNotificationDetails(
    '24FSC',
    '24FSC Important',
    channelDescription: 'DBZeus 24FSC app notification',
  );



  initializer() {
    var initializationsSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    var initializationSettings = InitializationSettings(
        android: initializationsSettingsAndroid,
        iOS: initializationSettingsIOS);
    flutterLocalNotificationPlugin.initialize(initializationSettings);
  }

  showNotification(RepeatInterval interva ,String latlang) async {
    var notificationDetails = NotificationDetails(
      android: androidSettings,
    );
    await flutterLocalNotificationPlugin.show(1, "24FSC", latlang,  notificationDetails);
  }
}


notificationPermission()async{
  var status = await Permission.notification.request();
  if (status == PermissionStatus.granted) {
    // Permission granted
  } else if (status == PermissionStatus.denied || status == PermissionStatus.restricted) {
    // Permission denied or restricted, show an explanation
    showCustomAlertDialog(title: 'Notification Permission',
      content: 'Please enable notification access in app settings.',
      confirm: "OK",
      onTabConfirm: ()=> Get.back(),
    );

  } else if (status == PermissionStatus.permanentlyDenied) {
    // Permission permanently denied, open app settings

    showCustomAlertDialog(title: 'Notification Permission',
        content: 'Please enable notification access in app settings.',
        confirm: "Settings",
        onTabConfirm: ()=> openAppSettings(),
        isDismissable: false
    );

  }

}