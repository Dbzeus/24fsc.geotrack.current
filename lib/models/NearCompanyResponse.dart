class NearCompanyResponse {
  NearCompanyResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  NearCompanyResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(Company.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<Company> rtnData;

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

class Company {
  Company(
      this.customerID, 
      this.customerName, 
      this.customerAddress, 
      this.distanceInMtrs, 
      this.qRCode,);

  Company.fromJson(dynamic json) {
    customerID = json['CustomerID'];
    customerName = json['CustomerName'];
    customerAddress = json['CustomerAddress'];
    distanceInMtrs = json['DistanceInMtrs'];
    qRCode = json['QRCode'];
  }
  late int customerID;
  late String customerName;
  late String customerAddress;
  late double distanceInMtrs;
  late String qRCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CustomerID'] = customerID;
    map['CustomerName'] = customerName;
    map['CustomerAddress'] = customerAddress;
    map['DistanceInMtrs'] = distanceInMtrs;
    map['QRCode'] = qRCode;
    return map;
  }

}