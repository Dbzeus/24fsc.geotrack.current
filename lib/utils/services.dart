import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geotrack24fsc/utils/session.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../apis/api_call.dart';
import 'location_permission.dart';



Future<void> initializeService() async {
  //serviceTime = time;
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(
          // this will be executed when app is in foreground in separated isolate
          onForeground: onStart
          // you have to enable background fetch capability on xcode project
          ),
      androidConfiguration: AndroidConfiguration(
          isForegroundMode: true, autoStart: true, onStart: onStart));
}

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance serviceInstance) async {
  DartPluginRegistrant.ensureInitialized();

  if (serviceInstance is AndroidServiceInstance) {
    serviceInstance.on('setAsForeground').listen((event) {
      serviceInstance.setAsForegroundService();
    });

    serviceInstance.on('setAsBackground').listen((event) {
      serviceInstance.setAsBackgroundService();
    });
  }
  serviceInstance.on('stopService').listen((event) {
    serviceInstance.stopSelf();
  });
await GetStorage.init();
  final box = GetStorage();
  int time = await box.read(Session.serviceTimeInterval) /*?? 10*/;
  debugPrint("Service time in service: ${time.toString()}");
  Timer.periodic(Duration(minutes: time), (timer) async {
    if (serviceInstance is AndroidServiceInstance) {
      if (await serviceInstance.isForegroundService()) {
        //debugPrint("foreground service is running");
        /*await FlutterLocalNotificationsPlugin().show(1, "24FSC", "App is running....",const NotificationDetails(
          android: AndroidNotificationDetails(
            '24FSC',
            '24FSC Important',
            channelDescription: 'DBZeus 24FSC app notification',
          ),
        ));*/

        serviceInstance.setForegroundNotificationInfo(
            title: "24Fsc", content: "App is running........");

        //backgroundLocationService();
        //var response = await ApiCall().getDepartments(22);
      }
    }

    DateFormat timeFormat = DateFormat("HH:mm:ss");

    DateTime currentTime =
        timeFormat.parse(DateTime.now().toString().split(" ")[1].split(".")[0]);
    DateTime logoutTime = timeFormat.parse("20:00:00");

    //debugPrint("ABCD1");

    if (currentTime.isAfter(logoutTime)) {
      //debugPrint("ABCD2");
      await GetStorage.init();
      final box = GetStorage();
      // debugPrint(
      //     "ABCD Session:${box.read(Session.isRunnerCancelling).toString()}");
      if (box.read(Session.isRunnerCancelling) != null) {
        if (box.read(Session.isRunnerCancelling) == true) {
          // debugPrint("ABCD3");
          var res = await backgroundLocationService("4");
          if (res == true) {
            // debugPrint("ABCD4");
            box.write(Session.isRunnerCancelling, false);
            serviceInstance.stopSelf();
          }
        }
      } else {
        // debugPrint("ABCD Foreground");
        serviceInstance.invoke("setAsForeground");
      }
    } else {
      // debugPrint("ABCD5");
      backgroundLocationService("3");
    }
    serviceInstance.invoke('update');
  });
}

backgroundLocationService(String status) async {
  var position = await getCurrentLocationForBackgroundFetch();
  final box = GetStorage();
  if (box.read(Session.userid) != null ||
      box.read(Session.version) != null ||
      box.read(Session.deviceID) != null) {
    // debugPrint("ABCD Status id: ${status.toString()}");
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
    // debugPrint("1234567890");
    backgroundLocationService(status);
    return false;
  }
}
