import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotrack24fsc/routes/app_routes.dart';
import 'package:geotrack24fsc/screens/auth/verification/verificationController.dart';
import 'package:get/get.dart';

import '../../../helpers/colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_edittext.dart';

class VerificationScreen extends GetView<VerificationController> {
   VerificationScreen({super.key});

  @override
  final controller = Get.put(VerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SvgPicture.asset(
            "assets/topbar/bg.svg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32))),
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "One Time Password",
                    style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: secondaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "OTP Is sent in +91 *******24",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customOTPField(
                          first: true,
                          last: false,
                          controller: controller.fieldOne),
                      const SizedBox(
                        width: 20,
                      ),
                      _customOTPField(
                          first: false,
                          last: false,
                          controller: controller.fieldTwo),
                      const SizedBox(
                        width: 20,
                      ),
                      _customOTPField(
                          first: false,
                          last: false,
                          controller: controller.fieldThree),
                      const SizedBox(
                        width: 20,
                      ),
                      _customOTPField(
                          first: false,
                          last: false,
                          controller: controller.fieldFour),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomButton(text: "verify", onTap: (){
                    controller.backgroundLocationFetch();
                    Get.toNamed(Routes.home);


                  }),
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 50,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: fillColor,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer_outlined, color: Colors.black, size: 14),
                            const SizedBox(
                              width: 4,
                            ),
                            Obx(()=>
                                Text(
                                  "00 : ${controller.seconds.value.toString()}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                        text: const TextSpan(
                            text: "Didn’t receive the OTP? ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(
                                text: " Resend OTP",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              )
                            ])),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

_customOTPField({bool? first, last, TextEditingController? controller}) {
  return Expanded(
    child: CustomEditText(
      controller: controller,
      hintText: '',
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      showCursor: false,

      /*style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),*/
      onChanged: (value) {
        if (value.length == 1 && last == false) {
          Get.focusScope?.nextFocus();
        }
        if (value.isEmpty && first == false) {
          Get.focusScope?.previousFocus();
        }
      },
    ),
  );
}
