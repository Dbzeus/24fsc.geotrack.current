class StaffReportResponse {
  late bool status;
  late String rtnMessage;
  late List<StaffReportData> returnData;

  StaffReportResponse(this.status, this.rtnMessage, this.returnData);

  StaffReportResponse.fromJson(dynamic json) {
    status = json["RtnStatus"];
    rtnMessage = json["RtnMessage"];
    if (json["RtnData"] != null) {
      returnData = [];
      json["RtnData"].forEach((v) {
        returnData.add(StaffReportData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["RtnStatus"] = status;
    map["RtnMessage"] = rtnMessage;
    if (returnData != null) {
      map["RtnData"] = returnData.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class StaffReportData {
  late String firstName;
  late String lastName;
  late String roleName;
  late String location;
  late int userID;
  late String loginTime;
  late String cheInTime;
  late String companyName;
  late String empImg;
  late String remarks;
  late String km;
  late String mobileNo;
  late bool isLogin;

  StaffReportData();

  StaffReportData.fromJson(dynamic json) {
    firstName = json["FirstName"];
    lastName = json["LastName"];
    roleName = json["RoleName"];
    location = json["Location"];
    userID = json["UserID"];
    loginTime = json["LoginTime"];
    cheInTime = json["CheInTime"];
    companyName = json["CompanyName"];
    isLogin = json["isLogin"];
    empImg = json["EmpImg"];
    remarks = json["Remarks"];
    mobileNo = json["MobileNo"];
    km = json["KM"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["FirstName"] = firstName;
    map["LastName"] = lastName;
    map["RoleName"] = roleName;
    map["Location"] = location;
    map["UserID"] = userID;
    map["LoginTime"] = loginTime;
    map["CheInTime"] = cheInTime;
    map["CompanyName"] = companyName;
    map["isLogin"] = isLogin;
    map["EmpImg"] = empImg;
    map["KM"] = km;
    map["Remarks"] = remarks;
    map["MobileNo"] = mobileNo;
    return map;
  }
}
