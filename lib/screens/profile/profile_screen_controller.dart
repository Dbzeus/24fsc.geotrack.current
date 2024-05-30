import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../apis/api_call.dart';
import '../../models/MenuResponse.dart';
import '../../routes/app_routes.dart';
import '../../utils/constants.dart';
import '../../utils/dialogs.dart';
import '../../utils/loader.dart';
import '../../utils/session.dart';

class ProfileScreenController extends GetxController{

  RxList menus= [
    {
      'title' : "Dashboard",
      'path' : "assets/menu/dashboard.svg",
      'route' : Routes.dashboard
    },
    {
      'title' : "Visiting Report",
      'path' : "assets/menu/visitingreport.svg",
      'route' : Routes.visitingReport
    },
    {
      'title' : "Activities",
      'path' : "assets/menu/activity.svg",
      'route' : Routes.activities
    },
    {
      'title' : "Notification",
      'path' : "assets/menu/notification.svg",
      'route' : ''
    },
    {
      'title' : "Circular",
      'path' : "assets/menu/circular.svg",
      'route' : Routes.circular
    }

  ].obs;



  RxBool isLoading=false.obs;
  final _box=GetStorage();
  RxList<Menu> menu1=RxList();
  String mobileNo='';

  RxString name=''.obs,designation=''.obs, role=''.obs,image=''.obs, version=''.obs;

  @override
  void onInit() {
    super.onInit();
    name(_box.read(Session.firstName) ?? '');
    role(_box.read(Session.roleName) ?? '');
    designation(_box.read(Session.designation) ?? '');
    image(_box.read(Session.userImage) ?? '');
    version(_box.read(Session.version) ?? '');
    mobileNo=_box.read(Session.userPhone) ?? '';

    try {
      log(_box.read(Session.appMenu));
      var menu = jsonDecode(_box.read(Session.appMenu) ?? '[]');
      menu.forEach((v) {
        menus.add(Menu.fromJson(v));
      });
    }catch(e){
      //ignored
    }
    getMenus();
  }

  getMenus()async{
    if(await isNetConnected()){
      var response=await ApiCall().getMenus('${_box.read(Session.roleId) ?? -1}');
      if(response!=null){
        if(response.rtnStatus){
          _box.write(Session.appMenu, jsonEncode(response.rtnData));
          menu1(response.rtnData);
        }
      }
    }
  }

  void appLogout({bool? isHaveDialog}) async {
    bool? resp = false;
    if (isHaveDialog == null) {
      resp = await showAlert(
        'Logout?',
        'Are you sure to logout from app.',
        'Logout',
      );
    } else {
      resp = true;
    }

    if (resp != null && resp) {
      showLoader(title: 'Logging Out');
      _box.erase();
      _box.write(Session.isMobileLogin, true);
      hideLoader();
      Get.offAllNamed(Routes.mobileLogin);
    }
  }

}