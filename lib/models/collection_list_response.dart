class CollectionListResponse {
  CollectionListResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  CollectionListResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(SampleCollection.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<SampleCollection> rtnData;

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

class SampleCollection {
  SampleCollection(
      this.sampleID, 
      this.customerName, 
      this.patientName, 
      this.mobileNo, 
      this.noofSample, 
      this.noofHandover, 
      this.sampleImage, 
      this.remarks, 
      this.sampleColledtedTime, 
      this.onhand, 
      this.sampleTypes,);

  SampleCollection.fromJson(dynamic json) {
    sampleID = json['SampleID'];
    customerName = json['CustomerName'];
    patientName = json['PatientName'];
    mobileNo = json['MobileNo'];
    noofSample = json['NoofSample'];
    // noofHandover = json['NoofHandover'];
    sampleImage = json['SampleImage'];
    remarks = json['Remarks'];
    sampleColledtedTime = json['SampleColledtedTime'];
    onhand = json['Onhand'];
    sampleTypes = json['SampleTypes'];
  }
  late int sampleID;
  late String customerName;
  late String patientName;
  late String mobileNo;
  late int noofSample;
  int noofHandover=0;
  late String sampleImage;
  late String remarks;
  late String sampleColledtedTime;
  late int onhand;
  late String sampleTypes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SampleID'] = sampleID;
    map['CustomerName'] = customerName;
    map['PatientName'] = patientName;
    map['MobileNo'] = mobileNo;
    map['NoofSample'] = noofSample;
    map['NoofHandover'] = noofHandover;
    map['SampleImage'] = sampleImage;
    map['Remarks'] = remarks;
    map['SampleColledtedTime'] = sampleColledtedTime;
    map['Onhand'] = onhand;
    map['SampleTypes'] = sampleTypes;
    return map;
  }

}