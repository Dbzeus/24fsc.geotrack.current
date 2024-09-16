import 'package:alice/alice.dart';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geotrack24fsc/helpers/colors.dart';
import 'package:geotrack24fsc/routes/app_pages.dart';
import 'package:geotrack24fsc/routes/app_routes.dart';
import 'package:geotrack24fsc/utils/notification.dart';
import 'package:geotrack24fsc/utils/services.dart';

import 'package:geotrack24fsc/utils/session.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

// overlay entry point

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await initializeService();
  //debugPaintSizeEnabled = true; for layout bound
  //check session
  await GetStorage.init();
  //firebase
  await FirebaseNotifcation().initialize();

  GetStorage box = GetStorage();
  String initial = Routes.onboarding;

  debugPrint("LOGIN: ${box.read(Session.isAppLogin).toString()}");

  if (box.read(Session.isMobileLogin) ?? false) {
    initial = Routes.mobileLogin;
  } else if (box.read(Session.isAppLogin) ?? false) {
    initial = Routes.home;
  }
  runApp(MyApp(initial));
}

@pragma('vm:entry-point',true)
Future<void> initializeService() async {
  //serviceTime = time;
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(
        // this will be executed when app is in foreground in separated isolate
          onForeground: onStart
        // you have to enable background fetch capability on xcode project
      ),
      androidConfiguration: AndroidConfiguration(
          isForegroundMode: true, autoStart: false, onStart: onStart,
      // initialNotificationContent: "Preparing",
      //     initialNotificationTitle: "Background Service",
      //     notificationChannelId: "123"
      ));
  service.startService();
}


class MyApp extends StatelessWidget {
  String initial;

  MyApp(this.initial, {super.key});

  static Alice alice = Alice(
    showNotification: true,
      showInspectorOnShake: true,
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '24FSC',
      navigatorKey: alice.getNavigatorKey(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: whiteColor,
          colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      initialRoute: initial,
      getPages: AppPages.routes,
    );
  }
}
