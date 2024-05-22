import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotrack24fsc/screens/Employee_report/employee_report_controller.dart';
import 'package:get/get.dart';

import '../../helpers/colors.dart';

class EmployeeReportScreen extends GetView<EmployeeReportController> {
  EmployeeReportScreen({super.key});

  @override
  final controller = Get.put(EmployeeReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
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
                    "Employee Report",
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
                    "Employee Report",
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
                physics: BouncingScrollPhysics(),
                child: SizedBox(
                  height: 100,
                  child: Row(
                    children:
                        List.generate(controller.daysInMonth.value, (index) {
                      return Container(
                        height: 80,
                        width: 60,
                        margin: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2,
                                  offset: const Offset(3, 2)),
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: const Offset(3, 5)),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Fri",
                              style: TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "13",
                              style: TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (_, index) {
                      return _buildList();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

_buildList() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
    decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(3, 2)),
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(3, 5)),
        ]),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "24FSC",
          style: TextStyle(
            fontSize: 12,
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        const Text(
          "Marketing Radiology - Head office",
          style: TextStyle(
            fontSize: 12,
            color: blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.call,
                  color: primaryColor,
                  size: 14,
                ),
                const SizedBox(
                  width: 6,
                ),
                const Text(
                  "9874563215",
                  style: TextStyle(
                    fontSize: 12,
                    color: blackColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.timer_outlined,
                  color: primaryColor,
                  size: 14,
                ),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  "09.00 am - 5.00 pm",
                  style: TextStyle(
                    fontSize: 12,
                    color: blackColor,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6,vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: primaryColor.withAlpha(100),
              ),
              child: Center(
                child: Text("Present",
                    style: TextStyle(
                        fontSize: 8,
                        color: blackColor,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: fillColor,
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/menu/activity.svg",
                  color: secondaryColor,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Container(
              height: 60,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: fillColor,
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/menu/visitingreport.svg",
                  color: secondaryColor,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Container(
              height: 60,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: fillColor,
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/menu/circular.svg",
                  color: secondaryColor,
                  fit: BoxFit.scaleDown,
                ),
              ),
            )
          ],
        ),
      ],
    ),
  );
}
