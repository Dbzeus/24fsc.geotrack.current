import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotrack24fsc/screens/reports/create_report/create_report_controller.dart';
import 'package:get/get.dart';
import 'package:record/record.dart';

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
              Expanded(
                child: Container(
                  //height: MediaQuery.of(context).size.height * 0.868,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32))),
                  child: SingleChildScrollView(
                    child: Obx(
                      () => controller.isLoading.value
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: const Center(
                                  child: CircularProgressIndicator()))
                          : Column(
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
                                        controller: controller.dateController,
                                        hintText: "Date",
                                        keyboardType: TextInputType.none,
                                        showCursor: false,
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            controller.selectDate();
                                          },
                                          child: const Icon(
                                            Icons.calendar_month,
                                            color: blackColor,
                                            size: 20,
                                          ),
                                        ),
                                        onTap: () {
                                          controller.selectDate();
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: CustomEditText(
                                        controller: controller.timeController,
                                        hintText: "Time",
                                        keyboardType: TextInputType.none,
                                        showCursor: false,
                                        onTap: (){
                                          controller.selectToTime();
                                        },
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            controller.selectToTime();
                                          },
                                          child: const Icon(
                                            Icons.timer_outlined,
                                            color: blackColor,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                  controller: controller.clientNameController,
                                  hintText: "Client Name",
                                  keyboardType: TextInputType.text,
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
                                  controller:
                                      controller.contactPersonController,
                                  hintText: "Contact Person",
                                  keyboardType: TextInputType.text,

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
                                  controller:
                                      controller.contactPersonNumberController,
                                  hintText: "Contact Person Number",
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
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
                                  controller: controller.remarkController,
                                  hintText: "Remark",
                                  maxLines: 4,
                                  minLines: 4,
                                  keyboardType: TextInputType.text,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Record Audio",
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
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          var res=await AudioRecorder().hasPermission();
                                          if(res) {
                                            controller.isRecordStarted.value
                                                ? controller.stopRecord()
                                                : controller.startRecord();
                                          }

                                        },
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              color: fillColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          padding: const EdgeInsets.all(8),
                                          child:
                                              controller.isRecordStarted.value
                                                  ? const Icon(
                                                      Icons.stop,
                                                      size: 30,
                                                      color: Colors.red,
                                                    )
                                                  : const Icon(
                                                      Icons.record_voice_over,
                                                      size: 30,
                                                      color: secondaryColor),
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
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade400,
                                                    blurRadius: 0.2,
                                                    spreadRadius: 0.3),
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                controller.isRecordStarted.value
                                                    ? "Recording... " /*${controller.recordingTimer}*/
                                                    : "Press audio button to record",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13),
                                              ),
                                            )),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          controller.recordFilePath.value = "";
                                          controller.sliderValue(0.0);
                                        },
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              color: fillColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          padding: const EdgeInsets.all(8),
                                          child: const Icon(Icons.delete,
                                              size: 30, color: Colors.red),
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                controller.recordFilePath.isNotEmpty &&
                                        controller.isRecordStarted.value ==
                                            false
                                    ? Row(
                                        children: [
                                          Obx(
                                            () => InkWell(
                                                onTap: () async {
                                                  if (controller.recordFilePath
                                                      .isNotEmpty) {
                                                    controller.isPlay.value
                                                        ? controller.stopAudio()
                                                        : controller.playAudio(
                                                            controller
                                                                .recordFilePath
                                                                .value);
                                                  }
                                                },
                                                child: Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                      color: fillColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: controller.isPlay.value
                                                      ? const Icon(
                                                          Icons.stop,
                                                          size: 30,
                                                          color: Colors.red,
                                                        )
                                                      : const Icon(
                                                          Icons.play_arrow,
                                                          size: 30,
                                                          color:
                                                              secondaryColor),
                                                )),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Container(
                                                height: 60,
                                                margin:
                                                    EdgeInsets.only(right: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade50,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors
                                                            .grey.shade400,
                                                        blurRadius: 0.2,
                                                        spreadRadius: 0.3),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Obx(
                                                    () => Slider(
                                                        value: controller
                                                            .sliderValue
                                                            .value,
                                                        onChanged: (value) {
                                                          // final newPosition = value * controller.audioDuration.inMilliseconds;
                                                          // controller.player.seek(Duration(milliseconds: newPosition.round()));
                                                        },
                                                        min: 0.0,
                                                        max: 1.0),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink(),


                                const SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                  text: "create",
                                  onTap: () {
                                    controller.submitVisitingReport();
                                  },
                                  fontWeight: FontWeight.bold,
                                  btnColor: secondaryColor,
                                )
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
