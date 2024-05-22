class EscalationLevelResponse {
  EscalationLevelResponse(
    this.rtnStatus,
    this.rtnMessage,
    this.rtnData,
      );

  EscalationLevelResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(EscalationLevel.fromJson(v));
      });
    }
  }

late bool rtnStatus;
  late String rtnMessage;
  late List<EscalationLevel> rtnData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RtnStatus'] = rtnStatus;
    map['RtnMessage'] = rtnMessage;
    if (rtnData != null) {
      map['RtnData'] = rtnData.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class EscalationLevel {
  EscalationLevel(
    this.esclationID,
    this.esclationName,
    this.resposiblePersionIDs,
    this.resposiblePersion,
    this.colorCode,
  );

  EscalationLevel.fromJson(dynamic json) {
    esclationID = json['EsclationID'];
    esclationName = json['EsclationName'];
    resposiblePersionIDs = json['ResposiblePersionIDs'];
    resposiblePersion = json['ResposiblePersion'];
    colorCode = json['ColorCode'];
  }

  late int esclationID;
  late String esclationName;
  late String resposiblePersionIDs;
  late String resposiblePersion;
  late String colorCode;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['EsclationID'] = esclationID;
    map['EsclationName'] = esclationName;
    map['ResposiblePersionIDs'] = resposiblePersionIDs;
    map['ResposiblePersion'] = resposiblePersion;
    map['ColorCode'] = colorCode;
    return map;
  }
}
