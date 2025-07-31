

import 'package:alice/alice.dart';
import 'package:alice/model/alice_configuration.dart';
import 'package:alice_dio/alice_dio_adapter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geotrack24fsc/helpers/colors.dart';
import 'package:geotrack24fsc/routes/app_pages.dart';
import 'package:geotrack24fsc/routes/app_routes.dart';
import 'package:geotrack24fsc/screens/home/home_screen.dart';

import 'package:geotrack24fsc/utils/notification.dart';
import 'package:geotrack24fsc/utils/services.dart';

import 'package:geotrack24fsc/utils/session.dart';
import 'package:geotrack24fsc/screens/service_overlay/service_overlay.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

// overlay entry point

// @pragma('vm:entry-point',true)
void  main() async {
   WidgetsFlutterBinding.ensureInitialized();
  //await initializeService();
  //debugPaintSizeEnabled = true; for layout bound
  //check session
  await GetStorage.init();
  //firebase

  // try {
  //   final apps = Firebase.apps;
  //   if (apps.isEmpty) {
  //     await Firebase.initializeApp();
  //   }
  // } catch (e) {
  //   print("Firebase already initialized: $e");
  // }\



   if(Firebase.apps.isEmpty){
     await Firebase.initializeApp(
         name: "24fsc geotrack",
         options: const FirebaseOptions(
           apiKey: 'AIzaSyD-yyKSEHCxTnszn2wASaPklTxoCU0U5oQ',
           appId: '1:734068954892:android:dd7d9d64ad3260cd0e5b29',
           messagingSenderId: '734068954892',
           projectId: 'fscgeotrack-9bf44',)
     );
   }

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
      autoStartOnBoot: false,
      // initialNotificationContent: "Preparing",
      //     initialNotificationTitle: "Background Service",
      //     notificationChannelId: "123"
      ));
  service.startService();
}

@pragma("vm:entry-point")
Future<void> overlayMain() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
       home: ServiceOverlay(),
      // getPages: AppPages.routes,
      // initialRoute: Routes.serviceOverlay,
    ),
  );
}


class MyApp extends StatelessWidget {
  String initial;

  MyApp(this.initial, {super.key});



// Create Alice with the navigator key

   static Alice alice = Alice(configuration: AliceConfiguration(
       navigatorKey: Alice().getNavigatorKey(),
    showNotification: true,
      showInspectorOnShake: true,

  ));

   static AliceDioAdapter aliceDioAdapter = AliceDioAdapter();


  // static Alice alice = Alice(
  //   showNotification: true,
  //   showInspectorOnShake: true,
  // );

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
