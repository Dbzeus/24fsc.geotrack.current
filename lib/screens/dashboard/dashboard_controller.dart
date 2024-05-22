import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';

import '../../apis/api_call.dart';
import '../../models/dashboard_response.dart';
import '../../utils/constants.dart';
import '../../utils/session.dart';

class DashboardController extends GetxController{
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
    today(showFormat.format(DateTime.now()));
    userId = _box.read(Session.userid) ?? -1;
    getDashboard();

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


  RxList list = RxList();
  Rx<DashboardData?> data = Rx(null);
  RxString today = ''.obs, month = ''.obs;
  DateFormat showFormat = DateFormat('MMM yyyy');
  DateTime selected = DateTime.now();
  final _box = GetStorage();
  RxBool isLoading = true.obs;
  int userId = -1;



  void getDashboard() async {
    if (await isNetConnected()) {
      isLoading(true);
      month(DateFormat('MMM').format(showFormat.parse(today.value)));

      DashboardResponse? response = await ApiCall().getDashboardDetails(
          '$userId',
          '${selected.month.toString().length == 1 ? '0${selected.month}' : selected.month}-01-${selected.year}');

      if (response != null) {
        if (response.status) {
          if (response.returnData != null) {
            data(response.returnData);
            list(response.returnData!.employeeDBDatasDTOs);
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
          today(showFormat.format(date));
          getDashboard();
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}