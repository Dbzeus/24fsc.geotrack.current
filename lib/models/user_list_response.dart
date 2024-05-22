class UserListResponse {
  UserListResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  UserListResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(UserList.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<UserList> rtnData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RtnStatus'] = rtnStatus;
    map['RtnMessage'] = rtnMessage;
    map['RtnData'] = rtnData.map((v) => v.toJson()).toList();
    return map;
  }

}

class UserList {
  UserList(
      this.employeeID, 
      this.userID, 
      this.firstName, 
      this.lastName, 
      this.mobileNo, 
      this.mailID, 
      this.imagePath, 
      this.documentPath, 
      this.address, 
      this.currentAddress, 
      this.qualification, 
      this.alternativeMobile, 
      this.mobileMake, 
      this.mobileModel, 
      this.mobileIMEI, 
      this.vehicleMake, 
      this.vehicleModel, 
      this.vehicleRegNo, 
      this.dLNo, 
      this.dLExpDt, 
      this.emergencyConName, 
      this.emergencyConNo, 
      this.emergencyConRelationship, 
      this.dateofJoin, 
      this.dateofBirth, 
      this.branchID, 
      this.branchName, 
      this.roleID, 
      this.roleName, 
      this.designation, 
      this.isActive, 
      this.isRelive, 
      this.dateofRelive, 
      this.relivingReason, 
      this.cuid, 
      this.cUDate, 
      this.faceDate, 
      this.userName, 
      this.password, 
      this.lastLogin,);

  UserList.fromJson(dynamic json) {
    employeeID = json['EmployeeID'];
    userID = json['UserID'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    mobileNo = json['MobileNo'];
    mailID = json['MailID'];
    imagePath = json['ImagePath'];
    documentPath = json['DocumentPath'];
    address = json['Address'];
    currentAddress = json['CurrentAddress'];
    qualification = json['Qualification'];
    alternativeMobile = json['AlternativeMobile'];
    mobileMake = json['MobileMake'];
    mobileModel = json['MobileModel'];
    mobileIMEI = json['MobileIMEI'];
    vehicleMake = json['VehicleMake'];
    vehicleModel = json['VehicleModel'];
    vehicleRegNo = json['VehicleRegNo'];
    dLNo = json['DLNo'];
    dLExpDt = json['DLExpDt'];
    emergencyConName = json['EmergencyConName'];
    emergencyConNo = json['EmergencyConNo'];
    emergencyConRelationship = json['EmergencyConRelationship'];
    dateofJoin = json['DateofJoin'];
    dateofBirth = json['DateofBirth'];
    branchID = json['BranchID'];
    branchName = json['BranchName'];
    roleID = json['RoleID'];
    roleName = json['RoleName'];
    designation = json['Designation'];
    isActive = json['IsActive'];
    isRelive = json['IsRelive'];
    dateofRelive = json['DateofRelive'];
    relivingReason = json['RelivingReason'];
    cuid = json['CUID'];
    cUDate = json['CUDate'];
    faceDate = json['FaceDate'];
    userName = json['UserName'];
    password = json['Password'];
    lastLogin = json['LastLogin'];
  }

  late num employeeID;
  late num userID;
  late String firstName;
  late String lastName;
  late String mobileNo;
  late String mailID;
  late String imagePath;
  late String documentPath;
  late String address;
  late String currentAddress;
  late String qualification;
  late String alternativeMobile;
  late String mobileMake;
  late String mobileModel;
  late String mobileIMEI;
  late String vehicleMake;
  late String vehicleModel;
  late String vehicleRegNo;
  late String dLNo;
  late String dLExpDt;
  late String emergencyConName;
  late String emergencyConNo;
  late String emergencyConRelationship;
  late String dateofJoin;
  late String dateofBirth;
  late num branchID;
  late String branchName;
  late num roleID;
  late String roleName;
  late String designation;
  late bool isActive;
  late bool isRelive;
  late String dateofRelive;
  late String relivingReason;
  late num cuid;
  late String cUDate;
  late dynamic faceDate;
  late String userName;
  late String password;
  late String lastLogin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['EmployeeID'] = employeeID;
    map['UserID'] = userID;
    map['FirstName'] = firstName;
    map['LastName'] = lastName;
    map['MobileNo'] = mobileNo;
    map['MailID'] = mailID;
    map['ImagePath'] = imagePath;
    map['DocumentPath'] = documentPath;
    map['Address'] = address;
    map['CurrentAddress'] = currentAddress;
    map['Qualification'] = qualification;
    map['AlternativeMobile'] = alternativeMobile;
    map['MobileMake'] = mobileMake;
    map['MobileModel'] = mobileModel;
    map['MobileIMEI'] = mobileIMEI;
    map['VehicleMake'] = vehicleMake;
    map['VehicleModel'] = vehicleModel;
    map['VehicleRegNo'] = vehicleRegNo;
    map['DLNo'] = dLNo;
    map['DLExpDt'] = dLExpDt;
    map['EmergencyConName'] = emergencyConName;
    map['EmergencyConNo'] = emergencyConNo;
    map['EmergencyConRelationship'] = emergencyConRelationship;
    map['DateofJoin'] = dateofJoin;
    map['DateofBirth'] = dateofBirth;
    map['BranchID'] = branchID;
    map['BranchName'] = branchName;
    map['RoleID'] = roleID;
    map['RoleName'] = roleName;
    map['Designation'] = designation;
    map['IsActive'] = isActive;
    map['IsRelive'] = isRelive;
    map['DateofRelive'] = dateofRelive;
    map['RelivingReason'] = relivingReason;
    map['CUID'] = cuid;
    map['CUDate'] = cUDate;
    map['FaceDate'] = faceDate;
    map['UserName'] = userName;
    map['Password'] = password;
    map['LastLogin'] = lastLogin;
    return map;
  }

}