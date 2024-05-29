import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotrack24fsc/models/MenuResponse.dart';
import 'package:geotrack24fsc/routes/app_routes.dart';
import 'package:geotrack24fsc/screens/profile/profile_screen_controller.dart';
import 'package:get/get.dart';

import '../../helpers/colors.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  ProfileScreen({super.key});

  @override
  final controller = Get.put(ProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: bgGradientColor),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.28,
                    ),
                    const Text(
                      "Profile",
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
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      color: whiteColor,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey),
                            image: const DecorationImage(
                                fit: BoxFit.scaleDown,
                                image: AssetImage(
                                  "assets/logo/24FSC.png",
                                ))),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.name.value,
                              style: TextStyle(
                                color: blackColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  controller.designation.value,
                                  style: TextStyle(
                                      color: blackColor, letterSpacing: 1),
                                ),
                                Text(
                                  ' ~ ',
                                  style: TextStyle(
                                      color: blackColor,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 3),
                                ),
                                Expanded(
                                  child: Text(
                                    controller.role.value,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: blackColor, letterSpacing: 1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.appLogout(isHaveDialog: true);
                        },
                        child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: blackColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.logout_rounded,
                              color: whiteColor,
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.menu1.length,
                        itemBuilder: (_, index) {
                          return buildMainMenu(controller.menu1[index]);
                        }),
                  ),
                ),

                /* const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Admin",
                  style: TextStyle(
                    fontSize: 16,
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  color: blackColor.withAlpha(30),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.performanceReport);
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: whiteColor,
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
                        child: SvgPicture.asset(
                          "assets/menu/performancereport.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Performance\nReport",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildMainMenu(Menu menu) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          menu.mainMenu,
          style: TextStyle(
            fontSize: 16,
            color: blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Divider(
          color: blackColor.withAlpha(30),
        ),
        const SizedBox(
          height: 8,
        ),
        GridView.builder(
            itemCount: menu.subMenu.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.05,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (_, index) {
              return buildSubMenu(menu.subMenu[index]);
            }),
      ],
    );
  }

  buildSubMenu(SubMenu subMenu) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(subMenu.action.toString().removeAllWhitespace);
      },
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: boxShadow),
            child: CachedNetworkImage(
              imageUrl: subMenu.icon,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Text(
              subMenu.title, // controller.menus[index]['title'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
