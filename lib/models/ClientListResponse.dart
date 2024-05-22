/// RtnStatus : true
/// RtnMessage : "Visitor's details Loaded"
/// RtnData : [{"GeoID":0,"MeetingTypeID":2,"ClientID":10,"ContactPerson":"John","Desigination":"Manager","PhoneNo":"1111111111","EmailID":"gsnathanece@gmail.com","MeetingStatusID":1,"Remarks":""},{"GeoID":0,"MeetingTypeID":2,"ClientID":11,"ContactPerson":"John","Desigination":"Manager","PhoneNo":"1111111111","EmailID":"gsnathanece@gmail.com","MeetingStatusID":1,"Remarks":""},{"GeoID":0,"MeetingTypeID":2,"ClientID":9,"ContactPerson":"john","Desigination":"vice President Marketing","PhoneNo":"8098789280","EmailID":"john@orbitoasia.com","MeetingStatusID":1,"Remarks":""},{"GeoID":0,"MeetingTypeID":1,"ClientID":10,"ContactPerson":"sakthee","Desigination":"Executive ","PhoneNo":"9894407062","EmailID":"sakthe@gmail.com","MeetingStatusID":1,"Remarks":""},{"GeoID":0,"MeetingTypeID":1,"ClientID":11,"ContactPerson":"sakthee","Desigination":"Executive ","PhoneNo":"9894407062","EmailID":"sakthe@gmail.com","MeetingStatusID":1,"Remarks":""},{"GeoID":0,"MeetingTypeID":1,"ClientID":6,"ContactPerson":"sakthi nagar","Desigination":"ghfj","PhoneNo":"655788565","EmailID":"","MeetingStatusID":1,"Remarks":""},{"GeoID":0,"MeetingTypeID":1,"ClientID":6,"ContactPerson":"ss","Desigination":"gg","PhoneNo":"6658.9","EmailID":"","MeetingStatusID":1,"Remarks":""},{"GeoID":0,"MeetingTypeID":1,"ClientID":10,"ContactPerson":"test","Desigination":"tesg","PhoneNo":"3333333333","EmailID":"tests@gmail.com","MeetingStatusID":1,"Remarks":""},{"GeoID":0,"MeetingTypeID":1,"ClientID":11,"ContactPerson":"test","Desigination":"tesg","PhoneNo":"3333333333","EmailID":"tests@gmail.com","MeetingStatusID":1,"Remarks":""}]

class ClientListResponse {
  ClientListResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  ClientListResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(Client.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<Client> rtnData;

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

/// GeoID : 0
/// MeetingTypeID : 2
/// ClientID : 10
/// ContactPerson : "John"
/// Desigination : "Manager"
/// PhoneNo : "1111111111"
/// EmailID : "gsnathanece@gmail.com"
/// MeetingStatusID : 1
/// Remarks : ""

class Client {
  Client(
      this.geoID, 
      this.meetingTypeID, 
      this.clientID, 
      this.contactPerson, 
      this.desigination, 
      this.phoneNo, 
      this.emailID, 
      this.meetingStatusID, 
      this.remarks,);

  Client.fromJson(dynamic json) {
    geoID = json['GeoID'];
    meetingTypeID = json['MeetingTypeID'];
    clientID = json['ClientID'];
    contactPerson = json['ContactPerson'];
    desigination = json['Desigination'];
    phoneNo = json['PhoneNo'];
    emailID = json['EmailID'];
    meetingStatusID = json['MeetingStatusID'];
    remarks = json['Remarks'];
  }
  late int geoID;
  late int meetingTypeID;
  late int clientID;
  late String contactPerson;
  late String desigination;
  late String phoneNo;
  late String emailID;
  late int meetingStatusID;
  late String remarks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['GeoID'] = geoID;
    map['MeetingTypeID'] = meetingTypeID;
    map['ClientID'] = clientID;
    map['ContactPerson'] = contactPerson;
    map['Desigination'] = desigination;
    map['PhoneNo'] = phoneNo;
    map['EmailID'] = emailID;
    map['MeetingStatusID'] = meetingStatusID;
    map['Remarks'] = remarks;
    return map;
  }

}