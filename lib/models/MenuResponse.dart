class MenuResponse {
  MenuResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  MenuResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(Menu.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<Menu> rtnData;

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

class Menu {
  Menu(
      this.mainMenuID, 
      this.mainMenu, 
      this.menuOrder, 
      this.subMenu,);

  Menu.fromJson(dynamic json) {
    mainMenuID = json['MainMenuID'];
    mainMenu = json['MainMenu'];
    menuOrder = json['MenuOrder'];
    if (json['SubMenu'] != null) {
      subMenu = [];
      json['SubMenu'].forEach((v) {
        subMenu.add(SubMenu.fromJson(v));
      });
    }
  }
  late int mainMenuID;
  late String mainMenu;
  late int menuOrder;
  late List<SubMenu> subMenu;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['MainMenuID'] = mainMenuID;
    map['MainMenu'] = mainMenu;
    map['MenuOrder'] = menuOrder;
    if (subMenu != null) {
      map['SubMenu'] = subMenu.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class SubMenu {
  SubMenu(
      this.mainMenuID, 
      this.titleID, 
      this.title, 
      this.action, 
      this.titleOrder, 
      this.isActive, 
      this.icon,);

  SubMenu.fromJson(dynamic json) {
    mainMenuID = json['MainMenuID'];
    titleID = json['TitleID'];
    title = json['Title'];
    action = json['Action'];
    titleOrder = json['TitleOrder'];
    isActive = json['IsActive'];
    icon = json['Icon'];
  }
  late int mainMenuID;
  late int titleID;
  late String title;
  late String action;
  late int titleOrder;
  late bool isActive;
  late String icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['MainMenuID'] = mainMenuID;
    map['TitleID'] = titleID;
    map['Title'] = title;
    map['Action'] = action;
    map['TitleOrder'] = titleOrder;
    map['IsActive'] = isActive;
    map['Icon'] = icon;
    return map;
  }

}