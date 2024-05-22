import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../helpers/colors.dart';
import '../../routes/app_routes.dart';

RxInt pageIndex = 0.obs;

PageController pageController = PageController(initialPage: 0);
RxList<Widget> pages = <Widget>[
  Page(
      image: "assets/onboarding/1.svg",
      title1: "Empower Your\nWorkforce",
      subtitle:
          "Elevate productivity and morale by granting your team the tools and autonomy to thrive.",
      isBack: false),
  Page(
      image: "assets/onboarding/2.svg",
      title1: "Elevate Your\nEfficiency",
      subtitle:
          "Elevate productivity and morale by granting your team the tools and autonomy to thrive.",
      isBack: false),
  Page(
      image: "assets/onboarding/3.svg",
      title1: "Unleash Success\nwith 24FSC!",
      subtitle:
          "Elevate productivity and morale by granting your team the tools and autonomy to thrive.",
      isBack: false),
].obs;

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Obx(
        () => Stack(
          children: [
            PageView.builder(
              itemCount: pages.length,
              scrollDirection: Axis.horizontal,
              controller: pageController,
              physics: const PageScrollPhysics(),
              itemBuilder: (context, index) {
                return pages[index % pages.length];
              },
              onPageChanged: (index) {
                pageIndex(index);
              },
            ),
            Positioned(
              bottom: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Obx(
                        () => Row(
                            children: List.generate(pages.length, (index) {
                          return AnimatedContainer(
                            height: 10,
                            width: pageIndex.value == index ? 30 : 10,
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(50)),
                            duration: const Duration(milliseconds: 500),
                          );
                        })),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (pageIndex.value == (pages.length - 1)) {
                            Get.toNamed(Routes.mobileLogin);
                          } else {
                            pageIndex.value = pageIndex.value + 1;
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.easeOut);
                                                      }
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: whiteColor,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/arrow.svg",
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  String image;
  String title1;
  String subtitle;
  bool isBack;

  Page(
      {required this.image,
      required this.title1,
      required this.subtitle,
      required this.isBack,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          image,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Positioned(
          bottom: 140,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title1,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: whiteColor,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    subtitle,
                    maxLines: 4,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
