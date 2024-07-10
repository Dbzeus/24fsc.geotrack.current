import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotrack24fsc/screens/performance_report/performance_report_controller.dart';


import 'package:get/get.dart';

import '../../helpers/colors.dart';
import '../../routes/app_routes.dart';
import '../../utils/constants.dart';

class PerformanceReportScreen extends GetView<PerformanceReportController> {
  PerformanceReportScreen({super.key});

  @override
  final controller = Get.put(PerformanceReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(
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
                const SizedBox(
                  width: 40,
                ),
                const Text(
                  "Performance Report",
                  style: TextStyle(
                    fontSize: 16,
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Performance Report",
                  style: TextStyle(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(() => InkWell(
                  onTap: () => controller.changeDate(),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: primaryColor,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text('${controller.currentDate}',
                          style: const TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 8,
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
                            /*controller.getVisitingReport(
                                date:
                                "${controller.days[index].month}/${controller.days[index].day}/${controller.days[index].year}");*/
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
              height: 16,
            ),
            AspectRatio(
                aspectRatio: 1.6,
                child: PieChart(
                  PieChartData(
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: showingSections(),
                      startDegreeOffset: 180),
                  swapAnimationDuration:
                  const Duration(milliseconds: 150), // Optional
                  swapAnimationCurve: Curves.bounceIn, // Optional
                ),
              ),

            Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 6, bottom: 6),
                  child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: 4,
                      itemBuilder: (_, index) {
                        //num colorPos = index % colors.length;
                        return _listItem(/*controller.list[index],
                            colors[colorPos][0], colors[colorPos][1]*/);
                      }),
                ),
              ),

          ],
        ),
      ),
    );
  }
}

_listItem(
   /* Attrition item,
    Color color1,
    Color color2,*/
    ) {
  return InkWell(
    onTap: () {
     Get.toNamed(Routes.employeeReport);
    },
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.3, 1],
            colors: [
              primaryColor,
              lightBgGreenColor
            ]),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: const Offset(
              2,
              2,
            ),
            blurRadius: 3,
            spreadRadius: 1,
          ), //BoxShadow//BoxShadow
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "8",//'${item.result}',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(
              "No.of.present",//item.description,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
          ),
        ],
      ),
    ),
  );
}

List<PieChartSectionData> showingSections() {
  return List.generate(2, (index) {
    if (index != 0) {
      //num colorPos = index % colors.length;
      //double value = ((lists[index].result / lists[0].result) * 100);
    //  int val = value.round();
      //debugPrint('var $value $val');
      return PieChartSectionData(
        color: Colors.red,//colors[colorPos][0],
        value: 2,
        title: '8',
        radius: 50,
        titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff)),
      );
    } else {
      return PieChartSectionData(value: 0);
    }
  });
}
