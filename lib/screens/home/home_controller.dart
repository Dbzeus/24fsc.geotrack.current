import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geotrack24fsc/helpers/colors.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../apis/api_call.dart';

import '../../main.dart';
import '../../models/ApplicationSettingResponse.dart';

import '../../models/GeoHistoryResponse.dart';
import '../../routes/app_routes.dart';
import '../../utils/constants.dart';
import '../../utils/dialogs.dart';
import '../../utils/loader.dart';
import '../../utils/location_permission.dart';
import '../../utils/session.dart';
import '../../widgets/custom_button.dart';

class HomeController extends GetxController {
  RxString userName = ''.obs,
      userImage = ''.obs,
      msg = 'No Record\'s Found'.obs;
  int userId = -1;
  int customerId = -1;
  RxString version = '-1'.obs;
  String deviceId = '-1';
  final box = GetStorage();
  RxList timelines = RxList();
  RxBool isLoading = false.obs, isCanceled = true.obs;

  late PackageInfo packageInfo;
  Rx<String> currentDate = "".obs;
  var showFormat = DateFormat('dd MMM yyyy');

  Rx<ApplicationSettingResponseData?> settings = Rx(null);
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void onInit() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    _fcm.requestPermission();
    String token = await _fcm.getToken() ?? '';
    debugPrint("FCM token: $token");

    //debugPrint("TIME123:${DateTime.now().toString().split(" ")[1].substring(0,5)}");
    super.onInit();
    currentDate(DateFormat('MMM dd yyyy').format(DateTime.now()));
    packageInfo = await PackageInfo.fromPlatform();
    userName(box.read(Session.firstName) ?? '');
    userId = box.read(Session.userid) ?? -1;
    userImage(box.read(Session.userImage) ?? '');
    box.write(Session.version, packageInfo.version);
    version.value = packageInfo.version;
    box.write(Session.appVersion, version.value);

    if (Platform.isAndroid) {
      deviceId = (await deviceInfoPlugin.androidInfo).androidId;
    } else if (Platform.isIOS) {
      deviceId = (await deviceInfoPlugin.iosInfo).identifierForVendor;
    }
    box.write(Session.deviceID, deviceId);
  }

  @override
  Future<void> onReady() async {
    getTimeline();
    await Future.delayed(const Duration(seconds: 4), () async {
      checkLogIn();
      debugPrint("22222:");
      backgroundAccess();
      /*var res = await FlutterBackgroundService().isRunning();
      debugPrint("running :${res.toString()}");
      if (res) {
        showCustomAlertDialog(
            title: "Background Running",
            content:
                "System is running in background do you continue your login or do you logout your session?",
            confirm: "continue",
            cancel: "logout",
            isDismissable: false,
            onTabConfirm: () {
              Get.back();
            },
            onTabCancel: () {
              changeStatus(settings.value!);
            });
      }*/
    });

    // TODO: implement onReady
    super.onReady();
  }

  backgroundAccess() async {
    debugPrint("11111:");
    bool isServiceEnable = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnable) {
      await Geolocator.getCurrentPosition();
      //await Geolocator.openLocationSettings();
    }
    PermissionStatus res =
        await Permission.ignoreBatteryOptimizations.request();
    /*if(res != PermissionStatus.granted){
      Get.defaultDialog(
          title: "Allow permission for Battery optimisation ",
          titleStyle: const TextStyle(
            color: secondaryColor, fontSize: 14, fontWeight: FontWeight.bold,
          ),
          middleText:
          "${"1.Battery -> Dont optimise (OR) Allow background activity"}/n${"2."}",

          confirm: CustomButton(
              text: "Settings",
              onTap: () {
                Get.back();
                openAppSettings();
              }));
    }*/

    debugPrint("res:${res.toString()}");

    // final bool status = await FlutterOverlayWindow.isPermissionGranted();
    // if (status == false) {
    //   final bool? status = await FlutterOverlayWindow.requestPermission();
    // }
    if (res.isGranted) {
      return;
    } else {
      backgroundAccess(); //await Permission.ignoreBatteryOptimizations.request();
    }
  }

  checkLogIn() {
    var currentDate = showFormat.format(DateTime.now());
    if (box.read(Session.logInDate) == null) {
      //variable thevai illa
      box.write(Session.logInDate, currentDate);
      debugPrint("First Date: $currentDate");
    } else {
      if (box.read(Session.logInDate) != currentDate) {
        Get.defaultDialog(
            barrierDismissible: false,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            title: "Session Expired!",
            titleStyle: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
            middleText: "Your session has expired. Please re-login to continue",
            middleTextStyle: const TextStyle(
              fontSize: 12,
            ),
            confirm: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  appLogout();
                },
                child: const Text("Logout"),
              ),
            ));
      }
    }
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("STATE: ${state.toString()}");
  }

  getTimeline() async {
    if (await isNetConnected()) {
      isLoading(true);
      try {
        GeoHistoryResponse? response = await ApiCall().getHistories(
            '$userId',
            DateFormat("MM-dd-yyyy")
                .format(DateFormat("MMM dd yyyy").parse(currentDate.value)));
        if (response != null) {
          if (response.rtnStatus) {
            timelines(response.rtnData!.table);
            msg(timelines.isEmpty ? 'No Record\'s Found' : '');
          } else {
            debugPrint("ADFSDAGSFHFDH");
            msg(response.rtnMessage);
            timelines([]);
          }
        }
      } catch (e) {
        e.toString();
      }

      getSettings();
    } else {
      showToastMsg("Check your internet connection");
    }
  }

  getSettings() async {
    if (await isNetConnected()) {
      settings(null);
      ApplicationSettingResponse? response =
          await ApiCall().getSettings('$userId');
      if (response != null) {
        if (response.rtnStatus) {
          settings(response.rtnData);
          settings.refresh();
          customerId = response.rtnData!.applicationSetting.first.customerID;
        }
      }
      isLoading(false);
    }
  }

  changeStatus(ApplicationSettingResponseData status) async {
    try{
      if (await isNetConnected()) {
        showLoader(title: 'Load Setting');
        await getSettings();
        hideLoader();
        bool isSuccess = true;
        if (settings.value == null) return;
        if (settings.value!.applicationSetting.first.devicechecking &&
            settings.value!.applicationSetting.first.deviceID != deviceId) {
          //show Another device login so logout pls with bottom sheet
          showModalBottomSheet(
              context: Get.context!,
              isDismissible: false,
              enableDrag: false,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  )),
              builder: (context) {
                return WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Another Device Login',
                          style: TextStyle(
                            color: secondaryColor,
                          ),
                        ),
                        const Divider(),
                        CustomButton(
                          text: 'Logout',
                          onTap: () {
                            appLogout(isHaveDialog: false);
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                );
              });
          return;
        }

        bool isCorrectStatus = settings.value!.status
            .any((element) => element.statusID == status.status.first.statusID);
        if (!isCorrectStatus) {
          showToastMsg('Your\'e not able to ${status.status.first.geoStatus}');
          return;
        }
        var position;
        if (status.status.first.isLocationRequired) {
          showLoader(title: "Getting Location");
          position = await getCurrentLocation();
          debugPrint("Position: ${position.toString()}");
          hideLoader();
        } else {
          position = Position(
              longitude: 0,
              latitude: 0,
              timestamp: DateTime.timestamp(),
              accuracy: 0,
              altitude: 0,
              heading: 0,
              speed: 0,
              speedAccuracy: 0,
              altitudeAccuracy: 0,
              headingAccuracy: 0);
        }
        isCanceled(true); // setting true, because its always true for slider button. if position gives null then only,change to false
        if (position == null) {
          isCanceled(false);
          return;
        }

        showLoader(title: 'Update Status');
        //update status
        var params = {
          "UserID": '$userId',
          "StatusID": '${status.status.first.statusID}',
          "Latitude": '${position.latitude}',
          "Longitude": '${position.longitude}',
          "MVersion": version.value,
          "Battery": "",
          "DeviceID": deviceId,
          "ClientID": 0,
          "SessionID": 0,
          "StatusAddress": "demo",
          "Distance": 0,
          "SelfiyImage": "",
          "isOnLocation": isSuccess,
        };
        var response = await ApiCall().updateStatus(params);
        hideLoader();
        if (response != null) {
          if (response['RtnStatus']) {
            showToastMsg('${response['RtnMessage']}');
            box.write(Session.isAutoFetch, status.status.first.statusID.toString());
            // debugPrint("status id: ${box.read(Session.isAutoFetch).toString()}");
            // debugPrint("AUTO FETCH:${box.read(Session.isAutoFetch)}");
            if (int.parse(box.read(Session.isAutoFetch)) == 1) // 1 is login
                {
              // debugPrint(
              //     "AUTO FETCH in foreground:${box.read(Session.isAutoFetch)}");
              var permission = await checkLocationPermission1();
              if (permission == true) {
                var res;
                res = await FlutterBackgroundService().isRunning();
                // debugPrint("running: 1 :${res.toString()}");
                if (res) {
                  // debugPrint("stop and restart");
                  FlutterBackgroundService().invoke('stopService');
                  res = await FlutterBackgroundService().isRunning();
                  // debugPrint("running: 2 :${res.toString()}");
                  if (res == false) {
                    await initializeService();
                    FlutterBackgroundService().invoke('setAsForeground');
                    /*await Future.delayed(const Duration(seconds:  5));
                   // Call the second method
                  res = await FlutterBackgroundService().isRunning();
                  if(res){
                    FlutterBackgroundService().invoke('setAsBackground');
                    debugPrint("Service time in home: ${time.toString()}");
                  }*/
                    box.write(Session.isRunnerCancelling, true);
                  }
                } else {
                  // debugPrint("start service");
                  await initializeService();
                  FlutterBackgroundService().invoke('setAsForeground');
                  box.write(Session.isRunnerCancelling, true);
                }
                //FlutterBackgroundService().invoke('setAsBackground');
              }
            } else
              /*if (int.parse(box.read(Session.isAutoFetch)) == 2)*/ //  2 is logout
                {
              debugPrint("stop service");
              debugPrint("AUTO FETCH in stop:${box.read(Session.isAutoFetch)}");
              var res = await FlutterBackgroundService().isRunning();
              debugPrint("running: 4 :${res.toString()}");
              if (res) {
                FlutterBackgroundService().invoke('stopService');
                box.write(Session.isRunnerCancelling, false);
              }
            }

          } else {
            showAlert(
                'Status Update Failed!', '${response['RtnMessage']}', 'Okay',
                isOneButton: true);
          }
          getTimeline();
        }
      }
    }catch(e){
      debugPrint("ERROR:${e.toString()}");
    }

  }

  void appLogout({bool? isHaveDialog}) async {
    bool? resp = false;
    if (isHaveDialog == null) {
      resp = await showAlert(
        'Logout?',
        'Are you sure to logout from app.',
        'Logout',
      );
    } else {
      resp = true;
    }

    if (resp != null && resp) {
      showLoader(title: 'Logging Out');
      box.erase();
      hideLoader();
      Get.offAllNamed(Routes.mobileLogin);
    }
  }

  changeDate() async {
    try {
      DateTime dt = DateFormat("MMM dd yyyy").parse(currentDate.value);
      final DateTime? pickedDate = await showDatePicker(
          context: Get.context!,
          initialDate: dt,
          firstDate: DateTime.now().subtract(const Duration(days: 45)),
          lastDate: DateTime.now());

      if (pickedDate != null) {
        currentDate(DateFormat("MMM dd yyyy").format(pickedDate));
        getTimeline();
      }
    } catch (e) {
      //ignored
    }
  }

  showChatHead() async {
    await FlutterOverlayWindow.showOverlay();
  }
}
