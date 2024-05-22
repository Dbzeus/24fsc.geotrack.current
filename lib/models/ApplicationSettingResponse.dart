/// RtnStatus : true
/// RtnMessage : "Application Detaila."
/// RtnData : {"ApplicationSetting":[{"UserID":1,"IsSelfy":false,"IsQRCode":false,"IsGeoTrack":false,"FaceIdentify":false,"LastStatusID":2,"LastStatusTime":"","LastLoginID":0,"LastLoginTime":"","CheckInID":0,"CustomerID":0,"CheckInTime":"","MeetInTime":"","FaceData":"","FaceImage":"","UserImage":"base 64 img","AppVersion":"1.0.0","DeviceID":"1e3d24158e7d9eec","Devicechecking":true,"IsLoginContinue":false,"IsOTContinue":false,"StatusMsg":""}],"Status":[{"StatusID":1,"GeoStatus":"Login","ColorCode":" #c4fbdb  ","IsCompanyReq":false,"IsLocationRequired":true,"StatusIcon":"NoImage.png","Path":""}]}
/// OtherMsg : null
/// ID : 0

class ApplicationSettingResponse {
  ApplicationSettingResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,
      this.otherMsg, 
      this.id,);

  ApplicationSettingResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    rtnData = json['RtnData'] != null ? ApplicationSettingResponseData.fromJson(json['RtnData']) : null;
    otherMsg = json['OtherMsg'];
    id = json['ID'];
  }
  late bool rtnStatus;
  late String rtnMessage;
  late ApplicationSettingResponseData? rtnData;
  late dynamic otherMsg;
  late int id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RtnStatus'] = rtnStatus;
    map['RtnMessage'] = rtnMessage;
    if (rtnData != null) {
      map['RtnData'] = rtnData!.toJson();
    }
    map['OtherMsg'] = otherMsg;
    map['ID'] = id;
    return map;
  }

}

/// ApplicationSetting : [{"UserID":1,"IsSelfy":false,"IsQRCode":false,"IsGeoTrack":false,"FaceIdentify":false,"LastStatusID":2,"LastStatusTime":"","LastLoginID":0,"LastLoginTime":"","CheckInID":0,"CustomerID":0,"CheckInTime":"","MeetInTime":"","FaceData":"","FaceImage":"","UserImage":"base 64 img","AppVersion":"1.0.0","DeviceID":"1e3d24158e7d9eec","Devicechecking":true,"IsLoginContinue":false,"IsOTContinue":false,"StatusMsg":""}]
/// Status : [{"StatusID":1,"GeoStatus":"Login","ColorCode":" #c4fbdb  ","IsCompanyReq":false,"IsLocationRequired":true,"StatusIcon":"NoImage.png","Path":""}]

class ApplicationSettingResponseData {
  ApplicationSettingResponseData(
      this.applicationSetting, 
      this.status,);

  ApplicationSettingResponseData.fromJson(dynamic json) {
    if (json['ApplicationSetting'] != null) {
      applicationSetting = [];
      json['ApplicationSetting'].forEach((v) {
        applicationSetting.add(ApplicationSetting.fromJson(v));
      });
    }
    if (json['Status'] != null) {
      status = [];
      json['Status'].forEach((v) {
        status.add(Status.fromJson(v));
      });
    }
  }
  late List<ApplicationSetting> applicationSetting;
  late List<Status> status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (applicationSetting != null) {
      map['ApplicationSetting'] = applicationSetting.map((v) => v.toJson()).toList();
    }
    if (status != null) {
      map['Status'] = status.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// StatusID : 1
/// GeoStatus : "Login"
/// ColorCode : " #c4fbdb  "
/// IsCompanyReq : false
/// IsLocationRequired : true
/// StatusIcon : "NoImage.png"
/// Path : ""

class Status {
  Status(
      this.statusID, 
      this.geoStatus, 
      this.colorCode, 
      this.isCompanyReq, 
      this.isLocationRequired, 
      this.statusIcon, 
      this.path);

  Status.fromJson(dynamic json) {
    statusID = json['StatusID'];
    geoStatus = json['GeoStatus'];
    colorCode = json['ColorCode'];
    isCompanyReq = json['IsCompanyReq'];
    isLocationRequired = json['IsLocationRequired'];
    statusIcon = json['StatusIcon'];
    path = json['Path'];
  }
  late int statusID;
  late String geoStatus;
  late String colorCode;
  late bool isCompanyReq;
  late bool isLocationRequired;
  late String statusIcon;
  late String path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StatusID'] = statusID;
    map['GeoStatus'] = geoStatus;
    map['ColorCode'] = colorCode;
    map['IsCompanyReq'] = isCompanyReq;
    map['IsLocationRequired'] = isLocationRequired;
    map['StatusIcon'] = statusIcon;
    map['Path'] = path;
    return map;
  }

}

/// UserID : 1
/// IsSelfy : false
/// IsQRCode : false
/// IsGeoTrack : false
/// FaceIdentify : false
/// LastStatusID : 2
/// LastStatusTime : ""
/// LastLoginID : 0
/// LastLoginTime : ""
/// CheckInID : 0
/// CustomerID : 0
/// CheckInTime : ""
/// MeetInTime : ""
/// FaceData : ""
/// FaceImage : ""
/// UserImage : "base 64 img"
/// AppVersion : "1.0.0"
/// DeviceID : "1e3d24158e7d9eec"
/// Devicechecking : true
/// IsLoginContinue : false
/// IsOTContinue : false
/// StatusMsg : ""

class ApplicationSetting {
  ApplicationSetting(
      this.userID, 
      this.isSelfy, 
      this.isQRCode, 
      this.isGeoTrack, 
      this.faceIdentify, 
      this.lastStatusID, 
      this.lastStatusTime, 
      this.lastLoginID, 
      this.lastLoginTime, 
      this.checkInID, 
      this.customerID, 
      this.checkInTime, 
      this.meetInTime, 
      this.faceData, 
      this.faceImage, 
      this.userImage, 
      this.appVersion, 
      this.deviceID, 
      this.devicechecking, 
      this.isLoginContinue, 
      this.isOTContinue, 
      this.statusMsg,);

  ApplicationSetting.fromJson(dynamic json) {
    userID = json['UserID'];
    isSelfy = json['IsSelfy'];
    isQRCode = json['IsQRCode'];
    isGeoTrack = json['IsGeoTrack'];
    faceIdentify = json['FaceIdentify'];
    lastStatusID = json['LastStatusID'];
    lastStatusTime = json['LastStatusTime'];
    lastLoginID = json['LastLoginID'];
    lastLoginTime = json['LastLoginTime'];
    checkInID = json['CheckInID'];
    customerID = json['CustomerID'];
    checkInTime = json['CheckInTime'];
    meetInTime = json['MeetInTime'];
    faceData = json['FaceData'];
    faceImage = json['FaceImage'];
    userImage = json['UserImage'];
    appVersion = json['AppVersion'];
    deviceID = json['DeviceID'];
    devicechecking = json['Devicechecking'];
    isLoginContinue = json['IsLoginContinue'];
    isOTContinue = json['IsOTContinue'];
    statusMsg = json['StatusMsg'];
  }
  late int userID;
  late bool isSelfy;
  late bool isQRCode;
  late bool isGeoTrack;
  late bool faceIdentify;
  late int lastStatusID;
  late String lastStatusTime;
  late int lastLoginID;
  late String lastLoginTime;
  late int checkInID;
  late int customerID;
  late String checkInTime;
  late String meetInTime;
  late String faceData;
  late String faceImage;
  late String userImage;
  late String appVersion;
  late String deviceID;
  late bool devicechecking;
  late bool isLoginContinue;
  late bool isOTContinue;
  late String statusMsg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserID'] = userID;
    map['IsSelfy'] = isSelfy;
    map['IsQRCode'] = isQRCode;
    map['IsGeoTrack'] = isGeoTrack;
    map['FaceIdentify'] = faceIdentify;
    map['LastStatusID'] = lastStatusID;
    map['LastStatusTime'] = lastStatusTime;
    map['LastLoginID'] = lastLoginID;
    map['LastLoginTime'] = lastLoginTime;
    map['CheckInID'] = checkInID;
    map['CustomerID'] = customerID;
    map['CheckInTime'] = checkInTime;
    map['MeetInTime'] = meetInTime;
    map['FaceData'] = faceData;
    map['FaceImage'] = faceImage;
    map['UserImage'] = userImage;
    map['AppVersion'] = appVersion;
    map['DeviceID'] = deviceID;
    map['Devicechecking'] = devicechecking;
    map['IsLoginContinue'] = isLoginContinue;
    map['IsOTContinue'] = isOTContinue;
    map['StatusMsg'] = statusMsg;
    return map;
  }

}