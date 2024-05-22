import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotrack24fsc/screens/activities/activities_controller.dart';
import 'package:get/get.dart';

import '../../helpers/colors.dart';

class ActivitiesScreen extends GetView<ActivitiesController> {
   ActivitiesScreen({super.key});

  @override
  final controller = Get.put(ActivitiesController());

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
                    "Activities",
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
                    "Activities",
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
        const SizedBox(
          height: 10,
        ),
        Container(
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
          child:
            Row(
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
                    Text(
                      "09.00 am",
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: 40,
                    child: VerticalDivider()),
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
                      "06.00 pm",
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: 40,
                    child: VerticalDivider()),
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
                      "30 km",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

              ],

            )
        ),


            ],
          ),
        ),
      ),
    );
  }
}
