import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geotrack24fsc/utils/session.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';

import '../../../apis/api_call.dart';
import '../../../helpers/colors.dart';
import '../../../models/staff_report_response.dart';
import '../../../utils/constants.dart';

class VisitingReportController extends GetxController {
  DateTime now = DateTime.now();
  RxInt daysInMonth = 0.obs, isSelectedDate = (-1).obs;
  RxList<DateTime> days = <DateTime>[].obs;
  RxBool isLoading = false.obs,isPlayLoading =false.obs;
  final box = GetStorage();
  RxString selectedMonth = ''.obs;
  DateFormat showFormat = DateFormat('MMM yyyy');
  DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  DateTime selected = DateTime.now();
  int userId = -1;
  StaffReportData? argData;
  RxList data = RxList();

  final player = AudioPlayer();
  RxString audio = "".obs;

  RxBool isPlay = false.obs;

  late Duration audioDuration;
  late Duration stopDuration;

  RxDouble sliderValue = 0.0.obs;

  RxBool isPlayFromCard = false.obs;

  @override
  void onInit() async {
    super.onInit();
    if(Get.arguments == null){
      selectedMonth(showFormat.format(DateTime.now()));
      isSelectedDate(int.parse(DateTime.now().day.toString()));
      daysInMonth.value = DateUtils.getDaysInMonth(now.year, now.month);
      days.value = getAllDaysInMonth(DateTime.now().year, DateTime.now().month);
      userId = box.read(Session.userid) ?? -1;
      getVisitingReport(date: DateTime.now().toString().split(" ")[0]);
    }else{
      argData = Get.arguments["data"];
      userId = argData!.userID;
      selected= Get.arguments['date'] ;
      isSelectedDate(selected.day);
      selectedMonth(showFormat.format(selected));
      daysInMonth.value = DateUtils.getDaysInMonth(selected.year, selected.month);
      days.value = getAllDaysInMonth(selected.year, selected.month);
      getVisitingReport(date: selected.toString().split(" ")[0]);
    }

  }

  List<DateTime> getAllDaysInMonth(int year, int month) {
    // Get the first day of the month
    DateTime firstDay = DateTime(year, month, 1);

    // Get the number of days in the month
    int daysInMonth = DateUtils.getDaysInMonth(year, month);

    // Create a list to store all days in the month
    List<DateTime> days = [];

    // Loop through each day and add it to the list
    for (int day = 1; day <= daysInMonth; day++) {
      days.add(firstDay.add(Duration(days: day - 1)));
    }

    return days;
  }

  String getDayOfWeek(DateTime date) {
    const List<String> daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return daysOfWeek[date.weekday - 1];
  }

  changeMonth() async {
    try {
      await showMonthPicker(
        context: Get.context!,
        firstDate: DateTime.now().subtract(const Duration(days: 60)),
        lastDate: DateTime.now(),
        initialDate: selected,
      ).then((date) {
        if (data != null) {
          selected = date!;
          debugPrint(selected.toString());
          selectedMonth(showFormat.format(date));
          isSelectedDate(int.parse(selected.day.toString()));
          daysInMonth.value =
              DateUtils.getDaysInMonth(selected.year, selected.month);
          days.value = getAllDaysInMonth(selected.year, selected.month);
          getVisitingReport(date: selected.toString().split(" ")[0]);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  playAudio(String audio, {bool fromCard = false}) async {
    try {
      isPlayLoading(true);
      Duration? res = await player.setUrl(audio);
      if (res != null) {
        isPlay(true);
        player.play();
        isPlayLoading(false);
        player.durationStream.listen(
          (duration) {
            // Update the slider when the duration changes
            audioDuration = duration!;
          },
        );
        player.playerStateStream.listen((event) {
          if (event.processingState == ProcessingState.completed) {
            isPlay(false);
            sliderValue(0.0);
          }
        });
        player.positionStream.listen((position) {
          // Update the slider value based on the current position
          fromCard
              ? 0.0
              : sliderValue(position.inSeconds / audioDuration.inSeconds);
        });
      }
    } catch (e) {
      log("Error loading audio source: $e");
    }
  }

  stopAudio({bool fromCard = false}) async {
    try {
      await player.stop();
      isPlay(false);
    } catch (e) {
      log("Error stop in audio source: $e");
    }
  }

  getVisitingReport({String date = ""}) async {
    if (await isNetConnected()) {
      isLoading(true);
      try {
        var response = await ApiCall()
            .getVisitingReport(box.read(Session.userid).toString(), date, date);
        if (response != null) {
          if (response["RtnStatus"]) {
            data(response["RtnData"]);
          } else {
            showToastMsg(response["RtnMessage"]);
            data.value = [];
          }
        }
      } catch (e) {
        debugPrint("catch error: ${e.toString()}");
      }
    } else {
      showToastMsg("Check your internet connection");
    }
    isLoading(false);
  }

  audioAlertDialog(String audio) {
    return showDialog(
        context: Get.context!,
        builder: (BuildContext) {
          return PopScope(
            canPop: true,
            onPopInvoked: (_){
              stopAudio();
            },
            child: AlertDialog(
              backgroundColor: whiteColor,
              content: SizedBox(
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Audio", style: TextStyle(fontWeight: FontWeight.bold)),
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                if (audio.isNotEmpty) {
                                  debugPrint("Audio url:$audio");
                                  isPlay.value ? stopAudio() : playAudio(audio);
                                } else {
                                  showToastMsg("No Audio Found");
                                }
                              },
                              child: isPlayLoading.value == true  ? SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  )): Icon(
                                isPlay.value
                                    ? Icons.stop_circle
                                    : Icons.play_circle,
                                color: isPlay.value ? Colors.red : secondaryColor,
                                size: 30,
                              ),
                            ),
                          ),
                          Obx(
                            () => Slider(
                                value: sliderValue.value,
                                onChanged: (value) {
                                  // final newPosition = value * controller.audioDuration.inMilliseconds;
                                  // controller.player.seek(Duration(milliseconds: newPosition.round()));
                                },
                                min: 0.0,
                                max: 1.0),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });

    /*return Get.defaultDialog(
      backgroundColor: whiteColor,
      title: "",
      middleText: "",
      radius: 14,
      barrierDismissible: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      actions: [
        Icon(
          Icons.play_circle,
          color: secondaryColor,
          size: 30,
        ),
      ]
    );*/
  }
}
