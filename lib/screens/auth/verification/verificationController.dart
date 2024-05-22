import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workmanager/workmanager.dart';



import '../../../routes/app_routes.dart';


import '../../../utils/location_permission.dart';
import '../../../utils/notification.dart';

class VerificationController extends GetxController {
  TextEditingController fieldOne = TextEditingController();
  TextEditingController fieldTwo = TextEditingController();
  TextEditingController fieldThree = TextEditingController();
  TextEditingController fieldFour = TextEditingController();

  Timer? timer;
  RxInt seconds = 30.obs;
  RxBool isResend = false.obs;

  RxString mobileNo = "".obs;
  String otp = "";

  int enteredOtp = 0;

  RxBool isLoading = false.obs;

  final _box = GetStorage();

  @override
  void onInit() {
    // mobileNo(Get.arguments["mobileNo"]);
    // otp = Get.arguments["otp"];
    super.onInit();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds.value > 0) {
        seconds--;
        if (seconds.value == 0) {
          isResend(true);
          t.cancel();
        }
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  backgroundLocationFetch() async {/*await notificationPermission();
    var permission = await checkLocationPermission1();
    if (permission == true) {
      bool isLocationOn = await locationService();
      if (isLocationOn) {
        await Workmanager().initialize(callbackDispatcher,
            isInDebugMode: true // Your callback function
            );
        Workmanager().registerPeriodicTask(
          "${DateTime.now().minute}${DateTime.now().second}", // Unique name
          "Fetch Location", //task name
          frequency: const Duration(minutes: 15), // Hourly execution
        );
        Get.toNamed(Routes.home);
      } else {
        backgroundLocationFetch();
      }
    }*/

  }
}
