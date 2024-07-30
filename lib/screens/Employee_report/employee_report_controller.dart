import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';

import '../../apis/api_call.dart';
import '../../models/staff_report_response.dart';
import '../../utils/constants.dart';
import '../../utils/session.dart';

class EmployeeReportController extends GetxController {
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
  int userId = -1,empId =-1;
  var args = Get.arguments;

  @override
  void onInit() async {
    super.onInit();
    debugPrint("DATAETREATS :${args['date']}");
    selected= args['date'] ;
    isSelectedDate(selected.day);
    selectedMonth(showFormat.format(selected));
    userId = box.read(Session.userid);
    empId = box.read(Session.empId);
    //selectedMonth(showFormat.format(DateTime.now()));
    daysInMonth.value = DateUtils.getDaysInMonth(selected.year, selected.month);
    days.value = getAllDaysInMonth(selected.year, selected.month);
    debugPrint("days: ${days.toString()}");
    staffReport(date: selected.toString().split(" ")[0]);
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
          staffReport(date: selected.toString().split(" ")[0]);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void staffReport({String date = ""}) async {
    if (await isNetConnected()) {
      isLoading(true);
      StaffReportResponse? response = await ApiCall().getAttritionReportList(
        '$empId',
        date,
        '${args["reportType"]}',
      );
      if (response != null) {
        if (response.status) {
          if (response.returnData.isNotEmpty) {
            for (var element in response.returnData) {
              element.empImg = element.empImg.replaceAll('No Image', '');
            }
            data(response.returnData);
          }
        }
      }
      isLoading(false);
    }
  }
}
