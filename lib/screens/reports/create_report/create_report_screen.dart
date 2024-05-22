import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotrack24fsc/screens/reports/create_report/create_report_controller.dart';
import 'package:get/get.dart';

import '../../../helpers/colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_edittext.dart';

class CreateReportScreen extends GetView<CreateReportController> {
  CreateReportScreen({super.key});

  @override
  final controller = Get.put(CreateReportController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: bgGradientColor),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.28,
                    ),
                    const Text(
                      "Report",
                      style: TextStyle(
                        fontSize: 16,
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.868,
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: const BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32))),
                child: Column(
                  children: [
                    Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomEditText(
                            controller: controller.nameController,
                            hintText: "Date",
                            keyboardType: TextInputType.number,
                            suffixIcon: const Icon(
                              Icons.calendar_month,
                              color: blackColor,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomEditText(
                            controller: controller.nameController,
                            hintText: "Time",
                            keyboardType: TextInputType.number,
                            suffixIcon: const Icon(
                              Icons.timer_outlined,
                              color: blackColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomEditText(
                      controller: controller.nameController,
                      hintText: "Client Name",
                      keyboardType: TextInputType.number,
                      suffixIcon: const Icon(
                        Icons.apartment,
                        color: blackColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomEditText(
                      controller: controller.nameController,
                      hintText: "Contact Person",
                      keyboardType: TextInputType.number,
                      suffixIcon: const Icon(
                        Icons.person,
                        color: blackColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomEditText(
                      controller: controller.nameController,
                      hintText: "Remark",
                      maxLines: 4,
                      minLines: 4,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Upload Audio",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: blackColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () async {},
                            child: Container(
                              width: 60,
                              height: 60,
                                                            decoration: BoxDecoration(
                                  color: fillColor,
                                  borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(Icons.audio_file,
                                  size: 30, color: secondaryColor),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Obx(
                          () => Expanded(
                            child: Container(
                                height: 60,

                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade400,
                                        blurRadius: 0.2,
                                        spreadRadius: 0.3),
                                  ],
                                ),
                                child: controller.isAudioUploaded.value == 0
                                    ? const Center(
                                        child: Text(
                                          "Select audio to upload",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                      )
                                    : Center(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            const Icon(Icons.video_file,
                                                color: primaryColor, size: 32),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  controller.isAudioUploaded
                                                              .value ==
                                                          1
                                                      ? "Uploading..."
                                                      : "Completed",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                controller.isAudioUploaded
                                                            .value ==
                                                        1
                                                    ? SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        child:
                                                            const LinearProgressIndicator(
                                                          color: primaryColor,
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                        child:
                                                            const LinearProgressIndicator(
                                                          value: 1.0,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                            controller.isAudioUploaded.value ==
                                                    2
                                                ? IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .isAudioUploaded(0);
                                                    },
                                                    icon: const Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                        size: 32),
                                                  )
                                                : const SizedBox.shrink()
                                          ],
                                        ),
                                      )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: "create",
                      onTap: () {},
                      fontWeight: FontWeight.bold,
                      btnColor: secondaryColor,
                    )
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
