import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotrack24fsc/routes/app_routes.dart';
import 'package:geotrack24fsc/screens/reports/visiting_report/visiting_report_controller.dart';
import 'package:get/get.dart';

import '../../../helpers/colors.dart';

class VisitingReportScreen extends GetView<VisitingReportController> {
  VisitingReportScreen({super.key});

  final controller = Get.put(VisitingReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                    "Visiting Report",
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
                    "Visiting Report",
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
                            const Icon(
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
                child: SizedBox(
                  height: 100,
                  child: Row(
                    children:
                        List.generate(controller.daysInMonth.value, (index) {
                      return Container(
                        height: 80,
                        width: 60,
                        margin: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              const BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2,
                                  offset: Offset(3, 2)),
                              const BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(3, 5)),
                            ]),
                        child: const Column(
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
                            SizedBox(
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
                    itemCount: 12,
                    itemBuilder: (_, index) {
                      return _buildList();
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.createReport);
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

  _buildList() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 2, offset: Offset(3, 2)),
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(3, 5)),
          ]),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "24FSC",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.play_circle,
                color: secondaryColor,
                size: 30,
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: secondaryColor,
                    size: 14,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Dinesh",
                    style: TextStyle(
                      fontSize: 12,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
              Text(
                "10-05-2024",
                style: TextStyle(
                  fontSize: 12,
                  color: blackColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.message,
                    color: secondaryColor,
                    size: 14,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "general visit",
                    style: TextStyle(
                      fontSize: 12,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
              Text(
                "09.00 am - 5.00 pm",
                style: TextStyle(
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
