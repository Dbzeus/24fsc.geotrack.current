import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../main.dart';
import '../../utils/location_permission.dart';
import '../../utils/session.dart';

class ServiceOverlayController extends GetxController {
  final box = GetStorage();

  @override
  Future<void> onInit() async {
    debugPrint("onInit");

    // TODO: implement onInit
    super.onInit();
    // bool isOverlayActive = await FlutterOverlayWindow.isActive();
    // debugPrint("isOverlayActive : ${isOverlayActive.toString()}");
    // if (!isOverlayActive) {
    //   debugPrint("backgroundLocation creating");
    //   await backgroundLocation();
    // }
    await backgroundLocation();
  }

  @override
  Future<void> onReady() async {
    // TODO: implement onReady
    super.onReady();
  }

  backgroundLocation() async {
    try {
      // var permission = await allowLocationPermission();
      // if (permission == true) {
      var res;
      res = await FlutterBackgroundService().isRunning();
      if (res) {
        // debugPrint("stop and restart");
        FlutterBackgroundService().invoke('stopService');
        res = await FlutterBackgroundService().isRunning();
        // debugPrint("running: 2 :${res.toString()}");
        if (res == false) {
          await initializeService();
          FlutterBackgroundService().invoke('setAsForeground');
          box.write(Session.isRunnerCancelling, true);
        }
      } else {
        // debugPrint("start service");
        await initializeService();
        FlutterBackgroundService().invoke('setAsForeground');
        box.write(Session.isRunnerCancelling, true);
      }
      // } else {
      //   debugPrint("stop service");
      //   debugPrint("AUTO FETCH in stop:${box.read(Session.isAutoFetch)}");
      //   var res = await FlutterBackgroundService().isRunning();
      //   debugPrint("running: 4 :${res.toString()}");
      //   if (res) {
      //     FlutterBackgroundService().invoke('stopService');
      //     box.write(Session.isRunnerCancelling, false);
      //   }
      // }
    } catch (e) {
      debugPrint("ERROR:${e.toString()}");
    }
  }
}
