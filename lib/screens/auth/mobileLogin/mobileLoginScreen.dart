import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotrack24fsc/helpers/colors.dart';
import 'package:geotrack24fsc/routes/app_routes.dart';
import 'package:geotrack24fsc/screens/auth/mobileLogin/mobileLogincontroller.dart';
import 'package:geotrack24fsc/screens/auth/mobileLogin/privacy_policy.dart';
import 'package:geotrack24fsc/widgets/custom_button.dart';
import 'package:get/get.dart';

import '../../../utils/location_permission.dart';
import '../../../widgets/custom_edittext.dart';

class MobileLoginScreen extends GetView<MobileLoginController> {
  MobileLoginScreen({super.key});

  @override
  final controller = Get.put(MobileLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [

          Image.asset(
            "assets/logo/24FSC.png"
          ),
          SvgPicture.asset(
            "assets/topbar/bg.svg",
            width: double.infinity,
            //height: MediaQuery.of(context).size.height,
            //width: 500,//MediaQuery.of(context).size.width,
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
                    "Verification",
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Elevate productivity and morale by granting your team the tools and autonomy to thrive.",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomEditText(
                    controller: controller.mobNoController,
                    hintText: "Mobile Number",
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    suffixIcon: const Icon(
                      Icons.call_rounded,
                      color: blackColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => CustomEditText(
                      controller: controller.passwordController,
                      hintText: "Password",
                      obscureText: controller.isSecure.value,
                      keyboardType: TextInputType.number,
                      suffixIcon: InkWell(
                        onTap: () => controller.passwordToggle(),
                        child: Icon(
                          controller.passwordIcon.value,
                          size: 18,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ),
                 /* const SizedBox(
                    height: 16,
                  ),
                  Obx(() => CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: controller.isCheck.value,
                        onChanged: (val) {
                          controller.isCheck(val);
                          debugPrint("Check:${controller.isCheck.value.toString()}");
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        dense: true,
                        subtitle: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.privacy);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: const TextSpan(
                                      text: "I have read and agreed to ",
                                      style: TextStyle(
                                        fontSize: 12,

                                        color: Colors.grey,
                                      ),
                                      children: [
                                    TextSpan(
                                      text:
                                          "Terms of Service ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                        TextSpan(
                                          text:
                                          "and",
                                          style: TextStyle(
                                            fontSize: 12,

                                            color: Colors.grey,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                          " Privacy Policy",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        )
                                  ])),
                            ],
                          ),
                        ),
                      )),*/
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                      text: "verify",
                      onTap: () async {
                        if(controller.collectDataEnable == false){
                          controller.dataDialog();
                        }else{
                          var res = await checkLocationPermission1();
                          if (res) {
                            controller.login();
                          } else {
                            var res = await checkLocationPermission1();
                            if (res) {
                              controller.login();
                            }
                          }
                        }
                      }),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
