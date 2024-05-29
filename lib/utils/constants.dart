import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geotrack24fsc/helpers/colors.dart';
import 'package:get/get.dart';


showToastMsg(String msg) {
  Fluttertoast.showToast(
    backgroundColor: lightBgGreenColor,
    textColor:  blackColor,

    msg: msg, timeInSecForIosWeb: 3, toastLength: Toast.LENGTH_SHORT,);
}


var connectivity = Connectivity();

isNetConnected() async {
  bool res =
      (await connectivity.checkConnectivity()) != ConnectivityResult.none;
  if (!res) showNetworkError();
  return res;
}

showNetworkError() {
  Get.snackbar(
    'Network Error',
    'Check Your Internet Connection',
    backgroundColor: Colors.red,
    colorText: Colors.white,
    icon: const Icon(
      Icons.signal_cellular_connected_no_internet_4_bar,
      color: Colors.white,
    ),
  );
}

showSnackbar(String? title, String? msg, {Color? tcolor}) {
  Get.snackbar(title ?? 'Something Wrong', msg ?? '',
      snackPosition: SnackPosition.BOTTOM, colorText: tcolor ?? Colors.black);
}
