import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geotrack24fsc/utils/session.dart';
import 'package:get_storage/get_storage.dart';

import '../apis/api_call.dart';
import 'location_permission.dart';

final box = GetStorage();

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(
        // this will be executed when app is in foreground in separated isolate
        onForeground: onStart,
        // you have to enable background fetch capability on xcode project
      ),
      androidConfiguration: AndroidConfiguration(
          isForegroundMode: true, autoStart: true, onStart: onStart));
}

@pragma('vm:entry-point')
void onStart(ServiceInstance serviceInstance) {
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

  Timer.periodic(const Duration(minutes: 1), (timer) async {
    if (serviceInstance is AndroidServiceInstance) {
      if (await serviceInstance.isForegroundService()) {
        /*await FlutterLocalNotificationsPlugin().show(1, "24FSC", "App is running....",const NotificationDetails(
          android: AndroidNotificationDetails(
            '24FSC',
            '24FSC Important',
            channelDescription: 'DBZeus 24FSC app notification',
          ),
        ));*/
        serviceInstance.setForegroundNotificationInfo(
            title: "24Fsc", content: "App is running....");

        backgroundLocationService();
        //var response = await ApiCall().getDepartments(22);
      }
    }

    backgroundLocationService();
    //var response = await ApiCall().getDepartments(22);
    debugPrint("background service is running");
    serviceInstance.invoke('update');
  });
}

backgroundLocationService() async {
  var position = await getCurrentLocationForBackgroundFetch();
  var params = {
    "UserID": box.read(Session.userid).toString(),
    "StatusID": '3',
    "Latitude": '${position!.latitude}',
    "Longitude": '${position.longitude}',
    "MVersion": box.read(Session.version).toString(),
    "Battery": "",
    "DeviceID": box.read(Session.deviceID).toString(),
    "ClientID": 0,
    "SessionID": 0,
    "StatusAddress": "demo",
    "Distance": 0,
    "SelfiyImage": "",
    "isOnLocation": true,
  };
  var response = await ApiCall().updateStatus(params);
}
