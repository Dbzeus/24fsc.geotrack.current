import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:device_info/device_info.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geotrack24fsc/utils/dialogs.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../apis/api_call.dart';

import '../../../helpers/colors.dart';
import '../../../models/MobileLoginResponse.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/constants.dart';
import '../../../utils/loader.dart';
import '../../../utils/location_permission.dart';
import '../../../utils/session.dart';
import '../../../widgets/custom_button.dart';
/*import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;*/

class MobileLoginController extends GetxController {
  TextEditingController mobNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isSecure = true.obs;
  var passwordIcon = Icons.visibility.obs;

  RxBool isCheck = false.obs;

  bool collectDataEnable = false;

  passwordToggle() {
    isSecure(!isSecure.value);
    isSecure.value
        ? passwordIcon(Icons.visibility)
        : passwordIcon(Icons.visibility_off);
  }

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();

  final _box = GetStorage();
  late PackageInfo packageInfo;
  RxString appVersion = ''.obs;

  RxBool isLoginLoading = false.obs;

  String token = "";
  var info;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  @override
  void onInit() async {
    super.onInit();
    packageInfo = await PackageInfo.fromPlatform();
    _box.write(Session.version, packageInfo.version);
    appVersion('App Version ${packageInfo.version}');

    if (Platform.isAndroid) {
      info = await _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      info = await _readIosBuildData(await deviceInfoPlugin.iosInfo);
    }

    collectDataEnable = _box.read(Session.isCollectDataEnabled) ?? false;

    if (collectDataEnable == false) {
      await dataDialog();

      var res = await checkLocationPermission2();
    } else {
      var res = await checkLocationPermission2();
      if (res == true) {
        return;
      } else {
        var permission = await Permission.locationAlways.request();
        if (permission.isGranted) {
          return;
        } else {
          await allowLocationPermission();
        }
      }
    }

    /* var res = await Permission.ignoreBatteryOptimizations.isGranted;
    debugPrint("REsult: ${res.toString()}");
    if (res == false) {
      await checkBatteryOptimisation();
    }*/
    /*backgroundAccess();
    bool? isAutoStartEnabled =
        await DisableBatteryOptimization.isAutoStartEnabled;
    if (isAutoStartEnabled == false) {
      await DisableBatteryOptimization.showEnableAutoStartSettings(
          "Enable Auto Start",
          "Follow the steps and enable the auto start of this app");
    }
    bool? isBatteryOptimizationDisabled =
        await DisableBatteryOptimization.isBatteryOptimizationDisabled;
    if (isBatteryOptimizationDisabled == false) {

      await DisableBatteryOptimization.showDisableBatteryOptimizationSettings();
    }
    bool? isAllBatteryOptimizationDisabled =
        await DisableBatteryOptimization.isAllBatteryOptimizationDisabled;
    if (isAllBatteryOptimizationDisabled == false) {
      await DisableBatteryOptimization.showDisableAllOptimizationsSettings(
          "Enable Auto Start",
          "Follow the steps and enable the auto start of this app",
          "test",
          "test");
    }
    bool? isManufacturerBatteryOptimizationDisabled =
        await DisableBatteryOptimization
            .isManufacturerBatteryOptimizationDisabled;
    if (isManufacturerBatteryOptimizationDisabled == false) {
      await DisableBatteryOptimization.showDisableManufacturerBatteryOptimizationSettings(
          "Enable Auto Start",
          "Follow the steps and enable the auto start of this app");
    }

    debugPrint("isAutoStartEnabled:${isAutoStartEnabled.toString()}");
    debugPrint(
        "isBatteryOptimizationDisabled:${isBatteryOptimizationDisabled.toString()}");
    debugPrint(
        "isAllBatteryOptimizationDisabled:${isAllBatteryOptimizationDisabled.toString()}");
    debugPrint(
        "isManufacturerBatteryOptimizationDisabled:${isManufacturerBatteryOptimizationDisabled.toString()}");*/


  }

  Future<Map<String, dynamic>> _readAndroidBuildData(
      AndroidDeviceInfo build) async {
    return <String, dynamic>{
      'UserID': '0',
      'sdkInt': build.version.sdkInt,
      'release': build.version.release,
      'brand': build.brand,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'arm': build.supportedAbis.toString(),
      'model': build.model,
      'deviceid': build.androidId,
    };
  }

  Future<Map<String, dynamic>> _readIosBuildData(IosDeviceInfo build) async {
    return <String, dynamic>{
      'UserID': '0',
      'sdkInt': build.systemVersion,
      'release': build.systemName,
      'brand': build.name,
      'id': build.name,
      'manufacturer': 'Apple',
      'arm': build.utsname.machine,
      'model': build.model,
      'deviceid': build.identifierForVendor,
    };
  }

  @override
  void onReady() async {
    //await checkLocationPermission();
    _fcm.requestPermission();
    token = await _fcm.getToken() ?? '';
    debugPrint("FCM token: $token");
  }

  dataDialog() async {
    await Get.defaultDialog(
      barrierDismissible: false,
      title: "Alert",
      /*and Battery usage  */
      titleStyle: const TextStyle(
        color: secondaryColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      middleText:
          "My 24fscgeotrack collects location data to enable user to track live locations.",
      confirm: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                  height: 30,
                  borderRadius: 12,
                  width: MediaQuery.of(Get.context!).size.width * 0.30,
                  text: "Accept",
                  onTap: () async {
                    Get.back();
                    _box.write(Session.isCollectDataEnabled, true);
                    collectDataEnable = _box.read(Session.isCollectDataEnabled);
                    var permission = await Permission.locationAlways.request();
                    if (permission.isGranted) {
                      return;
                    } else {
                      await allowLocationPermission();
                    }
                  }),
              const SizedBox(
                width: 16,
              ),
              CustomButton(
                  height: 30,
                  borderRadius: 12,
                  btnColor: Colors.red,
                  width: MediaQuery.of(Get.context!).size.width * 0.30,
                  text: "Deny",
                  onTap: () {
                    Get.back();
                    _box.write(Session.isCollectDataEnabled, false);
                    collectDataEnable = _box.read(Session.isCollectDataEnabled);
                  }),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  login() async {
    Get.focusScope?.unfocus();
    if (mobNoController.text.isEmpty) {
      showToastMsg('Enter mobile number');
    } else if (!(mobNoController.text.length == 6 ||
        mobNoController.text.length == 10)) {
      showToastMsg('Enter correct mobile number');
    } else if (passwordController.text.isEmpty) {
      showToastMsg('Enter password');
    }
    /* }else if(isCheck.value == false){
      showToastMsg('Please read and agree to our Privacy Policy terms.');
    }*/
    else {
      if (await isNetConnected()) {
        if (collectDataEnable == false) {
          await dataDialog();
          return;
        }
        showLoader(title: "Loading");

        if (token.isEmpty) {
          token = await _fcm.getToken() ?? '';
        }
        _box.write(Session.token, token);
        debugPrint("info :${info.toString()}");
        MobileLoginResponse? response = await ApiCall().checkLogin(
            mobNoController.text, passwordController.text, token, info);

        if (response != null) {
          if (response.rtnStatus ?? false) {
            showToastMsg(response.rtnMessage);
            goToHome(response.rtnData);
          } else {
            showToastMsg('${response.rtnMessage}');
          } /*else {
          if (response.id == 1) {
            //show popup
            bool? res = await showAlert(
                'Already Logger-In?', response.rtnMessage ?? '', 'Login');
            if (res != null && res) {
              info['UserID'] = '${response.rtnData.first.userID ?? '0'}';
              var upRes = await ApiCall().updateDeviceDetails(info);
              if (upRes != null) {
                showToastMsg(upRes['RtnMessage']);
                if (upRes['RtnStatus']) {
                  goToHome(response.rtnData);
                }
              }
            }
          } else {
            showToastMsg('${response.rtnMessage}');
          }
        }*/
        }
        hideLoader();
        //isLoginLoading(false);
      }
    }
  }

  goToHome(List<RtnData> rtnData) {
    _box.write(Session.userid, rtnData[0].userID);
    _box.write(Session.userImage, rtnData[0].imagePath);
    _box.write(Session.firstName, rtnData[0].firstName);
    _box.write(Session.userEmail, rtnData[0].mailID);
    _box.write(Session.branchId, rtnData[0].branchID);
    _box.write(Session.branchName, rtnData[0].branchName);
    _box.write(Session.roleId, rtnData[0].roleID);
    _box.write(Session.roleName, rtnData[0].roleName);
    _box.write(Session.designation, rtnData[0].designation);
    _box.write(Session.isAppLogin, true);
    _box.write(Session.isMobileLogin, false);
    _box.write(Session.isCustomer, rtnData[0].isCustomer);
    _box.write(Session.customerId, rtnData[0].customerID);
    _box.write(Session.empId, rtnData[0].empId);
    _box.write(Session.isMarketing, rtnData[0].isMarketing);
    _box.write(Session.isILT, rtnData[0].isILT);
    _box.write(Session.serviceTimeInterval, rtnData[0].timeInterval);
    _box.write(Session.autoLogoutTime, rtnData[0].autoLogoutTime);
    debugPrint(
        "Time interval:${_box.read(Session.serviceTimeInterval.toString())}");
    Get.offAllNamed(Routes.home);
  }
}
