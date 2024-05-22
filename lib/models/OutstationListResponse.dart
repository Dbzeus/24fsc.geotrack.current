class OutstationListResponse {
  OutstationListResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  OutstationListResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(Outstation.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<Outstation> rtnData;

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

class Outstation {
  Outstation(
      this.outStationId, 
      this.userID, 
      this.empName, 
      this.desigination, 
      this.branch, 
      this.department, 
      this.mobileNo, 
      this.dateFrom, 
      this.dateTo, 
      this.noofDays, 
      this.reasonForOutStation, 
      this.createdDate, 
      this.stausID, 
      this.outStationStatus, 
      this.approvedBy, 
      this.approvedDate, 
      this.approverName, 
      this.customerName, 
      this.advanceAmount, 
      this.approvedAmount, 
      this.purposeofVisit, 
      this.pov, 
      this.transportType, 
      this.tranType, 
      this.source, 
      this.destination, 
      this.remarks,);

  Outstation.fromJson(dynamic json) {
    outStationId = json['OutStationId'];
    userID = json['UserID'];
    empName = json['EmpName'];
    desigination = json['Desigination'];
    branch = json['Branch'];
    department = json['Department'];
    mobileNo = json['MobileNo'];
    dateFrom = json['DateFrom'];
    dateTo = json['DateTo'];
    noofDays = json['NoofDays'];
    reasonForOutStation = json['ReasonForOutStation'];
    createdDate = json['CreatedDate'];
    stausID = json['StausID'];
    outStationStatus = json['OutStationStatus'];
    approvedBy = json['ApprovedBy'];
    approvedDate = json['ApprovedDate'];
    approverName = json['ApproverName'];
    customerName = json['CustomerName'];
    advanceAmount = json['AdvanceAmount'];
    approvedAmount = json['ApprovedAmount'];
    purposeofVisit = json['PurposeofVisit'];
    pov = json['POV'];
    transportType = json['TransportType'];
    tranType = json['TranType'];
    source = json['Source'];
    destination = json['Destination'];
    remarks = json['Remarks'];
  }
  late int outStationId;
  late int userID;
  late String empName;
  late String desigination;
  late String branch;
  late String department;
  late String mobileNo;
  late String dateFrom;
  late String dateTo;
  late int noofDays;
  late String reasonForOutStation;
  late String createdDate;
  late int stausID;
  late String outStationStatus;
  late int approvedBy;
  late String approvedDate;
  late String approverName;
  late String customerName;
  late double advanceAmount;
  late double approvedAmount;
  late int purposeofVisit;
  late dynamic pov;
  late int transportType;
  late dynamic tranType;
  late String source;
  late String destination;
  late String remarks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OutStationId'] = outStationId;
    map['UserID'] = userID;
    map['EmpName'] = empName;
    map['Desigination'] = desigination;
    map['Branch'] = branch;
    map['Department'] = department;
    map['MobileNo'] = mobileNo;
    map['DateFrom'] = dateFrom;
    map['DateTo'] = dateTo;
    map['NoofDays'] = noofDays;
    map['ReasonForOutStation'] = reasonForOutStation;
    map['CreatedDate'] = createdDate;
    map['StausID'] = stausID;
    map['OutStationStatus'] = outStationStatus;
    map['ApprovedBy'] = approvedBy;
    map['ApprovedDate'] = approvedDate;
    map['ApproverName'] = approverName;
    map['CustomerName'] = customerName;
    map['AdvanceAmount'] = advanceAmount;
    map['ApprovedAmount'] = approvedAmount;
    map['PurposeofVisit'] = purposeofVisit;
    map['POV'] = pov;
    map['TransportType'] = transportType;
    map['TranType'] = tranType;
    map['Source'] = source;
    map['Destination'] = destination;
    map['Remarks'] = remarks;
    return map;
  }

}