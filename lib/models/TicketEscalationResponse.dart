class TicketEscalationResponse {
  TicketEscalationResponse(
    this.rtnStatus,
    this.rtnMessage,
    this.rtnData,
  );

  TicketEscalationResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(TicketEscalation.fromJson(v));
      });
    }
  }

  late bool rtnStatus;
  late String rtnMessage;
  late List<TicketEscalation> rtnData;

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

class TicketEscalation {
  TicketEscalation(
    this.esclationTicketID,
    this.esclationID,
    this.esclationName,
    this.remarks,
    this.esclateDate,
    this.responsibleName,
  );

  TicketEscalation.fromJson(dynamic json) {
    esclationTicketID = json['EsclationTicketID'];
    esclationID = json['EsclationID'];
    esclationName = json['EsclationName'];
    remarks = json['Remarks'];
    esclateDate = json['EsclateDate'];
    responsibleName = json['ResponsibleName'];
    colorCode = json['ColorCode'];
  }

  late int esclationTicketID;
  late int esclationID;
  late String esclationName;
  late String remarks;
  late String esclateDate;
  late String responsibleName;
  late String colorCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['EsclationTicketID'] = esclationTicketID;
    map['EsclationID'] = esclationID;
    map['EsclationName'] = esclationName;
    map['Remarks'] = remarks;
    map['EsclateDate'] = esclateDate;
    map['ResponsibleName'] = responsibleName;
    map['ColorCode'] = colorCode;
    return map;
  }
}
