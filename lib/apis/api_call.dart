
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geotrack24fsc/apis/urls.dart';
import 'package:geotrack24fsc/models/ClientListResponse.dart';
import 'package:geotrack24fsc/models/FeedbackResponse.dart';
import 'package:geotrack24fsc/models/UserRemarkResponse.dart';
import 'package:geotrack24fsc/models/attrition_list_response.dart';
import 'package:geotrack24fsc/models/collection_list_response.dart';
import 'package:geotrack24fsc/models/staff_report_response.dart';
import 'package:geotrack24fsc/models/user_list_response.dart';

import '../main.dart';
import '../models/ApplicationSettingResponse.dart';
import '../models/CustomerListResponse.dart';
import '../models/GeoHistoryResponse.dart';


import '../models/MenuResponse.dart';
import '../models/MobileLoginResponse.dart';
import '../models/NearCompanyResponse.dart';
import '../models/OtListResponse.dart';
import '../models/OutstationListResponse.dart';

import '../models/dashboard_response.dart';
import '../models/emp_lat_lng.dart';
import '../models/leave_list_response.dart';
import '../models/notification_response.dart';
class ApiCall {
  static final ApiCall _instance = ApiCall._internal();

  static final Dio _dio = Dio();

  factory ApiCall() {
    return _instance;
  }

  ApiCall._internal() {
    _dio.options.baseUrl = BASE_URL;
    _dio.options.connectTimeout = const Duration(minutes: 10);
    _dio.interceptors.add(MyApp.alice.getDioInterceptor());
    /*if (kDebugMode) {
      _dio.interceptors.add(MyApp.alice.getDioInterceptor());
    }*/
  }



  Future<dynamic> checkCustomerId(
      String customerId,
      ) async {
    try {
      var params = {
        "CustomerID": customerId,
      };

      log('${_dio.options.baseUrl} $CHECK_CUSTOMER_URL ${jsonEncode(params)}');
      final response =
      await _dio.post(CHECK_CUSTOMER_URL, queryParameters: params);
      log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        
        return null;
      } else {
        return response.data;
      }
    } catch (e) {
      log(e.toString());
      
      return null;
    }
  }

  Future<MobileLoginResponse?> checkLogin(
      String mobileNo, String mPin, String token, dynamic info) async {
    try {
      var params = {
        "MobileNo": mobileNo,
        "MPin": mPin,
        "MobileToken": token,
        "Info": info
      };

      log('${_dio.options.baseUrl} $LOGIN_URL ${jsonEncode(params)}');
      final response = await _dio.post(LOGIN_URL, data: jsonEncode(params));
      log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
      
        return null;
      } else {
        return MobileLoginResponse.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());
      
      return null;
    }
  }

  Future<dynamic> updateDeviceDetails(dynamic params) async {
    try {
      log('${_dio.options.baseUrl} $UPDATE_DEVICE_URL ${jsonEncode(params)}');
      final response =
      await _dio.post(UPDATE_DEVICE_URL, data: jsonEncode(params));
      log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
      
        return null;
      } else {
        return response.data;
      }
    } catch (e) {
      log(e.toString());
      
      return null;
    }
  }

  Future<dynamic> forgetMpin(String mobileNo) async {
    try {
      var params = {"MobileNo": mobileNo};

      log('${_dio.options.baseUrl} $FORGET_MPIN_URL ${jsonEncode(params)}');
      final response =
      await _dio.post(FORGET_MPIN_URL, queryParameters: params);
      log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
      
        return null;
      } else {
        return response.data;
      }
    } catch (e) {
      log(e.toString());
      
      return null;
    }
  }

  Future<dynamic> resetMpin(
      String mobileNo, String oldMPin, String newMPin) async {
    try {
      var params = {
        "MobileNo": mobileNo,
        "OldMPIN": oldMPin,
        "NewMPIN": newMPin
      };

      log('${_dio.options.baseUrl} $RESET_MPIN_URL ${jsonEncode(params)}');
      final response = await _dio.post(RESET_MPIN_URL, queryParameters: params);
      log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        
        return null;
      } else {
        return response.data;
      }
    } catch (e) {
      log(e.toString());
      
      return null;
    }
  }

  Future<ApplicationSettingResponse?> getSettings(String userId) async {
    try {
      var params = {
        "UserID": userId,
      };

      log('${_dio.options.baseUrl} $SETTING_URL ${jsonEncode(params)}');
      final response = await _dio.get(SETTING_URL, queryParameters: params);
      log('response ${response.requestOptions.path} ${response.statusCode}');

      if ((response.statusCode ?? -1) >= 205) {
        
        return null;
      } else {
        return ApplicationSettingResponse.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());
      
      return null;
    }
  }

  Future<GeoHistoryResponse?> getHistories(String userId, String fDate,
      {String? tDate}) async {
    try {
      var params = {
        "UserID": userId,
        "DateFrom": fDate,
        "DateTo": tDate ?? fDate,
      };

      log('${_dio.options.baseUrl} $HISTORY_URL ${jsonEncode(params)}');
      final response = await _dio.get(HISTORY_URL, queryParameters: params);
      log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        
        return null;
      } else {
        return GeoHistoryResponse.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());
      
      return null;
    }
  }

  Future<NearCompanyResponse?> getNearCompanies(String lat, String lng) async {
    try {
      var params = {
        "Latitude": lat,
        "Longitude": lng,
      };

      log('${_dio.options.baseUrl} $GET_NEAR_COMPANY_URL ${jsonEncode(params)}');
      final response =
      await _dio.post(GET_NEAR_COMPANY_URL, queryParameters: params);
      log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        
        return null;
      } else {
        return NearCompanyResponse.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());
      
      return null;
    }
  }

  Future<dynamic> updateStatus(params) async {
    try {
      log('${_dio.options.baseUrl} $UPDATE_STATUS_URL ${jsonEncode(params)}');
      final response =
      await _dio.post(UPDATE_STATUS_URL, data: jsonEncode(params));
      log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        
        return null;
      } else {
        return response.data;
      }
    } catch (e) {
      log(e.toString());
      
      return null;
    }
  }

  Future<MenuResponse?> getMenus(String roleId) async {
    try {
      var params = {
        "RoleID": roleId,
      };

      log('${_dio.options.baseUrl} $MENU_URL ${jsonEncode(params)}');
      final response = await _dio.get(MENU_URL, queryParameters: params);
      log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        
        return null;
      } else {
        return MenuResponse.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());
      
      return null;
    }
  }

  //leave functionality
  Future<dynamic> insertLeave(String userid, String fdate, String tdate,
      String noday, int isCompoff, String remark) async {
    Map<String, String> params = {
      "UserID": userid,
      "LeaveFrom": fdate,
      'LeaveTo': tdate,
      'IsCompOff': '0',
      'LeaveType': '$isCompoff',
      'NoofDaysLeave': noday,
      'ReasonForLeave': remark,
    };

    log('${_dio.options.baseUrl} $INSERT_LEAVE_URL ${jsonEncode(params)}');
    final response =
    await _dio.post(INSERT_LEAVE_URL, data: jsonEncode(params));
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  Future<LeaveListResponse?> getLeaveHistory(String userid, String statusid,
      String fdate, String tdate, int type) async {
    try {
      Map<String, String> params = {
        "UserID": userid,
        "StausID": statusid,
        'StartDate': fdate,
        'EndDate': tdate,
        'ReportType': '$type',
      };

      log('${_dio.options.baseUrl} $LEAVE_LIST_URL ${jsonEncode(params)}');
      final response =
      await _dio.post(LEAVE_LIST_URL, data: jsonEncode(params));
      log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        
        return null;
      } else {
        return LeaveListResponse.fromJson(response.data);
      }
    } catch (e) {
      print('model parse ${e.toString()}');
    }
  }

  Future<dynamic> updateLeave(
      String leaveid, String userid, String status) async {
    Map<String, String> params = {
      "LeaveID": leaveid,
      "ApprovedID": userid,
      'StatusID': status,
    };

    log('${_dio.options.baseUrl} $UPDATE_LEAVE_URL ${jsonEncode(params)}');
    final response = await _dio.post(UPDATE_LEAVE_URL, queryParameters: params);
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  //ot functionality
  Future<dynamic> insertOT(String userid, String f, String t, String noHours,
      String custId, String remark) async {
    Map<String, String> params = {
      "UserID": userid,
      "OTFrom": f,
      'OTTo': t,
      'Hours': noHours,
      'CustomerID': custId,
      'ReasonForOT': remark,
    };

    log('${_dio.options.baseUrl} $INSERT_OT_URL ${jsonEncode(params)}');
    final response = await _dio.post(INSERT_OT_URL, data: jsonEncode(params));
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  Future<OtListResponse?> getOTHistory(String userid, String statusid,
      String fdate, String tdate, int type) async {
    Map<String, String> params = {
      "UserID": userid,
      "StausID": statusid,
      'StartDate': fdate,
      'EndDate': tdate,
      'ReportType': '$type',
    };

    log('${_dio.options.baseUrl} $OT_LIST_URL ${jsonEncode(params)}');
    final response = await _dio.post(OT_LIST_URL, data: jsonEncode(params));
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return OtListResponse.fromJson(response.data);
    }
  }

  Future<dynamic> updateOT(String otId, String userid, String status) async {
    Map<String, String> params = {
      "OTID": otId,
      "ApprovedID": userid,
      'StatusID': status,
    };

    log('${_dio.options.baseUrl} $UPDATE_OT_URL ${jsonEncode(params)}');
    final response = await _dio.post(UPDATE_OT_URL, queryParameters: params);
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  //outstation functionality
  Future<dynamic> insertOutstation(var params) async {
    log('${_dio.options.baseUrl} $INSERT_OUTSTATION_URL ${jsonEncode(params)}');
    final response =
    await _dio.post(INSERT_OUTSTATION_URL, data: jsonEncode(params));
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  Future<OutstationListResponse?> getOutstationHistory(String userid,
      String statusid, String fdate, String tdate, int type) async {
    Map<String, String> params = {
      "UserID": userid,
      "StausID": statusid,
      'StartDate': fdate,
      'EndDate': tdate,
      'ReportType': '$type',
    };

    log('${_dio.options.baseUrl} $OUTSTATION_LIST_URL ${jsonEncode(params)}');
    final response =
    await _dio.post(OUTSTATION_LIST_URL, data: jsonEncode(params));
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return OutstationListResponse.fromJson(response.data);
    }
  }

  Future<dynamic> updateOutstation(
      String otId, String userid, String amount, String status) async {
    Map<String, String> params = {
      "OutStationID": otId,
      "ApprovedID": userid,
      "ApprovedAmount": amount,
      'StatusID': status,
    };

    log('${_dio.options.baseUrl} $UPDATE_OUTSTATION_URL ${jsonEncode(params)}');
    final response =
    await _dio.post(UPDATE_OUTSTATION_URL, queryParameters: params);
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  Future<dynamic> getDropdownOutstationList(String did) async {
    Map<String, String> params = {
      "DropdownType": did,
    };

    log('${_dio.options.baseUrl} $DROPDOWN_OUTSTATION_URL ${jsonEncode(params)}');
    final response =
    await _dio.post(DROPDOWN_OUTSTATION_URL, queryParameters: params);
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  Future<NotificationResponse?> getNotification(int userid) async {
    Map<String, String> params = {
      "UserID": '$userid',
    };

    log('${_dio.options.baseUrl} $NOTIFICATION_URL ${jsonEncode(params)}');
    final response = await _dio.get(NOTIFICATION_URL, queryParameters: params);
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return NotificationResponse.fromJson(response.data);
    }
  }

  Future<dynamic> changeMpinRequest(params) async {
    log('${_dio.options.baseUrl} $CHANGE_MPIN_URL ${jsonEncode(params)}');
    final response = await _dio.post(CHANGE_MPIN_URL, queryParameters: params);
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  getRoutePoints(Map<String, String> params) async {
    final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/directions/json',
        queryParameters: params);
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  Future<DashboardResponse?> getDashboardDetails(
      String userId, String date) async {
    Map<String, String> params = {
      "EmployeeID": userId,
      "ReportDate": date,
    };

    log('${_dio.options.baseUrl} $DASHBOARD_URL ${jsonEncode(params)}');
    final response = await _dio.get(DASHBOARD_URL, queryParameters: params);
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return DashboardResponse.fromJson(response.data);
    }
  }

  Future<EmpLatLngResponse?> getEmpLatLng(
      String userId, String fDate, String tDate) async {
    Map<String, String> params = {
      "EmpID": userId,
      "FromDate": fDate,
      "ToDate": tDate,
    };

    log('${_dio.options.baseUrl} $ACTIVITY_URL ${jsonEncode(params)}');
    final response = await _dio.get(ACTIVITY_URL, queryParameters: params);
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return EmpLatLngResponse.fromJson(response.data);
    }
  }

  //support desk
  Future<CustomerListResponse?> getCustomerList(
      String customerId,
      ) async {
    Map<String, String> params = {
      "CustomerID": customerId,
    };

    log('${_dio.options.baseUrl} $CUSTOMER_LIST_URL ${jsonEncode(params)}');
    final response = await _dio.get(CUSTOMER_LIST_URL, queryParameters: params);
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return CustomerListResponse.fromJson(response.data);
    }
  }

  Future<FeedbackResponse?> getFeedbackList() async {
    log('${_dio.options.baseUrl} $FEEDBACK_URL');
    final response = await _dio.get(
      FEEDBACK_URL,
    );

    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return FeedbackResponse.fromJson(response.data);
    }
  }

  Future<dynamic> feedbackTicket(
      var params,
      ) async {
    log('${_dio.options.baseUrl} $FEEDBACK_TICKET_URL ${jsonEncode(params)}');
    final response = await _dio.post(
      FEEDBACK_TICKET_URL,
      data: params,
    );
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  Future<AttritionListResponse?> getAttritionList(
      String userid, String fdate) async {
    var params = {"UserID": userid, "ReportDate": fdate};

    log('${_dio.options.baseUrl} $ATTRITION_URL');
    final response = await _dio.post(ATTRITION_URL, queryParameters: params);

    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return AttritionListResponse.fromJson(response.data);
    }
  }

  Future<StaffReportResponse?> getAttritionReportList(
      String userid, String fdate, String type) async {
    var params = {"UserID": userid, "ReportDate": fdate, "ReportType": type};

    log('${_dio.options.baseUrl} $ATTRITION_REPORT_URL');
    final response =
    await _dio.post(ATTRITION_REPORT_URL, queryParameters: params);

    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return StaffReportResponse.fromJson(response.data);
    }
  }

  Future<dynamic> updateCustomer(
      String cid,
      String lat,
      String lng,
      String userid,
      ) async {
    var params = {
      "CustomerID": cid,
      "Latitude": lat,
      "Longitude": lng,
      "CUID": userid,
    };

    log('${_dio.options.baseUrl} $UPDATE_CUSTOMER_URL');
    final response =
    await _dio.post(UPDATE_CUSTOMER_URL, queryParameters: params);

    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  Future<dynamic> changeCompanyActive(
      String cid,
      String lat,
      String lng,
      String userid,
      ) async {
    var params = {
      "CustomerID": cid,
      "Latitude": lat,
      "Longitude": lng,
      "CUID": userid,
    };

    log('${_dio.options.baseUrl} $UPDATE_CUSTOMER_URL');
    final response =
    await _dio.post(UPDATE_CUSTOMER_URL, queryParameters: params);

    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  //orbito
  dynamic createClient(params) async {
    log('${_dio.options.baseUrl} $CREATE_CLIENT_URL');
    final response = await _dio.post(CREATE_CLIENT_URL, data: params);

    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  dynamic insertMeetingDetail(params) async {
    log('${_dio.options.baseUrl} $INSERT_MEETING_URL');
    final response = await _dio.post(INSERT_MEETING_URL, data: params);

    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  dynamic getMeetingTypeList() async {
    log('${_dio.options.baseUrl} $MEETING_TYPE_URL ');
    final response = await _dio.post(
      MEETING_TYPE_URL,
    );
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  dynamic getStatusList() async {
    log('${_dio.options.baseUrl} $MEETING_STATUS_URL ');
    final response = await _dio.post(
      MEETING_STATUS_URL,
    );
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  Future<ClientListResponse?> getClientList(String clientId) async {
    log('${_dio.options.baseUrl} $CLIENT_LIST_URL ');
    final response = await _dio.post(CLIENT_LIST_URL, queryParameters: {
      'ClientID': clientId,
    });
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return ClientListResponse.fromJson(response.data);
    }
  }

  Future<dynamic> getSampleTypeList() async {
    log('${_dio.options.baseUrl} $SAMPLE_TYPE_LIST_URL ');
    final response = await _dio.get(
      SAMPLE_TYPE_LIST_URL,
    );
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  Future<dynamic> submitSampleCollection(var body, List<String> paths) async {
    log('${_dio.options.baseUrl} $SUBMIT_SAMPLE_COLLECTION_URL ${jsonEncode(body)}');

    List<MultipartFile> files = [];
    for (var element in paths) {
      if (element.isNotEmpty) {
        files.add(await MultipartFile.fromFile(
          element,
        ));
      }
    }

    //debugPrint('${files.length} ${files.first.toString()}');

    var formData = FormData.fromMap({
      'SampleDetails': jsonEncode(body),
      'Files': files,
    });
    debugPrint("Multipart file : $formData");

    final response = await _dio.post(
      SUBMIT_SAMPLE_COLLECTION_URL,
      data: formData,
    );
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  Future<dynamic> getBranchListByLatLng(double lat, double lng) async {
    log('${_dio.options.baseUrl} $BRANCH_DETAIL_URL $lat $lng');
    final response = await _dio.post(BRANCH_DETAIL_URL, queryParameters: {
      'Latitude': '$lat',
      'Longitude': '$lng',
    });
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  Future<dynamic> getEmployeeList(String branchId) async {
    log('${_dio.options.baseUrl} $EMPLOYEE_LIST_URL ');
    final response = await _dio.get(EMPLOYEE_LIST_URL, queryParameters: {
      'EmployeeID': '0',
      'BranchID': branchId,
    });
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

  Future<CollectionListResponse?> getCollectionList(int userId) async {
    log('${_dio.options.baseUrl} $COLLECTION_LIST_URL ');
    final response = await _dio.post(COLLECTION_LIST_URL, queryParameters: {
      'userId': userId,
    });
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return CollectionListResponse.fromJson(response.data);
    }
  }

  Future<dynamic> submitHandover(var body) async {
    log('${_dio.options.baseUrl} $SUBMIT_HANDOVER_URL ${jsonEncode(body)}');
    final response = await _dio.post(SUBMIT_HANDOVER_URL, data: body);
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) >= 205) {
      
      return null;
    } else {
      return response.data;
    }
  }

/*  Future<dynamic> getAppVersion() async {

    var response = await _dio.getUri(Uri.parse(appVersionUrl));
    log('${response.requestOptions.baseUrl}\n${response.requestOptions.path}\n${response.statusCode}\n${response.data}');

    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      return null;
    }
  }*/

  Future<UserListResponse?> getUsersList() async {
    final response =
    await _dio.get(GET_EMPLOYEE_LIST, queryParameters: {"EmployeeID": 0});
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) <= 205) {
      return UserListResponse.fromJson(response.data);
    } else {
      debugPrint('branch list : response status code > 205');
      return null;
    }
  }

  Future<dynamic> getRoleList() async {
    final response = await _dio.get(ROLE_LIST_API);
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      debugPrint('branch list : response status code > 205');
      return null;
    }
  }

  Future<dynamic> getBranchList() async {
    final response = await _dio.get(BRANCH_LIST_API);
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      debugPrint('branch list : response status code > 205');
      return null;
    }
  }

  Future<dynamic> createEmployee(var params) async {

    final response=await _dio.post(INSERT_UPDATE_EMPLOYEE,data: params);

    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');


    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<UserRemarkResponse?> getRemarksList(int userId, String date) async {
    final response = await _dio.get(GET_REMARK_URL, queryParameters: {
      "UserID":userId,
      "RemarksDate":date
    });
    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

    if ((response.statusCode ?? -1) <= 205) {
      return UserRemarkResponse.fromJson(response.data);
    } else {
      debugPrint('remark list : response status code > 205');
      return null;
    }
  }

  Future<dynamic> submitRemarks(var data) async {

    final response=await _dio.post(SUBMIT_REMARK_URL,data: data);

    log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');


    if ((response.statusCode ?? -1) <= 205) {
      return response.data;
    } else {
      return null;
    }
  }



}