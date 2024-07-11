import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotrack24fsc/screens/activities/activities_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../helpers/colors.dart';
import '../../utils/constants.dart';

class ActivitiesScreen extends GetView<ActivitiesController> {
  ActivitiesScreen({super.key});

  @override
  final controller = Get.put(ActivitiesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: blackColor,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/back.svg",
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Text(
                    "Activities",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Obx(()=>
            controller.isLoading.value
                ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: const Center(child: CircularProgressIndicator()))
                :  Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Activities",
                          style: TextStyle(
                            fontSize: 18,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Obx(() => InkWell(
                              onTap: () => controller.changeMonth(),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: primaryColor,
                                    size: 14,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(controller.selectedMonth.value,
                                      style: const TextStyle(
                                          color: primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    controller: ScrollController(
                      initialScrollOffset:   controller.isSelectedDate.value < 10
                          ? controller.isSelectedDate.value == 1
                          ? controller.isSelectedDate.value * 1
                          : controller.isSelectedDate.value * 30
                          : controller.isSelectedDate.value * 60,
                      keepScrollOffset: true,
                    ),
                    child: SizedBox(
                      height: 130,
                      child: Obx(
                        () => Row(
                          children: List.generate(controller.days.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                if (controller.days[index].isBefore(DateTime.now())) {
                                  controller.getDashboard(
                                    date:
                                        "${controller.days[index].month}/${controller.days[index].day}/${controller.days[index].year}",
                                  );
                                  controller
                                      .isSelectedDate(controller.days[index].day);
                                } else {
                                  showToastMsg("Please Don't select  Upcoming dates");
                                }
                              },
                              child: Container(
                                height: (controller.isSelectedDate.value - 1) == index
                                    ? 100
                                    : 80,
                                width: (controller.isSelectedDate.value - 1) == index
                                    ? 70
                                    : 60,
                                margin: const EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                    color:
                                        (controller.isSelectedDate.value - 1) == index
                                            ? secondaryColor
                                            : fillColor,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: borderColor,
                                    )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller
                                          .getDayOfWeek(DateTime(
                                            controller.days[index].year,
                                            controller.days[index].month,
                                            controller.days[index].day,
                                          ))
                                          .substring(0, 3),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            (controller.isSelectedDate.value - 1) ==
                                                    index
                                                ? whiteColor
                                                : blackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      controller.days[index].day.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            (controller.isSelectedDate.value - 1) ==
                                                    index
                                                ? whiteColor
                                                : blackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.704,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          top: 35,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.height* 0.65,
                            width: double.infinity,
                            margin: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: borderColor
                              )
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Obx(()=>
                                 GoogleMap(
                                    myLocationEnabled: false,
                                    compassEnabled: true,
                                    tiltGesturesEnabled: false,
                                    markers: controller.markers.value,
                                    polylines: controller.polylines.value,
                                    mapType: MapType.normal,
                                    initialCameraPosition:
                                        controller.initialLocation.value,
                                    onMapCreated: controller.onMapCreated),
                              ),
                            ),
                          ),
                        ),
                        Obx(()=>
                           Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: boxShadow),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Login",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: blackColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Obx(()=>
                                           Text(
                                            controller
                                                .data
                                                .value!
                                                .dateDetails
                                                .first
                                                .loginTime
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: secondaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 40, child: VerticalDivider()),
                                    Column(
                                      children: [
                                        Text(
                                          "Logout",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: blackColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          controller
                                              .data
                                              .value!
                                              .dateDetails
                                              .first
                                              .logoutTime
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: secondaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 40, child: VerticalDivider()),
                                    Column(
                                      children: [
                                        Text(
                                          "Distance",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: blackColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          controller
                                              .data
                                              .value!
                                              .dateDetails
                                              .first
                                              .km
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
