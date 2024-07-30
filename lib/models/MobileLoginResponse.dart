/// RtnStatus : true
/// RtnMessage : "Login successfully"
/// RtnData : [{"UserID":1,"FirstName":"Admin","LastName":"Developer","UserName":"9898989898","Password":"MTIzNDU=","MobileNo":"9898989898","MailID":"saktheeswaran.a@dbzeus.com","ImagePath":"","Address":"","BranchID":1,"BranchName":"24FSC-Hyd","RoleID":1,"RoleName":"MD","Designation":"Developer","OTP":2909,"MobileToken":"string","WebToken":"","IsActive":true,"IsRelive":false,"isCustomer":true,"IsMarketing":false,"IsILT":false,"CustomerID":0}]
/// OtherMsg : null
/// ID : 0

class MobileLoginResponse {
  MobileLoginResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData, 
      this.otherMsg, 
      this.id,);

  MobileLoginResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(RtnData.fromJson(v));
      });
    }
    otherMsg = json['OtherMsg'];
    id = json['ID'];
  }
 late bool rtnStatus;
 late String rtnMessage;
 late List<RtnData> rtnData;
 late dynamic otherMsg;
 late int id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RtnStatus'] = rtnStatus;
    map['RtnMessage'] = rtnMessage;
    if (rtnData != null) {
      map['RtnData'] = rtnData.map((v) => v.toJson()).toList();
    }
    map['OtherMsg'] = otherMsg;
    map['ID'] = id;
    return map;
  }

}

/// UserID : 1
/// FirstName : "Admin"
/// LastName : "Developer"
/// UserName : "9898989898"
/// Password : "MTIzNDU="
/// MobileNo : "9898989898"
/// MailID : "saktheeswaran.a@dbzeus.com"
/// ImagePath : ""
/// Address : ""
/// BranchID : 1
/// BranchName : "24FSC-Hyd"
/// RoleID : 1
/// RoleName : "MD"
/// Designation : "Developer"
/// OTP : 2909
/// MobileToken : "string"
/// WebToken : ""
/// IsActive : true
/// IsRelive : false
/// isCustomer : true
/// IsMarketing : false
/// IsILT : false
/// CustomerID : 0

class RtnData {
  RtnData(
      this.userID, 
      this.firstName, 
      this.lastName, 
      this.userName, 
      this.password, 
      this.mobileNo, 
      this.mailID, 
      this.imagePath, 
      this.address, 
      this.branchID, 
      this.branchName, 
      this.roleID, 
      this.roleName, 
      this.designation, 
      this.otp, 
      this.mobileToken, 
      this.webToken, 
      this.isActive, 
      this.isRelive, 
      this.isCustomer, 
      this.isMarketing, 
      this.isILT, 
      this.customerID,);

  RtnData.fromJson(dynamic json) {
    userID = json['UserID'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    userName = json['UserName'];
    password = json['Password'];
    mobileNo = json['MobileNo'];
    mailID = json['MailID'];
    imagePath = json['ImagePath'];
    address = json['Address'];
    branchID = json['BranchID'];
    branchName = json['BranchName'];
    roleID = json['RoleID'];
    roleName = json['RoleName'];
    designation = json['Designation'];
    otp = json['OTP'];
    mobileToken = json['MobileToken'];
    webToken = json['WebToken'];
    isActive = json['IsActive'];
    isRelive = json['IsRelive'];
    isCustomer = json['isCustomer'];
    isMarketing = json['IsMarketing'];
    isILT = json['IsILT'];
    customerID = json['CustomerID'];
    empId = json['EmployeeID'];
    timeInterval = json['TimeInterval'];
    autoLogoutTime = json['Autologouttime'];
  }
  late int userID;
  late String firstName;
  late String lastName;
  late String userName;
  late String password;
  late String mobileNo;
  late String mailID;
  late String imagePath;
  late String address;
  late int branchID;
  late String branchName;
  late int roleID;
  late String roleName;
  late String designation;
  late int otp;
  late String mobileToken;
  late String webToken;
  late bool isActive;
  late bool isRelive;
  late bool isCustomer;
  late bool isMarketing;
  late bool isILT;
  late int customerID;
  late int empId;
  late int timeInterval;
  late String autoLogoutTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserID'] = userID;
    map['FirstName'] = firstName;
    map['LastName'] = lastName;
    map['UserName'] = userName;
    map['Password'] = password;
    map['MobileNo'] = mobileNo;
    map['MailID'] = mailID;
    map['ImagePath'] = imagePath;
    map['Address'] = address;
    map['BranchID'] = branchID;
    map['BranchName'] = branchName;
    map['RoleID'] = roleID;
    map['RoleName'] = roleName;
    map['Designation'] = designation;
    map['OTP'] = otp;
    map['MobileToken'] = mobileToken;
    map['WebToken'] = webToken;
    map['IsActive'] = isActive;
    map['IsRelive'] = isRelive;
    map['isCustomer'] = isCustomer;
    map['IsMarketing'] = isMarketing;
    map['IsILT'] = isILT;
    map['CustomerID'] = customerID;
     map['EmployeeID']=empId;
    map['TimeInterval'] = timeInterval;
    map['Autologouttime'] = autoLogoutTime;
    return map;
  }

}