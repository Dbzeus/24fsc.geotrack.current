import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';

import '../../apis/api_call.dart';
import '../../helpers/colors.dart';
import '../../models/DashboardResponse.dart';
import '../../models/emp_lat_lng.dart';
import '../../utils/constants.dart';
import '../../utils/session.dart';

class ActivitiesController extends GetxController {
  DateTime now = DateTime.now();
  RxInt daysInMonth = 0.obs, isSelectedDate = (-1).obs;
  RxList<DateTime> days = <DateTime>[].obs;
  RxBool isLoading = false.obs;
  Rx<DashboardResponseData?> data = Rx(null);
  RxString selectedMonth = ''.obs;
  DateFormat showFormat = DateFormat('MMM yyyy');
  int userId = -1;
  DateTime selected = DateTime.now();
  final _box = GetStorage();

  Rx<CameraPosition> initialLocation =
      Rx(const CameraPosition(target: LatLng(12.971599, 77.594566), zoom: 10));

  // this will hold the generated polylines
  RxSet<Polyline> polylines = RxSet();
  RxSet<Marker> markers = RxSet();
  RxList<LatLng> points = <LatLng>[].obs;

  // this will hold each polyline coordinate as Lat and Lng pairs
  RxList<LatLng> polylineCoordinates = RxList();
  String googleAPIKey = 'AIzaSyBzW6RgOTU_W5XQtj7kDtLqiruXNnZMOhQ'; // 24fsc key
  //String googleAPIKey = 'AIzaSyD1bBcmlrx5A2rMbag6peaXEYqx3Rhn4lQ'; // solas track key
  //'AIzaSyBOslPtgmIS7MdVcSMOVSOof_CvktVtk4E'; (mehala towers) (orbito asia) (maxx)

  @override
  void onInit() async {
    super.onInit();

    selectedMonth(showFormat.format(DateTime.now()));
    isSelectedDate(int.parse(DateTime.now().day.toString()));
    daysInMonth.value = DateUtils.getDaysInMonth(now.year, now.month);
    days.value = getAllDaysInMonth(DateTime.now().year, DateTime.now().month);
    userId = _box.read(Session.userid) ?? -1;
    getDashboard(date: DateTime.now().toString().split(" ")[0]);
  }

  void onMapCreated(GoogleMapController controller) {}

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
          getDashboard(date: selected.toString().split(" ")[0]);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getDashboard({String date = ""}) async {
    if (await isNetConnected()) {
      isLoading(true);
      markers.clear();
      DashboardResponse? response =
          await ApiCall().getDashboardDetails('$userId', date);
      if (response != null) {
        if (response.rtnStatus) {
          if (response.rtnData != null) {
            data(response.rtnData);
            if (data.value!.timeLine.isNotEmpty) {
              initialLocation.value = CameraPosition(
                  zoom: 10,
                  target: LatLng(
                      double.parse(data.value!.timeLine.first.latitude),
                      double.parse(data.value!.timeLine.first.longitude)));

              points.clear();
              polylines.clear();
              polylineCoordinates.clear();
              for (var element in data.value!.timeLine) {
                setMapPins(element!);
              }

              generateRoutes();
            } else {
              showToastMsg("No activities found");
              initialLocation = Rx(const CameraPosition(
                  target: LatLng(12.971599, 77.594566), zoom: 10));
              polylines.clear();
            }
          }
        }
      }
      isLoading(false);
    }
  }

  void setMapPins(TimeLine element) async {
    points.add(
      LatLng(double.parse(element.latitude), double.parse(element.longitude)),
    );
    debugPrint("Points: ${points.toString()}");
    markers.add(Marker(
      markerId: MarkerId('${element.hashCode}'),
      position: LatLng(
          double.parse(element.latitude), double.parse(element.longitude)),
      icon: BitmapDescriptor.defaultMarkerWithHue(element.statusID == 1 //login
          ? BitmapDescriptor.hueGreen
          : element.statusID == 2 // logout
              ? BitmapDescriptor.hueOrange
              : element.statusID == 3 //get status
                  ? BitmapDescriptor.hueRed
                  : BitmapDescriptor.hueBlue),
      onTap: () {
        ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
        final snackBar = SnackBar(
          duration: const Duration(minutes: 1),
          behavior: SnackBarBehavior.floating,
          backgroundColor: whiteColor,
          content: Column(
            children: [
              Text(element.geoStatus, style: TextStyle(color: secondaryColor)),
              const SizedBox(
                height: 6,
              ),
              Text(element.statusAddress,style: TextStyle(color: blackColor),),
            ],
          ),
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      },
    ));
  }

  void generateRoutes() async {
    debugPrint("Routes");
    debugPrint("points: ${points.length}");
    for (int s = 0; s < points.length; s++) {
      debugPrint("ABCD1");
      int d = s + 1;
      if (d < points.length) {
        debugPrint("ABCD2");
        LatLng source = LatLng(double.parse(points[s].latitude.toString()),
            double.parse(points[s].longitude.toString()));
        debugPrint("source: ${source.toString()}");
        debugPrint("ABCD3");
        LatLng destination = LatLng(double.parse(points[d].latitude.toString()),
            double.parse(points[d].longitude.toString()));
        debugPrint("destination: ${destination.toString()}");
        List<LatLng> result = await getRouteBetweenCoordinates(
            googleAPIKey,
            source.latitude,
            source.longitude,
            destination.latitude,
            destination.longitude);
        debugPrint('result:${result.toString()}');
        debugPrint('ABCD3:$s - ${result.length}');
        if (result.isNotEmpty) {
          for (var point in result) {
            polylineCoordinates.add(point);
          }
          /*for (int i = 0; i < result.length; i++) {
            //for (var point in result) {
            debugPrint("Point length: ${result[i]}");
            if (i == 0) {
              debugPrint("Points: 0");
              polylineCoordinates.add(result[i]);
              polylines.add(Polyline(
                  polylineId: PolylineId('1'),
                  visible: true,
                  color: Colors.green,
                  points: polylineCoordinates.value));
            } else if (i == (result.length - 1)) {
              debugPrint("Points: last");
              polylineCoordinates.add(result[i]);
              polylines.add(Polyline(
                  polylineId: PolylineId('2'),
                  visible: true,
                  color: Colors.orange,
                  points: polylineCoordinates.value));
            } else {
              debugPrint("Points: between");
              polylineCoordinates.add(result[i]);
              polylines.add(Polyline(
                  polylineId: PolylineId('3'),
                  visible: true,
                  color: Colors.blue,
                  points: polylineCoordinates.value));
            }
          }*/
        }
      }
    }
    Polyline polyline = Polyline(
        polylineId: PolylineId('1'),
        visible: true,
        width: 4,
        endCap: Cap.roundCap,
        startCap: Cap.roundCap,
        color: Colors.blue,
        points: polylineCoordinates.value);

    polylines.add(polyline);
  }

  Future<List<LatLng>> getRouteBetweenCoordinates(
      String googleApiKey,
      double originLat,
      double originLong,
      double destLat,
      double destLong) async {
    debugPrint("API");
    List<LatLng> polylinePoints = [];
    // String url =
    //     "https://maps.googleapis.com/maps/api/directions/json?origin=" +
    //         originLat.toString() +
    //         "," +
    //         originLat.toString() +
    //         "&destination=" +
    //         destLat.toString() +
    //         "," +
    //         destLong.toString() +
    //         "&mode=driving" +
    //         "&key=$googleApiKey";

    Map<String, String> params = {
      "origin": '${originLat.toString()},${originLong.toString()}',
      "destination": '${destLat.toString()},${destLong.toString()}',
      "mode": 'driving',
      "key": googleApiKey,
    };

    var response = await ApiCall().getRoutePoints(params);

    try {
      if (response != null) {
        if (response["routes"].isNotEmpty) {
          var res = PolylinePoints().decodePolyline(
              response["routes"][0]["overview_polyline"]["points"]);

          for (var i in res) {
            polylinePoints.add(LatLng(i.latitude, i.longitude));
          }

          // polylinePoints = decodeEncodedPolyline(
          //     jsonDecode(response["routes"][0]["overview_polyline"]["points"]));
          //jsonDecode(response)["routes"][0]["overview_polyline"]["points"]);
        }
      }
    } catch (e) {
      debugPrint("Error : ${e.toString()}");
    }

    return polylinePoints;
  }

  List<LatLng> decodeEncodedPolyline(encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      LatLng p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    debugPrint("Poly: ${poly}");
    return poly;
  }

/*drawPolyLine() {
    polylines.add(Polyline(
      polylineId: const PolylineId('line1'),
      visible: true,
      //latlng is List<LatLng>
      points: points,
      width: 6,
      color: primaryColor,
    ));
  }*/
}
