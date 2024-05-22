import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotrack24fsc/screens/dashboard/dashboard_controller.dart';
import 'package:get/get.dart';

import '../../helpers/colors.dart';

class DashboardScreen extends GetView<DashboardController> {
  DashboardScreen({super.key});

  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
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
                      "Dashboard",
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
                      "Monthly Report",
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
                  height: 16,
                ),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(
                      top: 0, left: 8, right: 8, bottom: 8),
                  decoration: const BoxDecoration(
                      color: lightBgGreenColor,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Dinesh", // controller.data.value!.employeeName,
                        style: TextStyle(
                            color: blackColor, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      const Text(
                        "9898989978",
                        // '${controller.data.value!.roleName.trim()} - ${controller.data.value!.locationName.trim()}',
                        style: TextStyle(
                            color: blackColor, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSeperator('No.of days', "10"),
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(),
                          ), //'${controller.data.value!.workingDays}'),
                          _buildSeperator('Present', "10"),
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(),
                          ),

                          ///  '${controller.data.value!.present}'),
                          _buildSeperator('MissedPunch',
                              "10"), //'${controller.data.value!.missedPunch}'),
                        ],
                      ),
                      const Divider(
                        color: blackColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSeperator2(
                              'Running\nKM',
                              "10 km" //'${controller.data.value!.conveyanceKM}',
                                  "",
                              ""),
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(),
                          ),
                          //controller.data.value!.convUrl),
                          _buildSeperator('Working\nHours', "10"),
                          // controller
                          //     .data.value!.workingHours),

                          //controller.data.value!.otHours),
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(),
                          ),
                          _buildSeperator('No of\nHoliday', "10"),
                          //'${controller.data.value!.noofSunday}'),
                        ],
                      ),
                    ],
                  ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2,
                            offset: Offset(3, 2)),
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(3, 5)),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Activity",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Working hours",
                            style: TextStyle(
                              fontSize: 12,
                              color: blackColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                color: secondaryColor,
                                size: 22,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "9h 00min",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: blackColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: secondaryColor.withAlpha(50),
                                child: const CircleAvatar(
                                  backgroundColor: secondaryColor,
                                  radius: 15,
                                  child: Icon(Icons.login,
                                      size: 14, color: whiteColor),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                "09.30 am",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: blackColor,
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
                                backgroundColor: secondaryColor.withAlpha(50),
                                child: const CircleAvatar(
                                  backgroundColor: secondaryColor,
                                  radius: 15,
                                  child: Icon(Icons.location_on_outlined,
                                      size: 14, color: whiteColor),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                "15 km",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: blackColor,
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
                                backgroundColor: secondaryColor.withAlpha(50),
                                child: const CircleAvatar(
                                  backgroundColor: secondaryColor,
                                  radius: 15,
                                  child: Icon(Icons.logout,
                                      size: 14, color: whiteColor),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                "06.30 pm",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2,
                            offset: Offset(3, 2)),
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(3, 5)),
                      ]),
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
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: secondaryColor.withAlpha(50),
                                child: const CircleAvatar(
                                  backgroundColor: secondaryColor,
                                  radius: 15,

                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                "09.30 am",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                            child: Divider(
                              color: secondaryColor,
                            ),
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: secondaryColor.withAlpha(50),
                                child: const CircleAvatar(
                                  backgroundColor: secondaryColor,
                                  radius: 15,

                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                "10.30 am",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                            child: Divider(
                              color: secondaryColor,
                            ),
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: secondaryColor.withAlpha(50),
                                child: const CircleAvatar(
                                  backgroundColor: secondaryColor,
                                  radius: 15,

                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                "11.30 am",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                            child: Divider(
                              color: secondaryColor,
                            ),
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: secondaryColor.withAlpha(50),
                                child: const CircleAvatar(
                                  backgroundColor: secondaryColor,
                                  radius: 15,

                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                "12.30 am",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: blackColor,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: secondaryColor.withAlpha(50),
                                child: const CircleAvatar(
                                  backgroundColor: secondaryColor,
                                  radius: 15,

                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                "09.30 am",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                            child: Divider(
                              color: secondaryColor,
                            ),
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: secondaryColor.withAlpha(50),
                                child: const CircleAvatar(
                                  backgroundColor: secondaryColor,
                                  radius: 15,

                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                "10.30 am",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                            child: Divider(
                              color: secondaryColor,
                            ),
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: secondaryColor.withAlpha(50),
                                child: const CircleAvatar(
                                  backgroundColor: secondaryColor,
                                  radius: 15,

                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                "11.30 am",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                            child: Divider(
                              color: secondaryColor,
                            ),
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: secondaryColor.withAlpha(50),
                                child: const CircleAvatar(
                                  backgroundColor: secondaryColor,
                                  radius: 15,

                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                "12.30 am",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
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
                              _buildIndicator('Fetched', primaryColor),
                              _buildIndicator('Not Fetched', Colors.orange),
                              _buildIndicator(
                                  'Logout', Colors.red),


                            ],
                          ),
                                                  ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_buildSeperator(String title, String value) {
  return Column(
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
  );
}


_buildIndicator(String title, Color c) {
  return Row(
    children: [
      Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: c, ),
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
  return Column(
    children: [
      Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: blackColor, fontSize: 13, fontWeight: FontWeight.w500),
      ),
      Row(
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
  );
}
