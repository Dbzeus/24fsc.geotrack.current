/// RtnStatus : true
/// RtnMessage : "Details Loaded successfully"
/// RtnData : [{"ReportType":1,"Description":"No of Employees ","Result":11,"ColorCode":"#418ff1"},{"ReportType":2,"Description":"No.of Present ","Result":6,"ColorCode":"#41f14c"},{"ReportType":3,"Description":"No.of Absent ","Result":5,"ColorCode":"#f17441"},{"ReportType":4,"Description":"No.of Leave ","Result":0,"ColorCode":"#f4c85b"}]
/// OtherMsg : null
/// ID : 0

class PerformanceReport {
  PerformanceReport(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData, 
      this.otherMsg, 
      this.id,);

  PerformanceReport.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(PerfromanceReportData.fromJson(v));
      });
    }
    otherMsg = json['OtherMsg'];
    id = json['ID'];
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<PerfromanceReportData> rtnData;
  late dynamic otherMsg;
  late int id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RtnStatus'] = rtnStatus;
    map['RtnMessage'] = rtnMessage;
    if (rtnData != null) {
      map['RtnData'] = rtnData.map((v) => v.toJson()).toList();
    }
    map['OtherMsg'] = otherMsg;
    map['ID'] = id;
    return map;
  }

}

/// ReportType : 1
/// Description : "No of Employees "
/// Result : 11
/// ColorCode : "#418ff1"

class PerfromanceReportData {
  PerfromanceReportData(
      this.reportType, 
      this.description, 
      this.result, 
      this.colorCode,);

  PerfromanceReportData.fromJson(dynamic json) {
    reportType = json['ReportType'];
    description = json['Description'];
    result = json['Result'];
    colorCode = json['ColorCode'];
  }
  late int reportType;
  late String description;
  late int result;
  late String colorCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ReportType'] = reportType;
    map['Description'] = description;
    map['Result'] = result;
    map['ColorCode'] = colorCode;
    return map;
  }

}