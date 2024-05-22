class OtListResponse {
  OtListResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  OtListResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(OTList.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<OTList> rtnData;

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

class OTList {
  OTList(
      this.otid, 
      this.userID, 
      this.empName, 
      this.desigination, 
      this.branch, 
      this.department, 
      this.mobileNo, 
      this.oTFrom, 
      this.oTTo, 
      this.hours, 
      this.reasonForOT, 
      this.createdDate, 
      this.stausID, 
      this.oTStatus, 
      this.approverName, 
      this.approvedBy, 
      this.approvedDate, 
      this.customerName,
      this.description,);

  OTList.fromJson(dynamic json) {
    otid = json['OTID'];
    userID = json['UserID'];
    empName = json['EmpName'];
    desigination = json['Desigination'];
    branch = json['Branch'];
    department = json['Department'];
    mobileNo = json['MobileNo'];
    oTFrom = json['OTFrom'];
    oTTo = json['OTTo'];
    hours = json['Hours'];
    reasonForOT = json['ReasonForOT'];
    createdDate = json['CreatedDate'];
    stausID = json['StausID'];
    oTStatus = json['OTStatus'];
    approverName = json['ApproverName'];
    approvedBy = json['ApprovedBy'];
    approvedDate = json['ApprovedDate'];
    description = json['Description'];
    customerName = json['CustomerName'];
  }
  
  late int otid;
  late int userID;
  late String empName;
  late String desigination;
  late String branch;
  late String department;
  late String mobileNo;
  late String oTFrom;
  late String oTTo;
  late String hours;
  late String reasonForOT;
  late String createdDate;
  late int stausID;
  late String oTStatus;
  late String approverName;
  late int approvedBy;
  late String approvedDate;
  late String description;
  String? customerName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OTID'] = otid;
    map['UserID'] = userID;
    map['EmpName'] = empName;
    map['Desigination'] = desigination;
    map['Branch'] = branch;
    map['Department'] = department;
    map['MobileNo'] = mobileNo;
    map['OTFrom'] = oTFrom;
    map['OTTo'] = oTTo;
    map['Hours'] = hours;
    map['ReasonForOT'] = reasonForOT;
    map['CreatedDate'] = createdDate;
    map['StausID'] = stausID;
    map['OTStatus'] = oTStatus;
    map['ApproverName'] = approverName;
    map['ApprovedBy'] = approvedBy;
    map['ApprovedDate'] = approvedDate;
    map['Description'] = description;
    map['CustomerName'] = customerName;
    return map;
  }

}