class TicketHistoryResponse {
  TicketHistoryResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  TicketHistoryResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(TicketHistory.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<TicketHistory> rtnData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RtnStatus'] = rtnStatus;
    map['RtnMessage'] = rtnMessage;
    map['RtnData'] = rtnData.map((v) => v.toJson()).toList();
    return map;
  }

}

class TicketHistory {
  TicketHistory(
      this.ticketID, 
      this.ticketNo, 
      this.ticketStatusID, 
      this.statusName, 
      this.colorCode, 
      this.assigneeID, 
      this.assigneeName, 
      this.remarks, 
      this.complientImages, 
      this.cUDate,);

  TicketHistory.fromJson(dynamic json) {
    ticketID = json['TicketID'];
    ticketNo = json['TicketNo'];
    ticketStatusID = json['TicketStatusID'];
    statusName = json['StatusName'];
    colorCode = json['ColorCode'];
    assigneeID = json['AssigneeID'];
    assigneeName = json['AssigneeName'];
    remarks = json['Remarks'];
    complientImages = json['ComplientImages'];
    cUDate = json['CUDate'];
    ticketLabel = json['TicketLabel'];
    phone = json['PhoneNo'];
  }
  late int ticketID;
  late String ticketNo;
  late int ticketStatusID;
  late String statusName;
  late String colorCode;
  late String assigneeID;
  late String assigneeName;
  late String remarks;
  late String complientImages;
  late String cUDate;

  late String ticketLabel;
  late String phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TicketID'] = ticketID;
    map['TicketNo'] = ticketNo;
    map['TicketStatusID'] = ticketStatusID;
    map['StatusName'] = statusName;
    map['ColorCode'] = colorCode;
    map['AssigneeID'] = assigneeID;
    map['AssigneeName'] = assigneeName;
    map['Remarks'] = remarks;
    map['ComplientImages'] = complientImages;
    map['CUDate'] = cUDate;
    map['TicketLabel']=ticketLabel;
    map['PhoneNo']=phone;
    return map;
  }

}