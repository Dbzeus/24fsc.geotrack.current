class EmpLatLngResponse {
  late bool status;
  late String rtnMessage;
  late List<EmpLatLng> returnData;

  EmpLatLngResponse(this.status, this.rtnMessage, this.returnData);

  EmpLatLngResponse.fromJson(dynamic json) {
    status = json["RtnStatus"];
    rtnMessage = json["RtnMessage"];
    if (json["RtnData"] != null) {
      returnData = [];
      json["RtnData"].forEach((v) {
        returnData.add(EmpLatLng.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["RtnStatus"] = status;
    map["RtnMessage"] = rtnMessage;
    map["RtnData"] = returnData.map((v) => v.toJson()).toList();
    return map;
  }
}

class EmpLatLng {
  late String latitude;
  late String longitude;
  late String message;
  late int typeId;

  EmpLatLng(this.latitude, this.longitude, this.message, this.typeId);

  EmpLatLng.fromJson(dynamic json) {
    latitude = json["Latitude"];
    longitude = json["Longitude"];
    message = json["Message"];
    typeId = json["TypeID"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Latitude"] = latitude;
    map["Longitude"] = longitude;
    map["Message"] = message;
    map["TypeID"] = typeId;
    return map;
  }
}
