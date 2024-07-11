import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';

import '../../apis/api_call.dart';
import '../../models/DashboardResponse.dart';

import '../../models/staff_report_response.dart';
import '../../utils/constants.dart';
import '../../utils/session.dart';

class DashboardController extends GetxController {

  DateTime now = DateTime.now();
  RxString date = "".obs;
  RxInt daysInMonth = 0.obs, isSelectedDate = (-1).obs;
  RxList<DateTime> days = <DateTime>[].obs;

  StaffReportData? argData;
  RxList list = RxList();
  Rx<DashboardResponseData?> data = Rx(null);
  RxString selectedMonth = ''.obs;
  DateFormat showFormat = DateFormat('MMM yyyy');
  DateTime selected = DateTime.now();
  final _box = GetStorage();
  RxBool isLoading = true.obs;
  int userId = -1;

  @override
  void onInit() async {
    super.onInit();
    if(Get.arguments == null){
      selectedMonth(showFormat.format(DateTime.now()));
      isSelectedDate(int.parse(DateTime.now().day.toString()));
      daysInMonth.value = DateUtils.getDaysInMonth(now.year, now.month);
      days.value = getAllDaysInMonth(DateTime.now().year, DateTime.now().month);
      userId = _box.read(Session.userid) ?? -1;
      getDashboard(date: DateTime.now().toString().split(" ")[0]);

    }else{
      argData = Get.arguments["data"];
      userId = argData!.userID;
      selected= Get.arguments['date'] ;
      isSelectedDate(selected.day);
      selectedMonth(showFormat.format(selected));
      daysInMonth.value = DateUtils.getDaysInMonth(selected.year, selected.month);
      days.value = getAllDaysInMonth(selected.year, selected.month);
      getDashboard(date: selected.toString().split(" ")[0]);
    }

  }



  List<DateTime> getAllDaysInMonth(int year, int month) {
    // Get the first day of the month
    DateTime firstDay = DateTime(year, month, 1);

    // Get the number of days in the month
    int daysInMonth = DateUtils.getDaysInMonth(year, month);

    // Create a list to store all days in the month
    RxList<DateTime> days = <DateTime>[].obs;

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



  void getDashboard({String date = ""}) async {
    if (await isNetConnected()) {
      isLoading(true);

      DashboardResponse? response = await ApiCall().getDashboardDetails(
          '$userId',date );
      if (response != null) {
        if (response.rtnStatus) {
          if (response.rtnData != null) {
            data(response.rtnData);
          }
        }
      }
      isLoading(false);
    }
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
          daysInMonth.value = DateUtils.getDaysInMonth(selected.year, selected.month);
          days.value = getAllDaysInMonth(selected.year, selected.month);
          getDashboard(date: selected.toString().split(" ")[0]);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
