import 'dart:io';
/*
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:intl/intl.dart';
import 'package:orbitoasia/apis/api_call.dart';
import 'package:orbitoasia/helper/color.dart';
import 'package:orbitoasia/helper/dialogs.dart';
import 'package:orbitoasia/helper/loader.dart';
import 'package:orbitoasia/helper/session.dart';
import 'package:orbitoasia/helper/utils.dart';
import 'package:orbitoasia/models/ClientListResponse.dart';
import 'package:orbitoasia/models/NearCompanyResponse.dart';
import 'package:orbitoasia/models/SettingResponse.dart';
import 'package:orbitoasia/routes/app_routes.dart';
import 'package:orbitoasia/widgets/box_edittext.dart';
import 'package:orbitoasia/widgets/button.dart';
import 'package:package_info/package_info.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../helper/constants.dart';
*/

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geotrack24fsc/helpers/colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

import '../../apis/api_call.dart';
import '../../models/ApplicationSettingResponse.dart';

import '../../models/GeoHistoryResponse.dart';
import '../../routes/app_routes.dart';
import '../../utils/constants.dart';
import '../../utils/dialogs.dart';
import '../../utils/loader.dart';
import '../../utils/location_permission.dart';
import '../../utils/services.dart';
import '../../utils/session.dart';
import '../../widgets/custom_button.dart';

class HomeController extends GetxController {
  RxString userName = ''.obs,
      userImage = ''.obs,
      msg = 'No Record\'s Found'.obs;
  int userId = -1;
  int customerId = -1;
  String version = '-1';
  String deviceId = '-1';
  final _box = GetStorage();
  RxList timelines = RxList();
  RxBool isLoading = false.obs,isCanceled = true.obs;

  late PackageInfo packageInfo;
  Rx<String> currentDate = "".obs;
  var showFormat = DateFormat('dd MMM yyyy');

  Rx<ApplicationSettingResponseData?> settings = Rx(null);
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void onInit() async {
    super.onInit();
    currentDate(DateFormat('MMM dd yyyy').format(DateTime.now()));
    packageInfo = await PackageInfo.fromPlatform();
    userName(_box.read(Session.firstName) ?? '');
    userId = _box.read(Session.userid) ?? -1;
    userImage(_box.read(Session.userImage) ?? '');
    _box.write(Session.version, packageInfo.version);
    version = packageInfo.version;
    _box.write(Session.appVersion, version);

    //for locations
    Geolocator.requestPermission();
    bool _isServiceEnable = await Geolocator.isLocationServiceEnabled();
    if (!_isServiceEnable) Geolocator.openLocationSettings();
    if (Platform.isAndroid) {
      deviceId = (await deviceInfoPlugin.androidInfo).androidId;
    } else if (Platform.isIOS) {
      deviceId = (await deviceInfoPlugin.iosInfo).identifierForVendor;
    }
    _box.write(Session.deviceID, deviceId);
    getTimeline();
  }

  checkLogIn() {
    var currentDate = showFormat.format(DateTime.now());
    if (_box.read(Session.logInDate) == null) {
      //variable thevai illa
      _box.write(Session.logInDate, currentDate);
      debugPrint("First Date: $currentDate");
    } else {
      if (_box.read(Session.logInDate) != currentDate) {
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
    }else{
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
      };
      showLoader(title: 'Update Status');
      //update status
      var params = {
        "UserID": '$userId',
        "StatusID": '${status.status.first.statusID}',
        "Latitude": '${position.latitude}',
        "Longitude": '${position.longitude}',
        "MVersion": version,
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
          _box.write(Session.isAutoFetch, status.status.first.statusID);
          debugPrint("AUTO FETCH:${_box.read(Session.isAutoFetch)}");

          if (_box.read(Session.isAutoFetch) == 1) {
            debugPrint(
                "AUTO FETCH in foreground:${_box.read(Session.isAutoFetch)}");
            var permission = await checkLocationPermission1();
            if (permission == true) {
              int time = _box.read(Session.serviceTimeInterval) ;
              debugPrint("Service time in home: ${time.toString()}");
              await initializeService();
              if (await FlutterBackgroundService().isRunning()) {
                FlutterBackgroundService().invoke('stopService');
                if (await FlutterBackgroundService().isRunning()) {
                  FlutterBackgroundService().invoke('setAsForeground');
                  _box.write(Session.isRunnerCancelling,true);
                }
              }
              //FlutterBackgroundService().invoke('setAsBackground');
            }
          } else if (_box.read(Session.isAutoFetch) == 2 ) {
            debugPrint("AUTO FETCH in stop:${_box.read(Session.isAutoFetch)}");
            if (await FlutterBackgroundService().isRunning()) {
              FlutterBackgroundService().invoke('stopService');
              _box.write(Session.isRunnerCancelling,false);
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
      _box.erase();
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
}
