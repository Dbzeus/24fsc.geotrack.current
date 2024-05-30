import 'package:get_storage/get_storage.dart';

class Session {
  //int
  static const String userid = "userid";
  static const String isMobileNumberVerified = "isMobileNumberVerified";

  //boolean

  static const String appVersion = "appVersion";
  static const String deviceID = "deviceID";

  static const String isAppLogin = "isAppLogin";
  static const String isMobileLogin = "isMobileLogin";
  static const String isAutoFetch = "isAutoFetch";
  static const String isRunnerCancelling = "isRunnerCancelling";
  static const String isCustomer = "isCustomer";
  static const String isMarketing = "isMarketing";
  static const String isILT = "isILT";

  //String
  static const String token = "token";
  static const String version = "version";
  static const String userImage = "userImage";
  static const String firstName = "firstName";
  static const String userEmail = "userEmail";
  static const String userPhone = "userPhone";
  static const String branchId = "branchId";
  static const String customerId = "customerId";
  static const String branchName = "branchName";
  static const String roleId = "roleId";
  static const String roleName = "roleName";
  static const String designation = "designation";
  static const String appMenu = "appMenu";

  /*static sessionLogout(GetStorage _box){
    String mobile=_box.read(userPhone) ?? '';
    String password="";
    if(_box.read(isRememberMe) ?? false){
      password=_box.read(password) ?? '';
    }
    _box.erase();
    _box.write(userPhone, mobile);
    _box.write(password, password);
    _box.write(isMobileNumberVerified, true);
  }
*/
}
