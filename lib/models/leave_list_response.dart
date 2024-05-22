class LeaveListResponse {
  LeaveListResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  LeaveListResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    rtnData = RtnData.fromJson(json['RtnData']);
  }
  late bool rtnStatus;
  late String rtnMessage;
  late RtnData rtnData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RtnStatus'] = rtnStatus;
    map['RtnMessage'] = rtnMessage;
    if (rtnData != null) {
      map['RtnData'] = rtnData.toJson();
    }
    return map;
  }

}

class RtnData {
  RtnData(
      this.dTOs, 
      this.noofDayCL, 
      this.noofDayCW,);

  RtnData.fromJson(dynamic json) {
    if (json['DTOs'] != null) {
      dTOs = [];
      json['DTOs'].forEach((v) {
        dTOs.add(LeaveList.fromJson(v));
      });
    }
    noofDayCL = json['NoofDayCL'];
    noofDayCW = json['NoofDayCW'];
    description = json['Description'];
  }
  late List<LeaveList> dTOs;
  late String noofDayCL;
  late String noofDayCW;
  late String description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dTOs != null) {
      map['DTOs'] = dTOs.map((v) => v.toJson()).toList();
    }
    map['NoofDayCL'] = noofDayCL;
    map['NoofDayCW'] = noofDayCW;
    map['Description'] = description;
    return map;
  }

}

class LeaveList {
  LeaveList(
      this.leaveID, 
      this.userID, 
      this.empName, 
      this.desigination, 
      this.branch, 
      this.department, 
      this.mobileNo, 
      this.leaveFrom, 
      this.leaveTo, 
      this.noofDaysLeave, 
      this.reasonForLeave, 
      this.createdDate, 
      this.stausID, 
      this.leaveStatus, 
      this.approverName, 
      this.approvedBy, 
      this.approvedDate,
      this.description,
      this.isCompOff, 
      this.leaveType,);

  LeaveList.fromJson(dynamic json) {
    leaveID = json['LeaveID'];
    userID = json['UserID'];
    empName = json['EmpName'];
    desigination = json['Desigination'];
    branch = json['Branch'];
    department = json['Department'];
    mobileNo = json['MobileNo'];
    leaveFrom = json['LeaveFrom'];
    leaveTo = json['LeaveTo'];
    noofDaysLeave = json['NoofDaysLeave'];
    reasonForLeave = json['ReasonForLeave'];
    createdDate = json['CreatedDate'];
    stausID = json['StausID'];
    leaveStatus = json['LeaveStatus'];
    approverName = json['ApproverName'];
    approvedBy = json['ApprovedBy'];
    approvedDate = json['ApprovedDate'];
    description = json['Description'];
    isCompOff = json['IsCompOff'];
    leaveType = json['LeaveType'];
  }
  late int leaveID;
  late int userID;
  late String empName;
  late String desigination;
  late String branch;
  late String department;
  late String mobileNo;
  late String leaveFrom;
  late String leaveTo;
  late int noofDaysLeave;
  late String reasonForLeave;
  late String createdDate;
  late int stausID;
  late String leaveStatus;
  late String approverName;
  late int approvedBy;
  late String approvedDate;
  late String description;
  late bool isCompOff;
  late int leaveType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['LeaveID'] = leaveID;
    map['UserID'] = userID;
    map['EmpName'] = empName;
    map['Desigination'] = desigination;
    map['Branch'] = branch;
    map['Department'] = department;
    map['MobileNo'] = mobileNo;
    map['LeaveFrom'] = leaveFrom;
    map['LeaveTo'] = leaveTo;
    map['NoofDaysLeave'] = noofDaysLeave;
    map['ReasonForLeave'] = reasonForLeave;
    map['CreatedDate'] = createdDate;
    map['StausID'] = stausID;
    map['LeaveStatus'] = leaveStatus;
    map['ApproverName'] = approverName;
    map['ApprovedBy'] = approvedBy;
    map['ApprovedDate'] = approvedDate;
    map['Description'] = description;
    map['IsCompOff'] = isCompOff;
    map['LeaveType'] = leaveType;
    return map;
  }

}