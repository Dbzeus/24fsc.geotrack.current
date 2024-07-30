import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotrack24fsc/screens/Employee_report/employee_report_controller.dart';
import 'package:get/get.dart';

import '../../helpers/colors.dart';
import '../../models/staff_report_response.dart';
import '../../routes/app_routes.dart';
import '../../utils/constants.dart';

class EmployeeReportScreen extends GetView<EmployeeReportController> {
  EmployeeReportScreen({super.key});

  @override
  final controller = Get.put(EmployeeReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
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
                    "Employee Report",
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
                                  "Employee Report",
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
                                          Text(
                                              '${controller.selectedMonth.value}',
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
                                          controller.staffReport(
                                              date:
                                                  "${controller.days[index].month}/${controller.days[index].day}/${controller.days[index].year}");
                                          controller.selected =
                                              controller.days[index];
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
                            () => Expanded(
                              child: controller.data.isEmpty
                                  ? const Center(
                                      child: Text(
                                        "No records ",
                                        style: TextStyle(
                                            color: secondaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      scrollDirection: Axis.vertical,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: controller.data.length,
                                      itemBuilder: (_, index) {
                                        return _buildList(
                                            controller.data[index]);
                                      }),
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _buildList(StaffReportData data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 2, offset: Offset(3, 2)),
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(3, 5)),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.firstName,
                style: const TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color:
                  data.isLogin ? primaryColor.withAlpha(100) : Colors.red,
                ),
                child: Center(
                  child: Text(data.isLogin ? "Present" : "Absent",
                      style: TextStyle(
                          fontSize: 8,
                          color: data.isLogin ? blackColor : whiteColor,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          data.location.isEmpty
              ? const SizedBox.shrink()
              : Text(
                  data.location,
                  style: const TextStyle(
                    fontSize: 12,
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          const SizedBox(
            height: 4,
          ),
          InkWell(
            onTap: () => call(data.mobileNo),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.call,
                      color: secondaryColor,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      data.mobileNo,
                      style: const TextStyle(
                          fontSize: 12,
                          color: secondaryColor,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              data.isLogin ? Row(
                children: [
                  const Icon(
                    Icons.timer_outlined,
                    color: primaryColor,
                    size: 14,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "${data.loginTime}-${data.cheInTime}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: blackColor,
                    ),
                  ),
                ],
              ) : const SizedBox.shrink(),

            ],
          ),
          data.isLogin ?const SizedBox(
            height: 8,
          ):const SizedBox(),
          data.isLogin
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Map<String, dynamic> body = {
                          "data": data,
                          "date": controller.selected
                        };
                        Get.toNamed(Routes.activities, arguments: body);
                      },
                      child: Container(
                        height: 65,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: fillColor,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/menu/activity.svg",
                                color: secondaryColor,
                                fit: BoxFit.scaleDown,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text("Activity",
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Map<String, dynamic> body = {
                          "data": data,
                          "date": controller.selected
                        };
                        Get.toNamed(Routes.visitingReport, arguments: body);
                      },
                      child: Container(
                        height: 65,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: fillColor,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/menu/visitingreport.svg",
                                color: secondaryColor,
                                fit: BoxFit.scaleDown,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text("Visiting report",
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Map<String, dynamic> body = {
                          "data": data,
                          "date": controller.selected
                        };
                        Get.toNamed(Routes.dashboard, arguments: body);
                      },
                      child: Container(
                        height: 65,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: fillColor,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/menu/circular.svg",
                                color: secondaryColor,
                                fit: BoxFit.scaleDown,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text("Dashboard",
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
