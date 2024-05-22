import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../helpers/colors.dart';
import 'custom_button.dart';



Future showCustomAlertDialog({
  required String title, //required title
  required String content, //required content

  String? cancel,
  String? confirm,
  Function()? onTabCancel,
  Function()? onTabConfirm,
  bool isDismissable = true,
}) async {
  return await Get.defaultDialog(
    radius: 14,
    barrierDismissible: isDismissable,
    onWillPop: () async => isDismissable,
    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          cancel == null
              ? SizedBox(
            width: Get.width * 0.3,
          )
              : CustomButton(
              height: 35,
              width: Get.width * 0.3,
              text: cancel,
              btnColor: primaryColor,
              textColor: Colors.white,
              onTap: () {
                Get.back();
                if (onTabCancel != null) {
                  onTabCancel();
                }
              }),
          confirm == null
              ? SizedBox(
            width: Get.width * 0.3,
          )
              : CustomButton(
              height: 35,
              width: Get.width * 0.3,
              text: confirm,
              onTap: () {
                Get.back();
                if (onTabConfirm != null) {
                  onTabConfirm();
                }
              })
        ],
      )
    ],
    buttonColor: primaryColor,
    title: title,
    content: Text(
      content,
      style: const TextStyle(
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    ),
    titleStyle: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  );
}
