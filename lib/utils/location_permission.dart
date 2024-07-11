import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geotrack24fsc/helpers/colors.dart';
import 'package:geotrack24fsc/utils/session.dart';
import 'package:geotrack24fsc/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkLocationPermission() async {
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return false;
  }

  return true;
}

Future<bool> checkLocationPermission1() async {
  PermissionStatus status = await Permission.locationAlways.request();
  if (status.isGranted) {
    /*final access = await Geolocator.checkPermission();

    switch (access) {
      case LocationPermission.denied:
        final permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        } else {
          return true;
        }

      case LocationPermission.deniedForever:
        //showToastMsg('Location Permission Needed');
        openAppSettings();
        return false;

      case LocationPermission.always:
      case LocationPermission.whileInUse:
        return true;

      default:
        return false;
    }*/
    return true;
  } else {
    Get.defaultDialog(
        title: "Allow permission for Location and Battery usage ",
        titleStyle: const TextStyle(
            color: secondaryColor, fontSize: 14, fontWeight: FontWeight.bold,
        ),
        middleText:
            "${"1.Permissions -> Location -> Allow All the time."} \n${"2.Battery -> Dont optimise (OR) Allow background activity"}",

        confirm: CustomButton(
            text: "Settings",
            onTap: () {
              Get.back();
              openAppSettings();
            }));
    return false;
  }
}

Future<bool> locationService() async {
  bool isServiceEnable = await Geolocator.isLocationServiceEnabled();
  if (!isServiceEnable) {
    isServiceEnable = await Geolocator.openLocationSettings();
  }
  return isServiceEnable;
}

Future<Position?> getCurrentLocation({bool showMap = true}) async {
  bool _isServiceEnable = false;
  _isServiceEnable = await Geolocator.isLocationServiceEnabled();
  if (!_isServiceEnable) {
    _isServiceEnable = await Geolocator.openLocationSettings();
    debugPrint('service enable / not --- $_isServiceEnable');
    if (_isServiceEnable) {
      Future.delayed(const Duration(seconds: 2),
          () async => await getLocation(showMap: showMap));
      return null;
    } else {
      return await getCurrentLocation(showMap: showMap);
    }
  } else {
    return await getLocation(showMap: showMap);
  }
}

Future<Position?> getCurrentLocationForBackgroundFetch() async {
  Position? data = await Geolocator.getCurrentPosition();
  return data;
}

Future<Position?> getLocation({bool showMap = true}) async {
  var p = await Geolocator.checkPermission();
  if (p == LocationPermission.always || p == LocationPermission.whileInUse) {
    Position? data = await Geolocator.getCurrentPosition();
    if (showMap) {
      data = await Get.bottomSheet(
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w700),
                  )),
              /*  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  InkWell(
                      onTap: () {
                        Get.back(result: data);
                      },
                      child: const Text(
                        'Okay',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                ],
              ),*/
              const Divider(),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(data.latitude, data.longitude),
                        zoom: 18),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: true,
                    mapType: MapType.normal,
                    scrollGesturesEnabled: true,
                    markers: {
                      Marker(
                        markerId: const MarkerId('1'),
                        position: LatLng(data.latitude, data.longitude),
                      ),
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  btnColor: secondaryColor,
                  text: "Select",
                  onTap: () {
                    Get.back(result: data);
                  })
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        )),
        backgroundColor: whiteColor,
        enableDrag: false,
        isDismissible: false,
      );
    }
    return data;
  } else {
    checkLocationPermission();
    return null;
  }
}
