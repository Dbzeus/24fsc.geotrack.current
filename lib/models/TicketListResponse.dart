import 'package:get/get.dart';

class TicketListResponse {
  TicketListResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  TicketListResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(TicketDetail.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<TicketDetail> rtnData;

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

class TicketDetail {
  TicketDetail(
      this.ticketDate, 
      this.ticketID, 
      this.ticketNo, 
      this.ticketStatus, 
      this.statusImage, 
      this.statusName, 
      this.childStatusID, 
      this.customerID, 
      this.customerName, 
      this.contactNama, 
      this.contactNo, 
      this.compliantID, 
      this.complientName, 
      this.compliantNatureID, 
      this.complientNatureName, 
      this.priorityID, 
      this.priorityName, 
      this.ticketDuration, 
      this.attandDateTime, 
      this.isTimerStart, 
      this.timer, 
      this.remarks, 
      this.complientImages, 
      this.qrcode,
      this.childID,);

  TicketDetail.fromJson(dynamic json) {
    ticketDate = json['TicketDate'];
    ticketID = json['TicketID'];
    ticketNo = json['TicketNo'];
    ticketStatus = json['TicketStatus'];
    statusImage = json['StatusImage'];
    statusName = json['StatusName'];
    childStatusID = json['ChildStatusID'];
    customerID = json['CustomerID'];
    customerName = json['CustomerName'];
    contactNama = json['ContactNama'];
    contactNo = json['ContactNo'];
    compliantID = json['CompliantID'];
    complientName = json['ComplientName'];
    compliantNatureID = json['CompliantNatureID'];
    complientNatureName = json['ComplientNatureName'];
    priorityID = json['PriorityID'];
    priorityName = json['PriorityName'];
    ticketDuration = json['TicketDuration'];
    attandDateTime = json['AttandDateTime'];
    isTimerStart = json['IsTimerStart'];
    timer(json['Timer']);
    remarks = json['Remarks'];
    complientImages = json['ComplientImages'];
    assigneeName=json['AssineeName'] ;
    assigneeDate=json['AssignedDate'];
    rating=json['Ratting'];
    statusColor=json['StatusColor'];
    qrcode=json['QRCode'];

    escalateId=json['EsclationID'];
    escalationName=json['EsclationName'];
    escalationColorCode=json['ColorCode'];
    persons=json['ResponsiblePersonName'];
    isEscalte=json['IsEsclation'];

    if (json['ChildID'] != null) {
      childID = [];
      json['ChildID'].forEach((v) {
        childID.add(TicketActions.fromJson(v));
      });
    }
  }
  late String ticketDate;
  late int ticketID;
  late String ticketNo;
  late int ticketStatus;
  late String statusImage;
  late String statusName;
  late String childStatusID;
  late int customerID;
  late String customerName;
  late String contactNama;
  late String contactNo;
  late int compliantID;
  late String complientName;
  late int compliantNatureID;
  late String complientNatureName;
  late int priorityID;
  late String priorityName;
  late int ticketDuration;
  late String attandDateTime;
  late bool isTimerStart;
  RxInt timer=0.obs;
  late String remarks;
  late String complientImages;
  late String statusColor;
  late String assigneeName;
  late String assigneeDate;
  late double rating;
  late String qrcode;
  late List<TicketActions> childID;

  //for escalation
  late bool isEscalte;
  late int escalateId;
  late String persons;
  late String escalationName;
  late String escalationColorCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TicketDate'] = ticketDate;
    map['TicketID'] = ticketID;
    map['TicketNo'] = ticketNo;
    map['TicketStatus'] = ticketStatus;
    map['StatusImage'] = statusImage;
    map['StatusName'] = statusName;
    map['ChildStatusID'] = childStatusID;
    map['CustomerID'] = customerID;
    map['CustomerName'] = customerName;
    map['ContactNama'] = contactNama;
    map['ContactNo'] = contactNo;
    map['CompliantID'] = compliantID;
    map['ComplientName'] = complientName;
    map['CompliantNatureID'] = compliantNatureID;
    map['ComplientNatureName'] = complientNatureName;
    map['PriorityID'] = priorityID;
    map['PriorityName'] = priorityName;
    map['TicketDuration'] = ticketDuration;
    map['AttandDateTime'] = attandDateTime;
    map['IsTimerStart'] = isTimerStart;
    map['Timer'].value = timer;
    map['Remarks'] = remarks;
    map['ComplientImages'] = complientImages;
    map['AssineeName'] = assigneeName;
    map['AssignedDate'] = assigneeDate;
    map['Ratting'] = rating;
    map['StatusColor'] = statusColor;
    map['QRCode'] = qrcode;

    map['EsclationID']=escalateId;
    map['EsclationName']=escalationName;
    map['ColorCode']=escalationColorCode;
    map['ResponsiblePersonName']=persons;
    map['IsEsclation']=isEscalte;

    if (childID != null) {
      map['ChildID'] = childID.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class TicketActions {
  TicketActions(
      this.ticketStatusID, 
      this.childStatusName, 
      this.childStatusId, 
      this.colorCode, 
      this.statusImage,);

  TicketActions.fromJson(dynamic json) {
    ticketStatusID = json['TicketStatusID'];
    childStatusName = json['ChildStatusName'];
    childStatusId = json['ChildStatusId'];
    colorCode = json['ColorCode'];
    statusImage = json['StatusImage'];
    ticketAction = json['TicketAction'];
  }
  late int ticketStatusID;
  late String childStatusName;
  late int childStatusId;
  late String colorCode;
  late String statusImage;
  late String ticketAction;

  String? ticketNo;
  String? ticketId;
  String? statusName;
  bool? isAssignee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TicketStatusID'] = ticketStatusID;
    map['ChildStatusName'] = childStatusName;
    map['ChildStatusId'] = childStatusId;
    map['ColorCode'] = colorCode;
    map['StatusImage'] = statusImage;
    map['TicketAction'] = ticketAction;
    return map;
  }

}