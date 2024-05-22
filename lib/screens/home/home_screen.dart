import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:geotrack24fsc/helpers/colors.dart';
import 'package:get/get.dart';
import 'package:slider_button/slider_button.dart';

import '../../routes/app_routes.dart';
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
                            child: Icon(
                              Icons.line_weight_sharp,
                              color: whiteColor,
                            )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Center(
                          child: Text(
                            "welcome, ${controller.userName.value}",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: blackColor,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: whiteColor,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.scaleDown,
                                  image: AssetImage(
                                    "assets/logo/24FSC.png",
                                  ))),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Obx(
              () => controller.isLoading.value
                  ? const Expanded(
                      child: Center(child: CircularProgressIndicator()))
                  : Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Your TimeLine\'s',
                                        style: TextStyle(
                                            color: blackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 2),
                                    Obx(() => InkWell(
                                          onTap: () => controller.changeDate(),
                                          child: Text(
                                              '${controller.currentDate}',
                                              style: const TextStyle(
                                                  color: secondaryColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)),
                                        )),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.circle_notifications,
                                  size: 34,
                                  color: secondaryColor,
                                ),
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
                        controller.timelines.isEmpty
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
                            : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.65,

                              child: ListView.builder(
                                  padding: const EdgeInsets.all(0),
                                  itemCount: controller.timelines.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {

                                    return HistoryView(
                                      index,
                                      controller.timelines.length,
                                      controller.timelines[index],
                                    );
                                  }),
                            )
                        // const HistoryView(),
                        // const HistoryView(),
                        // const HistoryView(),
                      ],
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
                      shimmer: false,
                      action: () async {
                        controller.changeStatus(controller.settings.value!);

                        ///Do something here OnSlide
                        return true;
                      },
                      backgroundColor: whiteColor,
                      /* HexColor.fromHex(
                        controller.settings.value!.status.first.colorCode),*/
                      label: Center(
                        child: Obx(
                          () => Text(
                            controller.settings.value!.status.first.geoStatus,
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
