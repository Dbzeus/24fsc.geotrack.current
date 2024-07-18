import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_svg/svg.dart';

import 'package:geotrack24fsc/helpers/colors.dart';
import 'package:geotrack24fsc/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:slider_button/slider_button.dart';

import '../../routes/app_routes.dart';
import '../../utils/services.dart';
import '../../utils/session.dart';
import 'history.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  final controller = Get.put(HomeController());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.onClose();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Column(
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  "assets/topbar/topbar.svg",
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  bottom: 0,
                  top: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.profile);
                        },
                        child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: blackColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.line_weight_sharp,
                              color: whiteColor,
                            )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome",
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: blackColor,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  "${controller.userName.value} ",
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: blackColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {},
                            child: Container(
                              width: 60,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(16),
                                  image: const DecorationImage(
                                      fit: BoxFit.contain,
                                      image: const AssetImage(
                                        "assets/logo/24FSC.png",
                                      ))),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Obx(
                            () => Text(
                              "version: ${controller.version.value}",
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Obx(
              () => controller.isLoading.value
                  ? const Expanded(
                      child: Center(child: CircularProgressIndicator()))
                  : Expanded(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Your TimeLine\'s',
                                          style: TextStyle(
                                              color: blackColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 2),
                                      Obx(() => InkWell(
                                            onTap: () =>
                                                controller.changeDate(),
                                            child: Text(
                                                '${controller.currentDate}',
                                                style: const TextStyle(
                                                    color: secondaryColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        controller.getTimeline();

                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: secondaryColor,
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: const Row(
                                          children: [
                                            Text(
                                              "Refresh",
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 12),
                                            ),
                                            Icon(
                                              Icons.refresh_outlined,
                                              size: 20,
                                              color: whiteColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    GestureDetector(
                                      onTap: () async {},
                                      child: const Icon(
                                        Icons.circle_notifications,
                                        size: 34,
                                        color: secondaryColor,
                                      ),
                                    ),
                                    // IconButton(
                                    //     onPressed: () async {
                                    //       var res = await FlutterBackgroundService().isRunning();
                                    //       debugPrint("Service time in service: ${res.toString()}");
                                    //       // if (await FlutterBackgroundService().isRunning()) {
                                    //       //   FlutterBackgroundService().invoke('stopService');
                                    //       // controller.box.write(Session.isRunnerCancelling, false);
                                    //       // }
                                    //     },
                                    //     icon:
                                    //         Icon(Icons.accessibility_new_sharp))
                                  ],
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Obx(
                            () => controller.timelines.isEmpty
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Obx(
                                        () => Text(
                                          controller.msg.value,
                                          style: const TextStyle(
                                              color: secondaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: SizedBox(
                                      // height: MediaQuery.of(context).size.height *
                                      //     0.65,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(0),
                                          itemCount:
                                              controller.timelines.length,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return HistoryView(
                                              index,
                                              controller.timelines.length,
                                              controller.timelines[index],
                                            );
                                          }),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => controller.isLoading.value
              ? const SizedBox.shrink()
              : Container(
                  height: 90,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: SliderButton(
                      width: MediaQuery.of(context).size.width * 0.9,
                      shimmer: false,
                      action: () async {
                        await controller
                            .changeStatus(controller.settings.value!);

                        ///Do something here OnSlide
                        return controller.isCanceled.value;
                      },
                      backgroundColor: whiteColor,
                      /* HexColor.fromHex(
                        controller.settings.value!.status.first.colorCode),*/
                      label: Center(
                        child: Obx(
                          () => Text(
                            controller.settings.value?.status.first.geoStatus ??
                                "",
                            style: const TextStyle(
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      icon: Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: primaryColor),
                        child: const Icon(
                          Icons.double_arrow_outlined,
                          color: whiteColor,
                          size: 24,
                        ),
                      )),
                ),
        ),
      ),
    );
  }
}
