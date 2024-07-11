import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotrack24fsc/models/DashboardResponse.dart';
import 'package:geotrack24fsc/screens/dashboard/dashboard_controller.dart';
import 'package:geotrack24fsc/utils/constants.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../helpers/colors.dart';
import '../../widgets/timeline_view.dart';
import '../home/history.dart';

class DashboardScreen extends GetView<DashboardController> {
  DashboardScreen({super.key});

  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      "Dashboard",
                      style: TextStyle(
                        fontSize: 16,
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => controller.isLoading.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: const Center(child: CircularProgressIndicator()))
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Monthly Report",
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
                         controller.argData ==null? Container(
                            width: Get.width,
                            padding: const EdgeInsets.all(8),
                            margin:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: const BoxDecoration(
                                color: lightBgGreenColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Obx(
                              () => controller.data.value!.loginDetails.isEmpty
                                  ? const Center(
                                      child: Text(
                                      "No records ",
                                      style: TextStyle(
                                        color: secondaryColor,
                                      ),
                                    ))
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Obx(
                                          () => Text(
                                            controller.data.value?.loginDetails
                                                        .first.employeeName ==
                                                    null
                                                ? ""
                                                : controller
                                                    .data
                                                    .value!
                                                    .loginDetails
                                                    .first
                                                    .employeeName,
                                            style: const TextStyle(
                                                color: blackColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        /*const Text(
                                                          controller.data.value!.loginDetails.first.m,
                                                          // '${controller.data.value!.roleName.trim()} - ${controller.data.value!.locationName.trim()}',
                                                          style: TextStyle(
                                color: blackColor, fontWeight: FontWeight.w500),
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),*/
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Obx(
                                              () => _buildSeperator(
                                                'No.of days',
                                                controller
                                                    .data
                                                    .value!
                                                    .loginDetails
                                                    .first
                                                    .workingDays
                                                    .toString(),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                              child: VerticalDivider(
                                                color: dividerColor,
                                                thickness: 1,
                                              ),
                                            ),
                                            //'${controller.data.value!.workingDays}'),
                                            Obx(
                                              () => _buildSeperator(
                                                  '      Present',
                                                  controller
                                                      .data
                                                      .value!
                                                      .loginDetails
                                                      .first
                                                      .present
                                                      .toString()),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                              child: VerticalDivider(
                                                color: dividerColor,
                                                thickness: 1,
                                              ),
                                            ),

                                            ///  '${controller.data.value!.present}'),
                                            Obx(
                                              () => _buildSeperator(
                                                  'Missed\nPunch',
                                                  controller
                                                      .data
                                                      .value!
                                                      .loginDetails
                                                      .first
                                                      .missedPunch
                                                      .toString()),
                                            )
                                            //'${controller.data.value!.missedPunch}'),
                                          ],
                                        ),
                                        const Divider(
                                          color: dividerColor,
                                          thickness: 1,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Obx(
                                              () => _buildSeperator2(
                                                'Running\nKM',
                                                controller
                                                    .data
                                                    .value!
                                                    .loginDetails
                                                    .first
                                                    .conveyanceKM
                                                    .toString(),
                                                "",
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                              child: VerticalDivider(
                                                color: dividerColor,
                                                thickness: 1,
                                              ),
                                            ),
                                            //controller.data.value!.convUrl),
                                            Obx(
                                              () => _buildSeperator(
                                                  'Working\nHours',
                                                  controller
                                                      .data
                                                      .value!
                                                      .loginDetails
                                                      .first
                                                      .workingHours
                                                      .toString()),
                                            ),
                                            // controller
                                            //     .data.value!.workingHours),

                                            //controller.data.value!.otHours),
                                            const SizedBox(
                                              height: 30,
                                              child: VerticalDivider(
                                                color: dividerColor,
                                                thickness: 1,
                                              ),
                                            ),
                                            Obx(
                                              () => _buildSeperator(
                                                  'No of\nSunday',
                                                  controller
                                                      .data
                                                      .value!
                                                      .loginDetails
                                                      .first
                                                      .noofSunday
                                                      .toString()),
                                            ),
                                            //'${controller.data.value!.noofSunday}'),
                                          ],
                                        ),
                                      ],
                                    ),
                            ),
                          ) : const SizedBox.shrink(),
                          const SizedBox(
                            height: 8,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            controller: ScrollController(
                              debugLabel: "Demo",
                              initialScrollOffset:
                                  controller.isSelectedDate.value < 10
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
                                  children: List.generate(
                                      controller.days.length, (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        debugPrint(
                                            "position: ${controller.isSelectedDate.value * 60}");
                                        if (controller.days[index]
                                            .isBefore(DateTime.now())) {
                                          controller.getDashboard(
                                            date:
                                                "${controller.days[index].month}/${controller.days[index].day}/${controller.days[index].year}",
                                          );
                                          controller.isSelectedDate(
                                              controller.days[index].day);
                                        } else {
                                          showToastMsg(
                                              "Please Don't select  Upcoming dates");
                                        }
                                      },
                                      child: Container(
                                        height:
                                            (controller.isSelectedDate.value -
                                                        1) ==
                                                    index
                                                ? 100
                                                : 80,
                                        width:
                                            (controller.isSelectedDate.value -
                                                        1) ==
                                                    index
                                                ? 70
                                                : 60,
                                        margin: const EdgeInsets.only(left: 8),
                                        decoration: BoxDecoration(
                                            color: (controller.isSelectedDate
                                                            .value -
                                                        1) ==
                                                    index
                                                ? secondaryColor
                                                : fillColor,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            border: Border.all(
                                              color: borderColor,
                                            )),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              controller
                                                  .getDayOfWeek(DateTime(
                                                    controller.days[index].year,
                                                    controller
                                                        .days[index].month,
                                                    controller.days[index].day,
                                                  ))
                                                  .substring(0, 3),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: (controller
                                                                .isSelectedDate
                                                                .value -
                                                            1) ==
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
                                              controller.days[index].day
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: (controller
                                                                .isSelectedDate
                                                                .value -
                                                            1) ==
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
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: boxShadow),
                            child: Obx(
                              () => controller.data.value!.timeLine.isEmpty
                                  ? const Center(
                                      child: Text(
                                      "No Activity records ",
                                      style: TextStyle(
                                        color: secondaryColor,
                                      ),
                                    ))
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Obx(
                                          () => Text(
                                            controller.date.isEmpty
                                                ? "Activity "
                                                : "${controller.date}  Activity",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Working hours",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: blackColor,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.timer_outlined,
                                                  color: secondaryColor,
                                                  size: 22,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Obx(
                                                  () => Text(
                                                    controller
                                                        .data
                                                        .value!
                                                        .loginDetails
                                                        .first
                                                        .workingHours
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: blackColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor:
                                                      secondaryColor
                                                          .withAlpha(50),
                                                  child: const CircleAvatar(
                                                    backgroundColor:
                                                        secondaryColor,
                                                    radius: 15,
                                                    child: Icon(Icons.login,
                                                        size: 14,
                                                        color: whiteColor),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Obx(
                                                  () => Text(
                                                    controller
                                                        .data
                                                        .value!
                                                        .dateDetails
                                                        .first
                                                        .loginTime
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: blackColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 50,
                                              child: Divider(
                                                color: secondaryColor,
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor:
                                                      secondaryColor
                                                          .withAlpha(50),
                                                  child: const CircleAvatar(
                                                    backgroundColor:
                                                        secondaryColor,
                                                    radius: 15,
                                                    child: Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        size: 14,
                                                        color: whiteColor),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Obx(
                                                  () => Text(
                                                    "${controller.data.value!
                                                        .dateDetails.first.km} km",
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: blackColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 50,
                                              child: Divider(
                                                color: secondaryColor,
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor:
                                                      secondaryColor
                                                          .withAlpha(50),
                                                  child: const CircleAvatar(
                                                    backgroundColor:
                                                        secondaryColor,
                                                    radius: 15,
                                                    child: Icon(Icons.logout,
                                                        size: 14,
                                                        color: whiteColor),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Obx(
                                                  () => Text(
                                                    controller
                                                        .data
                                                        .value!
                                                        .dateDetails
                                                        .first
                                                        .logoutTime
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: blackColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 16),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: boxShadow),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Timeline",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Divider(
                                  color: dividerColor,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildIndicator(
                                            'Login', secondaryColor),
                                        _buildIndicator(
                                            'Fetched', primaryColor),
                                        _buildIndicator(
                                            'Not Fetched', Colors.orange),
                                        _buildIndicator('Logout', Colors.red),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Obx(() =>
                                        controller.data.value!.timeLine.isEmpty
                                            ? const Center(
                                                child: Text(
                                                "No records ",
                                                style: TextStyle(
                                                  color: secondaryColor,
                                                ),
                                              ))
                                            : Column(
                                                children: List.generate(
                                                    controller
                                                        .data
                                                        .value!
                                                        .timeLine
                                                        .length, (index) {
                                                  return TimelineView(
                                                      index,
                                                      controller.data.value!
                                                          .timeLine.length,
                                                      controller.data.value!
                                                          .timeLine[index]);
                                                }),
                                              )

                                    /*GridView.builder(
                                          itemCount: controller
                                              .data.value!.timeLine.length,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            childAspectRatio: 1.3,
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 0,
                                          ),
                                          itemBuilder: (_, index) {
                                            return buildTimeline(
                                              index,
                                              controller
                                                  .data.value!.timeLine.length,
                                              controller
                                                  .data.value!.timeLine[index],
                                            );
                                          })*/
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

_buildSeperator(String title, String value) {
  return SizedBox(
    width: MediaQuery.of(Get.context!).size.width * 0.2,
    child: Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: blackColor,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          value,
          style: const TextStyle(
            color: secondaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

_buildIndicator(String title, Color c) {
  return Row(
    children: [
      Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: c,
        ),
      ),
      const SizedBox(
        width: 4,
      ),
      Text(
        title,
        style: TextStyle(color: c, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    ],
  );
}

_buildSeperator2(String title, String value, String url) {
  return SizedBox(
    width: MediaQuery.of(Get.context!).size.width * 0.2,
    child: Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: blackColor, fontSize: 13, fontWeight: FontWeight.w500),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                  color: blackColor, fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 12,
            ),
            /*InkWell(
                // onTap: () => launchURLExternal(url),
                child: const Icon(
                  Icons.picture_as_pdf_rounded,
                  size: 20,
                  color: blackColor,
                ))*/
          ],
        ),
      ],
    ),
  );
}

buildTimeline(int index, int length, TimeLine timeLine) {
  return TimelineTile(
    alignment: TimelineAlign.manual,
    lineXY: 0.23,
    isFirst: index == 0,
    axis: TimelineAxis.horizontal,
    isLast: index == (length - 1),
    indicatorStyle: IndicatorStyle(
        height: 40,
        width: 40,
        indicator: Container(
          decoration: BoxDecoration(
              color: secondaryColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue.shade100, width: 6)),
        )),
    afterLineStyle: const LineStyle(thickness: 1, color: secondaryColor),
    beforeLineStyle: const LineStyle(thickness: 1, color: secondaryColor),
    endChild: Text(
      timeLine.statusTime,
      style: const TextStyle(
        fontSize: 10,
        color: blackColor,
      ),
    ),
  );
}
