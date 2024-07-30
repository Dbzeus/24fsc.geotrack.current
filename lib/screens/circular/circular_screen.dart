import 'package:flutter/material.dart';
import 'package:geotrack24fsc/screens/circular/circular_controller.dart';

import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helpers/colors.dart';
import '../../routes/app_routes.dart';

class CircularScreen extends GetView<CircularController> {
  CircularScreen({super.key});

  @override
  final controller = Get.put(CircularController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back,color: Colors.black,),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Wishes",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
        ),
      ),*/
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    GestureDetector(
                onTap: (){
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
                      "Circular",
                      style: TextStyle(
                        fontSize: 16,
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Center(
                child: Text(
                  "Special Events",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 180,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(5, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              "assets/circular/cardbg.svg",
                              height: 160,
                              width: MediaQuery.of(context).size.width - 50,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 10,
                              child: SvgPicture.asset(
                                "assets/circular/bdayillus.svg",
                                height: 90,
                              ),
                            ),
                            const Positioned(
                              bottom: -20,
                              left: -20,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                AssetImage("assets/circular/image.jpg"),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 0,
                              child: Container(
                                height: 50,
                                width: 40,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight:
                                      Radius.circular(8)),
                                ),
                                child: const Center(
                                  child: Text('jan\n13',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight:
                                          FontWeight.bold)),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 0,
                              right: 0,
                              child: Column(
                                children: [
                                  const Text('Today is Dinesh BirthDay',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Get.toNamed(Routes.circularPhoto);
                                    },
                                    child: Container(
                                      width: 100,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 4),
                                      decoration: BoxDecoration(
                                          color: Colors.blue.shade900,
                                          borderRadius: BorderRadius.circular(12)),
                                      child: const Center(
                                        child: Text("Send wishes",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),

                                ],
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
                height: 16,
              ),
              SizedBox(
                height: 180,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(5, (index) {
                      return Container(
                        height: 160,
                        width: MediaQuery.of(context).size.width - 80,
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, bottom: 8),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  offset: const Offset(1, 3),
                                  spreadRadius: 1.5,
                                  blurRadius: 4)
                            ]),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                SvgPicture.asset(
                                  "assets/circular/Batch.svg",
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.contain,
                                ),
                                const Positioned(
                                  right: 28,
                                  top: 8,
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 35,
                                        backgroundImage:
                                            AssetImage("assets/circular/image.jpg"),
                                      ),
                                      Text('Raja',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SvgPicture.asset(
                                        "assets/circular/Ribbon.svg",
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Positioned(
                                      right: 32,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 80,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8)),
                                            ),
                                            child: const Center(
                                              child: Text('13 jan',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          const Text('Congratulations',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)),
                                          const Text('Best Employee of \nthe Month',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Get.toNamed(Routes.circularPhoto);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade900,
                                        borderRadius: BorderRadius.circular(12)),
                                    child: const Center(
                                      child: Text("Send wishes",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Center(
                child: Text(
                  "Announcements",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: const Offset(1, 3),
                          spreadRadius: 1.5,
                          blurRadius: 4)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Happy Birthday",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      "Today freefood for all the employee",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 14,
                          color: Colors.blue.shade900,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Text(
                          '29-03-2024',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: const Offset(1, 3),
                          spreadRadius: 1.5,
                          blurRadius: 4)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Happy Birthday",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      "Today freefood for all the employee",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 14,
                          color: Colors.blue.shade900,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Text(
                          '29-03-2024',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: const Offset(1, 3),
                          spreadRadius: 1.5,
                          blurRadius: 4)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Happy Birthday",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      "Today freefood for all the employee",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 14,
                          color: Colors.blue.shade900,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Text(
                          '29-03-2024',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: const Offset(1, 3),
                          spreadRadius: 1.5,
                          blurRadius: 4)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Happy Birthday",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      "Today freefood for all the employee",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 14,
                          color: Colors.blue.shade900,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Text(
                          '29-03-2024',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
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
    );
  }
}
