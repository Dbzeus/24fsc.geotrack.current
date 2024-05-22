class DeskDashboardResponse {
  DeskDashboardResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  DeskDashboardResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(TicketCount.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<TicketCount> rtnData;

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

class TicketCount {
  TicketCount(
      this.ticketStatusID, 
      this.statusName, 
      this.colorCode, 
      this.statusImage, 
      this.ticketCount,);

  TicketCount.fromJson(dynamic json) {
    ticketStatusID = json['TicketStatusID'];
    statusName = json['StatusName'];
    colorCode = json['ColorCode'];
    statusImage = json['StatusImage'];
    ticketCount = json['TicketCount'];
  }
  late int ticketStatusID;
  late String statusName;
  late String colorCode;
  late String statusImage;
  late int ticketCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TicketStatusID'] = ticketStatusID;
    map['StatusName'] = statusName;
    map['ColorCode'] = colorCode;
    map['StatusImage'] = statusImage;
    map['TicketCount'] = ticketCount;
    return map;
  }

}