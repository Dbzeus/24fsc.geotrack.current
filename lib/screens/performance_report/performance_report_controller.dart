import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PerformanceReportController extends GetxController{
  Rx<String> currentDate = "".obs;
  DateTime now = DateTime.now();
  RxInt daysInMonth = 0.obs;
  List<DateTime> days = [];



  @override
  void onInit() async {
    super.onInit();
    currentDate(DateFormat('MMM dd yyyy').format(DateTime.now()));

    daysInMonth.value = DateUtils.getDaysInMonth(now.year, now.month);
    days = getAllDaysInMonth(DateTime.now().year, DateTime.now().month);
    debugPrint("days: ${days.toString()}");


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

  changeDate() async {
    try {
      DateTime dt = DateFormat("MMM dd yyyy").parse(currentDate.value);
      final DateTime? pickedDate = await showDatePicker(
          context: Get.context!,
          initialDate: dt,
          firstDate: DateTime.now().subtract(const Duration(days: 45)),
          lastDate: DateTime.now());

      if (pickedDate != null) {
        currentDate(DateFormat("MMM dd yyyy").format(pickedDate));
      }
    } catch (e) {
      //ignored
    }
  }
}