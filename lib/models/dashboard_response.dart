class DashboardResponse {
  late bool status;
  late String rtnMessage;
  DashboardData? returnData;

  DashboardResponse(
      this.status, 
      this.rtnMessage, 
      this.returnData);

  DashboardResponse.fromJson(dynamic json) {
    status = json["RtnStatus"];
    rtnMessage = json["RtnMessage"];
    returnData = json["RtnData"] != null ? DashboardData.fromJson(json["RtnData"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Status"] = status;
    map["RtnMessage"] = rtnMessage;
    if (returnData != null) {
      map["RtnData"] = returnData?.toJson();
    }
    return map;
  }

}

class DashboardData {
  late int userID;
  late String employeeName;
  late String roleName;
  late String locationName;
  late int missedPunch;
  late int present;
  late double conveyanceKM;
  late String workingHours;
  late int workingDays;
  late int noofSunday;
  late String otHours;
  late List<EmployeeData> employeeDBDatasDTOs;
  String convUrl='';


  DashboardData(
      this.userID, 
      this.employeeName, 
      this.roleName, 
      this.locationName, 
      this.missedPunch, 
      this.present, 
      this.conveyanceKM, 
      this.workingHours, 
      this.workingDays, 
      this.noofSunday, 
      this.employeeDBDatasDTOs);

  DashboardData.fromJson(dynamic json) {
    userID = json["UserID"];
    employeeName = json["EmployeeName"];
    roleName = json["RoleName"];
    locationName = json["LocationName"];
    missedPunch = json["MissedPunch"];
    present = json["Present"];
    conveyanceKM = json["ConveyanceKM"];
    workingHours = json["WorkingHours"];
    workingDays = json["WorkingDays"];
    noofSunday = json["NoofSunday"];
    otHours = json["OTHrs"];
    convUrl = json["ConveyanceURL"] ?? '';

    if (json["employeeDBDatasDTOs"] != null) {
      employeeDBDatasDTOs = [];
      json["employeeDBDatasDTOs"].forEach((v) {
        employeeDBDatasDTOs.add(EmployeeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["UserID"] = userID;
    map["EmployeeName"] = employeeName;
    map["RoleName"] = roleName;
    map["LocationName"] = locationName;
    map["MissedPunch"] = missedPunch;
    map["Present"] = present;
    map["ConveyanceKM"] = conveyanceKM;
    map["WorkingHours"] = workingHours;
    map["WorkingDays"] = workingDays;
    map["NoofSunday"] = noofSunday;
    map["OTHrs"] = otHours;
    map["ConveyanceURL"] = convUrl;
    if (employeeDBDatasDTOs != null) {
      map["employeeDBDatasDTOs"] = employeeDBDatasDTOs.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class EmployeeData {
  late String dates;
  late String km;
  late String loginTime;
  late String logoutTime;
  late String wh;
  late String otHours;

  EmployeeData(
      this.dates, 
      this.km, 
      this.loginTime, 
      this.logoutTime, 
      this.wh);

  EmployeeData.fromJson(dynamic json) {
    dates = json["Dates"];
    km = json["KM"];
    loginTime = json["LoginTime"];
    logoutTime = json["LogoutTime"];
    wh = json["WH"];
    otHours = json["OTHrs"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Dates"] = dates;
    map["KM"] = km;
    map["LoginTime"] = loginTime;
    map["LogoutTime"] = logoutTime;
    map["WH"] = wh;
    map["OTHrs"] = otHours;
    return map;
  }

}