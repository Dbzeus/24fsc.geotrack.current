class AttritionListResponse {
  late bool status;
  late String rtnMessage;
  late List<Attrition> returnData;

  AttritionListResponse(this.status, this.rtnMessage, this.returnData);

  AttritionListResponse.fromJson(dynamic json) {
    status = json["RtnStatus"];
    rtnMessage = json["RtnMessage"];
    if (json["RtnData"] != null) {
      returnData = [];
      json["RtnData"].forEach((v) {
        returnData.add(Attrition.fromJson(v));
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

class Attrition {
  late String description;
  late int result;
  late int reportType;

  Attrition(this.description, this.result, this.reportType);

  Attrition.fromJson(dynamic json) {
    description = json["Description"];
    result = json["Result"];
    reportType = json["ReportType"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Description"] = description;
    map["Result"] = result;
    map["ReportType"] = reportType;
    return map;
  }
}
