import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geotrack24fsc/helpers/colors.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_edittext.dart';
import 'constants.dart';





showAlert(String title, String msg, String posBtnText,
    {bool isDismiss = true, bool isOneButton = false}) {
  Get.focusScope?.unfocus();
  return showDialog(
    context: Get.context!,
    barrierDismissible: isDismiss,
    builder: (BuildContext con) {
      return WillPopScope(
        onWillPop: () async{
          return isDismiss;
        },
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Divider(),
                Text(
                  msg,
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    isOneButton
                        ? const SizedBox(
                            width: 100,
                          )
                        : CustomButton(
                            width: 100,
                            btnColor: primaryColor,

                            text: 'Cancel',
                            onTap: () {
                              Get.back(result: false);
                            }),
                    CustomButton(
                        width: 100,

                        text: posBtnText,
                        onTap: () {
                          Get.back(result: true);
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}


/*Future<String?> showImageOptionDialog() async {
  Get.focusScope?.unfocus();
  return await showDialog(
    context: Get.context!,
    barrierDismissible: true,
    builder: (BuildContext con) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Image From?',
                style: TextStyle(
                    fontSize: 16,
                    color: blackColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async{

                      var status=await Permission.camera.request();
                      if (status.isDenied || status.isPermanentlyDenied) {
                        showToastMsg('Camera Permission Required');
                        openAppSettings();
                        return;
                      }

                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.camera,imageQuality: 50);

                      if (pickedFile != null) {
                        Get.back(result: pickedFile.path);
                      } else {}
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Camera',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () async {

                      var status=await Permission.photos.request();
                      if (status.isDenied || status.isPermanentlyDenied) {
                        showToastMsg('Galley Permission Required');
                        openAppSettings();
                        return;
                      }

                      final picker = ImagePicker();
                      final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery,imageQuality: 50);

                      if (pickedFile != null) {
                        Get.back(result: pickedFile.path);
                      } else {}
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    child: const Text('Gallery',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: whiteColor)),
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}*/

