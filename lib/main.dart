import 'package:alice/alice.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geotrack24fsc/helpers/colors.dart';
import 'package:geotrack24fsc/routes/app_pages.dart';
import 'package:geotrack24fsc/routes/app_routes.dart';

import 'package:geotrack24fsc/utils/session.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //debugPaintSizeEnabled = true; for layout bound
  //check session
  await GetStorage.init();

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
