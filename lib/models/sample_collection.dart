class SampleCollection {
  SampleCollection(
      this.sampleMasterID, 
      this.customerID, 
      this.collectionType, 
      this.collectedFrom, 
      this.latLng, 
      this.geoAddress, 
      this.cuid, 
      this.samples,);

  SampleCollection.fromJson(dynamic json) {
    sampleMasterID = json['SampleMasterID'];
    customerID = json['CustomerID'];
    collectionType = json['CollectionType'];
    collectedFrom = json['CollectedFrom'];
    latLng = json['LatLng'];
    geoAddress = json['GeoAddress'];
    cuid = json['CUID'];
    if (json['Samples'] != null) {
      samples = [];
      json['Samples'].forEach((v) {
        samples.add(Samples.fromJson(v));
      });
    }
  }
  late int sampleMasterID;
  late int customerID;
  late int collectionType;
  late String collectedFrom;
  late String latLng;
  late String geoAddress;
  late int cuid;
  late List<Samples> samples;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SampleMasterID'] = sampleMasterID;
    map['CustomerID'] = customerID;
    map['CollectionType'] = collectionType;
    map['CollectedFrom'] = collectedFrom;
    map['LatLng'] = latLng;
    map['GeoAddress'] = geoAddress;
    map['CUID'] = cuid;
    if (samples != null) {
      map['Samples'] = samples.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Samples {
  Samples(
      this.patientName,
      this.mobileNo, 
      this.sampleTypeIDs, 
      this.noofSample, 
      this.sampleImage, 
      this.remarks, 
      this.isOnHandover,);

  Samples.fromJson(dynamic json) {
    patientName = json['PatientName'];
    mobileNo = json['MobileNo'];
    sampleTypeIDs = json['SampleTypeIDs'];
    noofSample = json['NoofSample'];
    sampleImage = json['SampleImage'];
    remarks = json['Remarks'];
    isOnHandover = json['IsOnHandover'];
  }
  late String patientName;
  late String mobileNo;
  late String sampleTypeIDs;
  late int noofSample;
  String sampleName='';
  late String sampleImage;
  String paths='';
  late String remarks;
  late bool isOnHandover;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PatientName'] = patientName;
    map['MobileNo'] = mobileNo;
    map['SampleTypeIDs'] = sampleTypeIDs;
    map['NoofSample'] = noofSample;
    map['SampleImage'] = sampleImage;
    map['Remarks'] = remarks;
    map['IsOnHandover'] = isOnHandover;
    return map;
  }

}