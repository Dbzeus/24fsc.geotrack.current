/*
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geotrack24fsc/utils/session.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../apis/api_call.dart';
import 'location_permission.dart';

void initForegroundTask() {
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'foreground_service',
      channelName: 'Foreground Service Notification',
      channelDescription: 'This notification appears when the foreground service is running.',
      channelImportance: NotificationChannelImportance.LOW,
      priority: NotificationPriority.LOW,
      iconData: const NotificationIconData(
        resType: ResourceType.mipmap,
        resPrefix: ResourcePrefix.ic,
        name: 'launcher',
      ),
      // buttons: [
      //   const NotificationButton(id: 'sendButton', text: 'Send'),
      //   const NotificationButton(id: 'testButton', text: 'Test'),
      // ],
    ),
    iosNotificationOptions: const IOSNotificationOptions(
      showNotification: true,
      playSound: false,
    ),

    foregroundTaskOptions: const ForegroundTaskOptions(
      interval: 1000,
      isOnceEvent: false,
      autoRunOnBoot: true,
      allowWakeLock: true,
      allowWifiLock: true,
    ),
  );
  // FlutterForegroundTask.startService(
  //   notificationTitle: 'Foreground Task Running',
  //   notificationText: 'Tap to return to the app',
  //   callback: startCallback,
  // );

}


// The callback function should always be a top-level function.
@pragma('vm:entry-point')
void startCallback() {
  debugPrint("Callback Fore Service ");
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(FirstTaskHandler());
}

class FirstTaskHandler extends TaskHandler {
  SendPort? _sendPort;

  // Called when the task is started.
  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {
    _sendPort = sendPort;

    debugPrint("Callback service start");
    //var res = await backgroundLocationService("4");
   await callLocationServices();

    //sendPort?.send("startTask");

  }

  // Called every [interval] milliseconds in [ForegroundTaskOptions].
  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    debugPrint("Callback REpeat event");
    //callLocationServices();
    // Send data to the main isolate.
    //sendPort?.send(timestamp);
  }

  // Called when the notification button on the Android platform is pressed.
  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) async {

  }

  callLocationServices() async {
    DateFormat timeFormat = DateFormat("HH:mm:ss");

    DateTime currentTime =
    timeFormat.parse(DateTime.now().toString().split(" ")[1].split(".")[0]);
    DateTime logoutTime = timeFormat.parse("20:00:00");

    debugPrint("ABCD1");

    if (currentTime.isAfter(logoutTime)) {
      debugPrint("ABCD2");
      await GetStorage.init();
      final box = GetStorage();
      debugPrint(
          "ABCD Session:${box.read(Session.isRunnerCancelling).toString()}");
      if (box.read(Session.isRunnerCancelling) != null) {
        if (box.read(Session.isRunnerCancelling) == true) {
          debugPrint("ABCD3");
          var res = await backgroundLocationService("4"); //for
          _sendPort?.send(res);
          if (res == true) {
            debugPrint("ABCD4");
            box.write(Session.isRunnerCancelling, false);
            FlutterForegroundTask.stopService();
          }
        }
      } *//*

*/
/*else {
      // debugPrint("ABCD Foreground");
      serviceInstance.invoke("setAsForeground");
    }*//*
*/
/*

    } else {
      debugPrint("ABCD5");
      backgroundLocationService("3");
    }
    FlutterForegroundTask.updateService();
    //serviceInstance.invoke('update');
  }

  backgroundLocationService(String status) async {
    var position = await getCurrentLocationForBackgroundFetch();
    final box = GetStorage();
    if (box.read(Session.userid) != null ||
        box.read(Session.version) != null ||
        box.read(Session.deviceID) != null) {
      debugPrint("ABCD Status id: ${status.toString()}");
      debugPrint("Position Latlang: ${position.toString()}");
      var params = {
        "UserID": box.read(Session.userid).toString(),
        "StatusID": status,
        "Latitude": '${position!.latitude}',
        "Longitude": '${position.longitude}',
        "MVersion": box.read(Session.version).toString() ?? "",
        "Battery": "",
        "DeviceID": box.read(Session.deviceID).toString() ?? "",
        "ClientID": 0,
        "SessionID": 0,
        "StatusAddress": "demo",
        "Distance": 0,
        "SelfiyImage": "",
        "isOnLocation": true,
      };
      var response = await ApiCall().updateStatus(params);
      if (response != null) {
        if (response['RtnStatus']) {
          // debugPrint("ABCDEFGHIJKL");
          return true;
        }
      }
    } else {
      debugPrint("1234567890");
      backgroundLocationService(status);
      return false;
    }
  }

}

Future<bool> requestPermissionForAndroid() async {
  // if (!Platform.isAndroid) {
  //   return ;
  // }
  // "android.permission.SYSTEM_ALERT_WINDOW" permission must be granted for
  // onNotificationPressed function to be called.
  //
  // When the notification is pressed while permission is denied,
  // the onNotificationPressed function is not called and the app opens.
  //
  // If you do not use the onNotificationPressed or launchApp function,
  // you do not need to write this code.
  // if (!await FlutterForegroundTask.canDrawOverlays) {
  //   // This function requires `android.permission.SYSTEM_ALERT_WINDOW` permission.
  //   await FlutterForegroundTask.openSystemAlertWindowSettings();
  // }

  // Android 12 or higher, there are restrictions on starting a foreground service.
  //
  // To restart the service on device reboot or unexpected problem, you need to allow below permission.
  if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
    // This function requires `android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` permission.
    var res= await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    return res;

  }

  return false;

  //Android 13 and higher, you need to allow notification permission to expose foreground service notification.
  // final NotificationPermission notificationPermissionStatus =
  // await FlutterForegroundTask.checkNotificationPermission();
  // if (notificationPermissionStatus != NotificationPermission.granted) {
  //   await FlutterForegroundTask.requestNotificationPermission();
  // }
}

Future<bool> stopForegroundTask() {
  debugPrint("service stopped ");
  return FlutterForegroundTask.stopService();
}

*//*

import 'package:flutter_foreground_task/flutter_foreground_task.dart';

Future<bool> requestPermissionForAndroid() async {
  // if (!Platform.isAndroid) {
  //   return ;
  // }
  // "android.permission.SYSTEM_ALERT_WINDOW" permission must be granted for
  // onNotificationPressed function to be called.
  //
  // When the notification is pressed while permission is denied,
  // the onNotificationPressed function is not called and the app opens.
  //
  // If you do not use the onNotificationPressed or launchApp function,
  // you do not need to write this code.
  // if (!await FlutterForegroundTask.canDrawOverlays) {
  //   // This function requires `android.permission.SYSTEM_ALERT_WINDOW` permission.
  //   await FlutterForegroundTask.openSystemAlertWindowSettings();
  // }

  // Android 12 or higher, there are restrictions on starting a foreground service.
  //
  // To restart the service on device reboot or unexpected problem, you need to allow below permission.
  if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
    // This function requires `android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` permission.
    var res= await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    return res;

  }

  return false;

  //Android 13 and higher, you need to allow notification permission to expose foreground service notification.
  // final NotificationPermission notificationPermissionStatus =
  // await FlutterForegroundTask.checkNotificationPermission();
  // if (notificationPermissionStatus != NotificationPermission.granted) {
  //   await FlutterForegroundTask.requestNotificationPermission();
  // }
}
*/
