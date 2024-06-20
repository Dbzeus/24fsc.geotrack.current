import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotrack24fsc/routes/app_routes.dart';
import 'package:geotrack24fsc/screens/reports/visiting_report/visiting_report_controller.dart';
import 'package:get/get.dart';

import '../../../helpers/colors.dart';
import '../../../utils/constants.dart';

class VisitingReportScreen extends GetView<VisitingReportController> {
  VisitingReportScreen({super.key});

  final controller = Get.put(VisitingReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Visiting Report",
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
                  : Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Visiting Report",
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
                                          controller.getVisitingReport(
                                              date:
                                                  "${controller.days[index].month}/${controller.days[index].day}/${controller.days[index].year}");
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
                          Obx(
                            () => controller.data.isEmpty
                                ? const SizedBox(
                                    height: 300,
                                    child: Center(
                                      child: Text(
                                        "No records ",
                                        style: TextStyle(
                                            color: secondaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: controller.data.length,
                                        itemBuilder: (_, index) {
                                          return _buildList(
                                              controller.data[index]);
                                        }),
                                  ),
                          ),
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var res = await Get.toNamed(Routes.createReport);
          if (res != null && res == true) {
            controller.getVisitingReport(
                date: DateTime.now().toString().split(" ")[0]);
          }
        },
        backgroundColor: blackColor,
        child: const Icon(
          Icons.contact_page_outlined,
          size: 30,
          color: whiteColor,
        ),
      ),
    );
  }

  _buildList(data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: boxShadow),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  data["ClientName"].toString(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              data["UploadAudio"].toString().isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        controller.sliderValue(0.0);
                        if (data["UploadAudio"].toString().isNotEmpty) {
                          String audioURL = data["UploadAudio"]
                              .toString()
                              .split(",")[0]
                              .trim();
                          controller.audioAlertDialog(audioURL);
                        } else {
                          showToastMsg("No Audio Found");
                        }
                      },
                      child: const Icon(
                        Icons.play_circle,
                        color: secondaryColor,
                        size: 30,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: secondaryColor,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        data["ContactPersonName"].toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                controller.dateFormat
                    .format(DateTime.parse(data["VisitingDate"].split("T")[0])),
                style: const TextStyle(
                  fontSize: 12,
                  color: blackColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.message,
                      color: secondaryColor,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        data["Remarks"].toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                data["VisitingTime"].toString(),
                style: const TextStyle(
                  fontSize: 12,
                  color: blackColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
