/// RtnStatus : true
/// RtnMessage : "Geo details Loaded Successfully."
/// RtnData : {"Table":[{"GeoID":33,"UserID":1,"FirstName":"Admin","StatusID":1,"GeoStatus":"Login","ColorCode":" #c4fbdb  ","ClientID":0,"NoofHandover":0,"NoofSample":0,"CustomerName":"","StatusAddress":"","Distance":"0","StatusDate":"22-05-2024","StatusTime":"12:55 PM","Latitude":"13.0951372","Longitude":"80.0761719"},{"GeoID":32,"UserID":1,"FirstName":"Admin","StatusID":2,"GeoStatus":"Logout","ColorCode":" #fcb891  ","ClientID":0,"NoofHandover":0,"NoofSample":0,"CustomerName":"","StatusAddress":"","Distance":"0","StatusDate":"22-05-2024","StatusTime":"10:56 AM","Latitude":"13.0951325","Longitude":"80.0761704"},{"GeoID":31,"UserID":1,"FirstName":"Admin","StatusID":1,"GeoStatus":"Login","ColorCode":" #c4fbdb  ","ClientID":0,"NoofHandover":0,"NoofSample":0,"CustomerName":"","StatusAddress":"","Distance":"0","StatusDate":"22-05-2024","StatusTime":"10:38 AM","Latitude":"13.0951307","Longitude":"80.0761822"}]}
/// OtherMsg : null
/// ID : 0

class GeoHistoryResponse {
  GeoHistoryResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData, 
      this.otherMsg, 
      this.id,);

  GeoHistoryResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    rtnData = json['RtnData'] != null ? GeoHistoryResponseData.fromJson(json['RtnData']) : null;
    otherMsg = json['OtherMsg'];
    id = json['ID'];
  }
  late bool rtnStatus;
  late String rtnMessage;
  late GeoHistoryResponseData? rtnData;
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

/// Table : [{"GeoID":33,"UserID":1,"FirstName":"Admin","StatusID":1,"GeoStatus":"Login","ColorCode":" #c4fbdb  ","ClientID":0,"NoofHandover":0,"NoofSample":0,"CustomerName":"","StatusAddress":"","Distance":"0","StatusDate":"22-05-2024","StatusTime":"12:55 PM","Latitude":"13.0951372","Longitude":"80.0761719"},{"GeoID":32,"UserID":1,"FirstName":"Admin","StatusID":2,"GeoStatus":"Logout","ColorCode":" #fcb891  ","ClientID":0,"NoofHandover":0,"NoofSample":0,"CustomerName":"","StatusAddress":"","Distance":"0","StatusDate":"22-05-2024","StatusTime":"10:56 AM","Latitude":"13.0951325","Longitude":"80.0761704"},{"GeoID":31,"UserID":1,"FirstName":"Admin","StatusID":1,"GeoStatus":"Login","ColorCode":" #c4fbdb  ","ClientID":0,"NoofHandover":0,"NoofSample":0,"CustomerName":"","StatusAddress":"","Distance":"0","StatusDate":"22-05-2024","StatusTime":"10:38 AM","Latitude":"13.0951307","Longitude":"80.0761822"}]

class GeoHistoryResponseData {
  GeoHistoryResponseData(
      this.table,);

  GeoHistoryResponseData.fromJson(dynamic json) {
    if (json['Table'] != null) {
      table = [];
      json['Table'].forEach((v) {
        table.add(GeoHistoryResponseTableData.fromJson(v));
      });
    }
  }
  late List<GeoHistoryResponseTableData> table;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (table != null) {
      map['Table'] = table.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// GeoID : 33
/// UserID : 1
/// FirstName : "Admin"
/// StatusID : 1
/// GeoStatus : "Login"
/// ColorCode : " #c4fbdb  "
/// ClientID : 0
/// NoofHandover : 0
/// NoofSample : 0
/// CustomerName : ""
/// StatusAddress : ""
/// Distance : "0"
/// StatusDate : "22-05-2024"
/// StatusTime : "12:55 PM"
/// Latitude : "13.0951372"
/// Longitude : "80.0761719"

class GeoHistoryResponseTableData {
  GeoHistoryResponseTableData(
      this.geoID, 
      this.userID, 
      this.firstName, 
      this.statusID, 
      this.geoStatus, 
      this.colorCode, 
      this.clientID, 
      this.noofHandover, 
      this.noofSample, 
      this.customerName, 
      this.statusAddress, 
      this.distance, 
      this.statusDate, 
      this.statusTime, 
      this.latitude, 
      this.longitude,);

  GeoHistoryResponseTableData.fromJson(dynamic json) {
    geoID = json['GeoID'];
    userID = json['UserID'];
    firstName = json['FirstName'];
    statusID = json['StatusID'];
    geoStatus = json['GeoStatus'];
    colorCode = json['ColorCode'];
    clientID = json['ClientID'];
    noofHandover = json['NoofHandover'];
    noofSample = json['NoofSample'];
    customerName = json['CustomerName'];
    statusAddress = json['StatusAddress'];
    distance = json['Distance'];
    statusDate = json['StatusDate'];
    statusTime = json['StatusTime'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }
 late  int geoID;
 late  int userID;
 late  String firstName;
 late  int statusID;
 late  String geoStatus;
 late  String colorCode;
 late  int clientID;
 late  int noofHandover;
 late  int noofSample;
 late  String customerName;
 late  String statusAddress;
 late  String distance;
 late  String statusDate;
 late  String statusTime;
 late  String latitude;
 late  String longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['GeoID'] = geoID;
    map['UserID'] = userID;
    map['FirstName'] = firstName;
    map['StatusID'] = statusID;
    map['GeoStatus'] = geoStatus;
    map['ColorCode'] = colorCode;
    map['ClientID'] = clientID;
    map['NoofHandover'] = noofHandover;
    map['NoofSample'] = noofSample;
    map['CustomerName'] = customerName;
    map['StatusAddress'] = statusAddress;
    map['Distance'] = distance;
    map['StatusDate'] = statusDate;
    map['StatusTime'] = statusTime;
    map['Latitude'] = latitude;
    map['Longitude'] = longitude;
    return map;
  }

}