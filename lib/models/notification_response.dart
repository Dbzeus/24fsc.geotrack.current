/// Status : true
/// RtnMessage : "Notification details Loaded successfully"
/// ReturnData : [{"NotificationMsg":"Customer Individual Customer has been InPrograss ticket #HDN22122021161","NotificationTitle":"Mehala Support Desk","CuDate":"22-12-2021 14:05"}]

class NotificationResponse {
  NotificationResponse(
      this.status, 
      this.rtnMessage, 
      this.returnData,);

  NotificationResponse.fromJson(dynamic json) {
    status = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      returnData = [];
      json['RtnData'].forEach((v) {
        returnData.add(NotificationDetail.fromJson(v));
      });
    }
  }
  late bool status;
  late String rtnMessage;
  late List<NotificationDetail> returnData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RtnStatus'] = status;
    map['RtnMessage'] = rtnMessage;
    if (returnData != null) {
      map['RtnData'] = returnData.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// NotificationMsg : "Customer Individual Customer has been InPrograss ticket #HDN22122021161"
/// NotificationTitle : "Mehala Support Desk"
/// CuDate : "22-12-2021 14:05"

class NotificationDetail {
  NotificationDetail(
      this.notificationMsg, 
      this.notificationTitle, 
      this.cuDate,);

  NotificationDetail.fromJson(dynamic json) {
    notificationMsg = json['NotificationMsg'];
    notificationTitle = json['NotificationTitle'];
    cuDate = json['CuDate'];
  }
  late String notificationMsg;
  late String notificationTitle;
  late String cuDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['NotificationMsg'] = notificationMsg;
    map['NotificationTitle'] = notificationTitle;
    map['CuDate'] = cuDate;
    return map;
  }

}