import 'package:flutter/material.dart';
import 'package:geotrack24fsc/helpers/colors.dart';
import 'package:get/get.dart';

void showLoader( {String? title}) {
  hideLoader();
  Get.dialog(
    WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 40,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  title ?? 'Please wait',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: whiteColor),
                ),
              )
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

void hideLoader() {
  debugPrint('isOpen ? ${Get.isDialogOpen}');
  (Get.isDialogOpen ?? false) ? Get.back() : null;
}
