import 'package:flutter/material.dart';
import 'package:geotrack24fsc/utils/session.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';



import '../../apis/api_call.dart';
import '../../models/PerformanceReport.dart';
import '../../utils/constants.dart';

class PerformanceReportController extends GetxController {
  DateTime now = DateTime.now();
  RxInt daysInMonth = 0.obs, isSelectedDate = (-1).obs;
  RxList<DateTime> days = <DateTime>[].obs;
  DateTime selected = DateTime.now();
  RxString selectedMonth = ''.obs;

  DateFormat showFormat = DateFormat('MMM yyyy');
  DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  RxList data = RxList();
  RxBool isLoading = false.obs;
  final box = GetStorage();
  int userId = -1;

  @override
  void onInit() async {
    super.onInit();
    selectedMonth(showFormat.format(DateTime.now()));
    isSelectedDate(int.parse(DateTime.now().day.toString()));
    userId = box.read(Session.userid);
    daysInMonth.value = DateUtils.getDaysInMonth(now.year, now.month);
    days.value = getAllDaysInMonth(DateTime.now().year, DateTime.now().month);
    debugPrint("days: ${days.toString()}");

    getAttrition(date: DateTime.now().toString().split(" ")[0]);
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
          debugPrint("dfjdsbfugdsgfbdsu"+selected.toString());
          selectedMonth(showFormat.format(date));
          isSelectedDate(int.parse(selected.day.toString()));
          daysInMonth.value =
              DateUtils.getDaysInMonth(selected.year, selected.month);
          days.value = getAllDaysInMonth(selected.year, selected.month);
          getAttrition(date: selected.toString().split(" ")[0]);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getAttrition({String date = ""}) async {
    if (await isNetConnected()) {
      isLoading(true);
      PerformanceReport? response =
          await ApiCall().getAttritionList('$userId', date);
      if (response != null) {
        if (response.rtnStatus && response.rtnData.isNotEmpty) {
          data(response.rtnData);
        }
      }
      isLoading(false);
    }
  }
}
