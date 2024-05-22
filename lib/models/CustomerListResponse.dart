class CustomerListResponse {
  CustomerListResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  CustomerListResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(Customers.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<Customers> rtnData;

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

class Customers {
  Customers(
      this.customerID, 
      this.customerName, 
      this.customerAddress, 
      this.customerBranch, 
      this.latitude, 
      this.longitude, 
      this.conPerson, 
      this.mobileNo, 
      this.mailID, 
      this.userName, 
      this.password,
      this.qRCode,);

  Customers.fromJson(dynamic json) {
    customerID = json['CustomerID'];
    customerName = json['CustomerName'];
    customerAddress = json['CustomerAddress'];
    customerBranch = json['CustomerBranch'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    conPerson = json['ConPerson'];
    mobileNo = json['MobileNo'];
    mailID = json['MailID'];
    userName = json['UserName'];
    password = json['Password'];
    qRCode = json['QRCode'];
  }
  late int customerID;
  late String customerName;
  late String customerAddress;
  late String customerBranch;
  late String latitude;
  late String longitude;
  late String conPerson;
  late String mobileNo;
  late String mailID;
  late String userName;
  late String password;
  late String qRCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CustomerID'] = customerID;
    map['CustomerName'] = customerName;
    map['CustomerAddress'] = customerAddress;
    map['CustomerBranch'] = customerBranch;
    map['Latitude'] = latitude;
    map['Longitude'] = longitude;
    map['ConPerson'] = conPerson;
    map['MobileNo'] = mobileNo;
    map['MailID'] = mailID;
    map['UserName'] = userName;
    map['Password'] = password;
    map['QRCode'] = qRCode;
    return map;
  }

}