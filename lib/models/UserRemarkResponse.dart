class UserRemarkResponse {
  UserRemarkResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  UserRemarkResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(UserRemarks.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<UserRemarks> rtnData;

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


class UserRemarks {
  UserRemarks(
    this.userID,
    this.remarkDate,
    this.remark,
    this.cuid,
    this.createdOn,);

  UserRemarks.fromJson(dynamic json) {
    userID = json['UserID'];
    remarkDate = json['RemarkDate'];
    remark = json['Remark'];
    cuid = json['CUID'];
    createdOn = json['CreatedOn'];
  }
  late int userID;
  late String remarkDate;
  late String remark;
  late int cuid;
  late String createdOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserID'] = userID;
    map['RemarkDate'] = remarkDate;
    map['Remark'] = remark;
    map['CUID'] = cuid;
    map['CreatedOn'] = createdOn;
    return map;
  }

}